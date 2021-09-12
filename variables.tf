# Variables used in the module

variable "aws_region" {
  description = "The AWS region resources are created in"
  default = "us-west-2"
}

variable "aws_profile" {
  
}

variable name {
  type        = string
  default     = ""
  description = "Name to be given on resources"
}
