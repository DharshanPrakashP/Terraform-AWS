provider "aws" {
  region = "ap-south-1"

  
}
resource "aws_iam_role" "test-lambda" {
  name = "test-lambda"
  assume_role_policy = <<EOF
 {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  
}

resource "aws_lambda_function" "test-lambda" {
  filename = "python/lambda_function.zip"
  role = aws_iam_role.test-lambda.arn
  function_name = "test-lambda"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.8"
}
