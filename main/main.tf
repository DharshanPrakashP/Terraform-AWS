provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "tf-rp-states"
    key    = "dharshan/terraform.tfstate"
    region = "us-east-1"
  }
}

module "lambda" {
  source = "./modules/lambda"

  # Pass variables to the lambda module
  role_arn      = aws_iam_role.ttt.arn
  function_name = "Test-lambda"
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  filename      = "python/lambda_function.zip"

}

# Define other resources or modules here if required
