#create a ec2 machine in aws vpc fgtvm-vpc

resource "aws_instance" "ems-server" {
  ami           = "ami-0e55bea17017152fb"
  instance_type = var.ems_size
  key_name      = var.keyname
  subnet_id     = aws_subnet.privatesubnetaz1.id
  tags = {
    Name = "EMS-SERVER"
  }
}


# security group for ems-seerver

resource "aws_security_group" "ems-server" {
  name        = "ems-server"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.fgtvm-vpc.id

  ingress {
    description = "RDP"
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

resource "aws_network_interface_sg_attachment" "sg_ems_server" {
  security_group_id    = aws_security_group.ems-server.id
  network_interface_id = aws_instance.ems-server.primary_network_interface_id
}
