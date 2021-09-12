Terraform Template for IAM

Pre-Requisites:
    1. Terraform 0.13.5 or higher installed on the machine.
    2. AWS profile credentials configured with Admin rights.

Deploying the Module: 

    Step 1: Initialize Terraform with command: "terraform init"
    Step 2: Fill up the variables in the file named "env.tfvars"
    Step 3: Run the command to deploy: "terraform apply --var-file=env.tfvars"
