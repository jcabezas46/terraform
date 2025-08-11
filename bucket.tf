resource "aws_s3_bucket" "proveedores" {
  bucket = "bt377exam-${random_string.sufijo[count.index].id}"
  count  = 5
  tags = {
    oficina     = "digital"
    Environment = "Dev"
    propietario = "jhoan"

  }
}


resource "random_string" "sufijo" {
  count   = 5
  length  = 21
  special = false
  upper   = false
  numeric = false
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "main"
  }
}




resource "aws_route_table" "accesointernet" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "example"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.accesointernet.id
}


resource "aws_security_group" "ssh" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id
  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = "179.32.130.178/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

