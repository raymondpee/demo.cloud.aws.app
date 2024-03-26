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