# Main configuration file

# Include other Terraform files
terraform {
  required_version = ">= 0.12"
}

# Specify provider configuration
provider "aws" {
  region = var.region
}

# Include other Terraform files
module "aws_iot" {
  source = "./../env/dev/aws/module/iot"
}

module "dynamodb_module" {
  source = "./../env/dev/aws/module/dynamodb"
}


# IoT Rule to DynamoDB
resource "aws_iam_role" "iotdemo_iot_dynamodb_role" {
  name = "iot_dynamodb_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "iot.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "dynamodb_put_item_policy" {
  name        = "dynamodb_put_item_policy"
  description = "Allows PutItem action in DynamoDB"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "dynamodb:PutItem"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "dynamodb_put_item_attachment" {
  name       = "dynamodb_put_item_attachment"
  roles      = [aws_iam_role.iotdemo_iot_dynamodb_role.name]
  policy_arn = aws_iam_policy.dynamodb_put_item_policy.arn
}

resource "aws_iot_topic_rule" "iotdemo_rule_dynamodb" {
  name        = var.iot_rule_name
  description = var.iot_rule_description
  enabled     = true
  sql         = var.iot_sql
  sql_version = var.iot_sql_version

  dynamodb {
    table_name      = module.dynamodb_module.table_name
    role_arn        = aws_iam_role.iotdemo_iot_dynamodb_role.arn
    hash_key_field  = module.dynamodb_module.dynamodb_hash_key
    hash_key_value  = "$${timestamp()}"
    hash_key_type    = "NUMBER" # Partition key type
    range_key_field = module.dynamodb_module.dynamodb_range_key
    range_key_value = "$${topic(2)}"
    range_key_type   = "NUMBER" # Sort key type
    operation       = "INSERT"
    payload_field   = "payload"
  }
}
