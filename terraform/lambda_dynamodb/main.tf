provider "aws" {
  region = "ap-southeast-1"  # Change the region as needed
}

data "aws_iam_policy_document" "lambda_assum_role_policy"{
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {  
  name = "lambda-lambdaRole-waf"  
  assume_role_policy = data.aws_iam_policy_document.lambda_assum_role_policy.json
}


data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/main.py" 
  output_path = "main.zip"
}

resource "aws_lambda_function" "hello_world_lambda" {
  filename         = "main.zip"  # Update with your Lambda function code zip file
  function_name    = "hello-world-lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.lambda_handler"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  runtime          = "python3.8"  # Update runtime if using a different language
  timeout       = 10
}

resource "aws_cloudwatch_event_rule" "test-lambda" {
  name                  = "run-lambda-function"
  description           = "Schedule lambda function"
  schedule_expression   = "rate(60 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda-function-target" {
  target_id = "lambda-function-target"
  rule      = aws_cloudwatch_event_rule.test-lambda.name
  arn       = aws_lambda_function.hello_world_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.hello_world_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.test-lambda.arn
}

resource "aws_dynamodb_table" "camera" {
  name           = "ExampleTable"  # Replace with your desired table name
  billing_mode   = "PAY_PER_REQUEST"  # Specify the billing mode (PROVISIONED or PAY_PER_REQUEST)
  hash_key       = "Id"  # Replace with your desired partition key attribute name
  attribute {
    name = "Device Id"  # Replace with your desired partition key attribute name
    type = "S"  # Data type of the partition key attribute (S: String, N: Number, B: Binary)
  }
  attribute {
    name = "Timestamp"  # Example of adding another attribute (optional)
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }
  attribute {
    name = "Action"  # Example of adding another attribute (optional)
    type = "S"  # Example of adding another attribute with numeric data type (optional)
  }
}

resource "aws_dynamodb_table" "telematics" {
  name           = "TelematicsTable"  # Replace with your desired table name
  billing_mode   = "PAY_PER_REQUEST"  # Specify the billing mode (PROVISIONED or PAY_PER_REQUEST)
  hash_key       = "DeviceID"  # Replace with your desired partition key attribute name

  attribute {
    name = "DeviceID"
    type = "S"  # Data type of the partition key attribute (S: String, N: Number, B: Binary)
  }

  attribute {
    name = "Timestamp"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Latitude"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Longitude"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Altitude"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Speed"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Heading"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Accuracy"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "AccelerationX"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "AccelerationY"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "AccelerationZ"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "GyroscopeX"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "GyroscopeY"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "GyroscopeZ"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Roll"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Pitch"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }

  attribute {
    name = "Yaw"
    type = "N"  # Example of adding another attribute with numeric data type (optional)
  }
}