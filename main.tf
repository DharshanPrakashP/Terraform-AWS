provider "aws" {
region = "ap-south-1"
}

resource "aws_iam_role" "kaaraalan" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
//fix-code
resource "aws_lambda_function" "lambdajaya" {
  filename = "./python/lambda_function.zip"
  role = aws_iam_role.kaaraalan.arn
  function_name = "fines"
  runtime = "python3.8"
  handler = "lambda_function.lambda_handler"
}