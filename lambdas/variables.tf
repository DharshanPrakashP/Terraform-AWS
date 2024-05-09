variable "role_arn" {
  description = "The ARN of the IAM role for Lambda"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "handler" {
  description = "The entry point for the Lambda function"
  type        = string
}

variable "filename" {
  description = "The path to the deployment package of the Lambda function"
  type        = string
}
