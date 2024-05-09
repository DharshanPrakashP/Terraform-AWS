
resource "aws_iam_role" "ttt" {
  name               = "test-role"
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

resource "aws_iam_role_policy" "ttt" {
  name = "test-role-policy"
  role = aws_iam_role.ttt.id
  policy = <<EOF
{
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
}
EOF
}

resource "aws_lambda_function" "on_boarding_lambda" {
  # s3_bucket = var.config_bucket
  # s3_key    = var.on_boarding_lambda_config_path
  filename      = "python/lambda_function.zip"
  function_name = "Test-lambda"
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  # layers        = [aws_lambda_layer_version.lambda_layer.arn, aws_lambda_layer_version.lambda_layer_2.arn]
  role          = aws_iam_role.ttt.arn
}
