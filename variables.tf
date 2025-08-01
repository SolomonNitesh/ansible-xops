variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "eu-north-1"
}
 
variable "ami_id" {
  description = "AMI ID for Ubuntu"
  type        = string
  default     = "ami-01637463b2cbe7cb6" # Ubuntu (Free Tier in eu-north-1)
}
 
variable "key_pair_name" {
  description = "ansible-xops"
  type        = string
}