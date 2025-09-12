resource "aws_vpc" "main_vpc" {
  cidr_block                       = var.vpc_cidr_block
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "${var.project_name}_vpc"
  }

}


resource "aws_subnet" "private_subnet" {
  vpc_id                          = aws_vpc.main_vpc.id
  cidr_block                      = var.subnet_cidr_block
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main_vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true
  availability_zone               = "${var.region}a"

  tags = {
    Name = "${var.project_name}_subnet"
  }
}


resource "aws_egress_only_internet_gateway" "main" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}_egress_gateway"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}_private_route_table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id


}

resource "aws_route" "private_subnet_ipv6_route" {
  route_table_id              = aws_route_table.private_route_table.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.main.id

}



resource "aws_security_group" "egress_endpoint_sg" {
  name        = "Allow egress endpoint"
  description = "Allow traffic from egress endpoint"
  vpc_id      = aws_vpc.main_vpc.id
  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]

    description = "allow outbound traffic"
  }

  tags = {
    Name = "${var.project_name}_egress_sg"
  }
}

resource "aws_security_group" "ssm_sg" {
  name        = "endpoint_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]

    description = "Enable access for ssm endpoint."
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]

    description = "allow outbound traffic"
  }


  tags = {
    Name = "${var.project_name}_ssm_sg"
  }
}



resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.ssm_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}_ssm_endpoint"
  }
}
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.ssm_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}_ec2messages_endpoint"
  }
}
resource "aws_vpc_endpoint" "messages" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.ssm_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}_messages_endpoint"
  }
}





