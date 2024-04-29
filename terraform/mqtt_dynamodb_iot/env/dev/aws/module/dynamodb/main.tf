# Define DynamoDB table
resource "aws_dynamodb_table" "iotdemo_dynamodb_table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
  hash_key       = var.dynamodb_hash_key
  range_key      = var.dynamodb_range_key

  attribute {
    name = var.dynamodb_hash_key
    type = "N"
  }

  attribute {
    name = var.dynamodb_range_key
    type = "N"
  }
}
