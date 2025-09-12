resource "aws_instance" "instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.private_subnet.id
  security_groups      = [aws_security_group.ssm_sg.id, aws_security_group.egress_endpoint_sg.id, ]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "${var.project_name}_instance"
  }
}



