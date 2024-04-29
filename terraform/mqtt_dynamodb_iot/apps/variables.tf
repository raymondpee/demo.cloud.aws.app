# Define input variables
variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "iot_rule_name" {
  description = "Name of the IoT rule to DynamoDB"
  type        = string
  default     = "iotdemo_rule_dynamodb_test"
}

variable "iot_rule_description" {
  description = "Description of the IoT rule to DynamoDB"
  type        = string
  default     = "Rule to DynamoDB"
}

variable "iot_sql" {
  description = "SQL query for the IoT rule"
  type        = string
  default     = "SELECT * FROM 'car/+/sensor'"
}

variable "iot_sql_version" {
  description = "SQL version for the IoT rule"
  type        = string
  default     = "2016-03-23"
}

