resource "aws_vpc" "vpc_suse" {
  cidr_block = "10.1.1.0/16"
}

resource "aws_subnet" "subnet_suse" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.1.1.0/24"
   availability_zone = "us-east-1a" 
}

resource "aws_vpc" "vpc_ws" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_ws" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
   availability_zone = "us-east-1a" 
}