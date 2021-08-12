provider "aws" {
  profile = "default"
  region  = "eu-north-1"
  
}
resource "aws_instance" "web" {
  ami           = "ami-00888f2a5f9be4390"
  instance_type = "t3.micro"
  
}
resource "aws_vpc" "test1" {
  cidr_block = "10.0.1.0/24"
  
}
resource "aws_vpc" "test2" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_vpc_peering_connection" "foo" {
  peer_owner_id = "258004362035" 
  peer_vpc_id   = aws_vpc.test1.id
  vpc_id        = aws_vpc.test2.id
}
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws"
  vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}