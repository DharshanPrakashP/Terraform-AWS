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

resource "aws_iam_role" "ttt" {
  name               = "test-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ttt" {
  name = "test-role-policy"
  role = aws_iam_role.ttt.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "on_boarding_lambda" {
  filename      = "python/lambda_function.zip"
  function_name = "Test-lambda"
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.ttt.arn
}
