#create a ec2 machine in aws vpc fgtvm-vpc

resource "aws_instance" "ems-server" {
  ami          = "ami-0038eddb87f97ac2b"
  instance_type = var.size
  key_name      = var.keyname
  subnet_id     = aws_subnet.privatesubnetaz1.id
  security_groups = ["sg-0f6734b30cd3b1c26"]

}

# security group for ems-seerver

resource "aws_security_group" "ems-server" {
  name        = "ems-server"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.fgtvm-vpc.id

  ingress {
    description = "HTTP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
   # egresss all traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


}