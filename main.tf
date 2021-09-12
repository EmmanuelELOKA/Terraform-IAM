#Get AWS Account ID of AWS Account
data "aws_caller_identity" "current" {}

#To pass AWS Account ID of AWS Account
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

#Call the Module so terraform can identify it.
module "iam" {
  source = "./modules/iam"
  name = var.name
}