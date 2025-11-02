
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}_ec2-role"

  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}




resource "aws_iam_role_policy_attachment" "role_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}_ec2_profile"
  role = aws_iam_role.ec2_role.name
}



