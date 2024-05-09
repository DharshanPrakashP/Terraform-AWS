provider "aws" {
region = "us-east-1"
}
# resource "aws_vpc" "kaaraalan" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "kaaraalan"
#   }
# }
  
# resource "aws_subnet" "subnet_test" {
#   vpc_id = aws_vpc.kaaraalan.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name = "subnet_test"
  
# }
# }
# resource "aws_security_group" "security_kaaraalan" {
#   name = "kaaraalan"
#   description = "kaaraalan"
#   vpc_id = aws_vpc.kaaraalan.id
#   tags = {
#     Name = "security_kaaraalan"
#   }
#   ingress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#   }
#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
    
  
#   }


# }
# resource "aws_instance" "kalan" {
#   ami = "ami-0092a7ee6b8b2222a"
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.subnet_test.id
#   tags = {
#     Name = "kalan"
#   }
  # vpc_security_group_ids = [aws_security_group.security_kaaraalan.vpc_id]
  
# }


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
# //fix-code
resource "aws_lambda_function" "lambdajaya" {
  filename = "./python/lambda_function.zip"
  role = aws_iam_role.kaaraalan.arn
  function_name = "fines"
  runtime = "python3.8"
  handler = "lambda_function.lambda_handler"
}