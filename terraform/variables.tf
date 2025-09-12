variable "project_name" {
  description = "Project name"
  type        = string
  default     = "ssm_ec2"
}
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}


variable "instance_type" {
  description = "Default ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "Default ec2 ami"
  type        = string
  default     = "ami-020cba7c55df1f615"
}

variable "vpc_cidr_block" {
  description = "Default vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Default subnet cidr block"
  type        = string
  default     = "10.0.1.0/24"
}




