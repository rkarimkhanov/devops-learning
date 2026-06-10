variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux"
  type        = string
  default     = "ami-00e801948462f718a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of your EC2 key pair"
  type        = string
  default     = "demo-key"  
}