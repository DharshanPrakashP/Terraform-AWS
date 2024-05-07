provider "aws" {
  region = "ap-south-1"
}
# resource "aws_iam_role" "lambda-test" {
#   name = "lambda-test"
#   assume_role_policy = <<EOF
#  {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": [
#           "lambda.amazonaws.com"
#         ]
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
  
# }

# resource "aws_lambda_function" "lambda-test" {
#   filename = "python/lambda_function.zip"
#   role = aws_iam_role.lambda-test.arn
#   function_name = "lambda-test"
#   handler = "lambda_function.lambda_handler"
#   runtime = "python3.8"
# }
resource "aws_vpc" "vpctest" {
  cidr_block = "10.0.0.0/16"
  
}
resource "aws_security_group" "test_sec" {
  vpc_id = aws_vpc.vpctest.id
  ingress = {
    from_port = 0
    to_port = 0
    
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
  }
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
  }
}
resource "aws_subnet" "test_subnet" {
  vpc_id = aws_vpc.vpctest.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  
}
resource "aws_instance" "instest" {
  ami = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.test_subnet.id
 # vpc_security_group_ids = [aws_security_group.test_sec.id]
}
  