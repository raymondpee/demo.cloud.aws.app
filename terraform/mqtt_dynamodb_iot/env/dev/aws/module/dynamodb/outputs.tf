output "table_name" {
  value = aws_dynamodb_table.iotdemo_dynamodb_table.name
}

output "arn"{
  value = aws_dynamodb_table.iotdemo_dynamodb_table.arn
}

output "dynamodb_hash_key" {
  value = aws_dynamodb_table.iotdemo_dynamodb_table.hash_key
}

output "dynamodb_range_key" {
  value = aws_dynamodb_table.iotdemo_dynamodb_table.range_key
}