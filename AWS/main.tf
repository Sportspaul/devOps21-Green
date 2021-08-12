provider "aws" {
  profile = "default"
  region  = "eu-north-1"
  
}

resource "aws_instance" "web" {
  ami           = "ami-00888f2a5f9be4390"
  instance_type = "t3.micro"
  
}

resource "aws_vpc" "test1" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "test2" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_vpc_peering_connection" "foo" {
  #peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.test1.id
  vpc_id        = aws_vpc.test2.id
}

resource "aws_vpc_peering_connection" "foo2" {
  #peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.test2.id
  vpc_id        = aws_vpc.test1.id
}