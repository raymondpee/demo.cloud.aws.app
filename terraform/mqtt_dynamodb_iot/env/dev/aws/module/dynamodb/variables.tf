variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "caedge_iot_dynamodb_table"
}

variable "dynamodb_read_capacity" {
  description = "Read capacity units for the DynamoDB table"
  type        = number
  default     = 5
}

variable "dynamodb_write_capacity" {
  description = "Write capacity units for the DynamoDB table"
  type        = number
  default     = 5
}

variable "dynamodb_hash_key" {
  description = "Name of the hash key for the DynamoDB table"
  type        = string
  default     = "timestamp"
}

variable "dynamodb_range_key" {
  description = "Name of the range key for the DynamoDB table"
  type        = string
  default     = "carId"
}
