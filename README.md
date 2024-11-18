Terraform code for kubernetes

##############################
## K8s Deployment Process ##
##############################

Prequisites: 
  - aws configuration does with needful access
Initialize the terraform directory
>      cd Terraform
>      terraform init

Create infrastructure

   i) First create vpc and subnet only using this command 
>      terraform plan -var-file dev.tfvars -target module.vpc.aws_vpc.this -target module.vpc.aws_subnet.this
>      terraform apply -var-file dev.tfvars -target module.vpc.aws_vpc.this -target module.vpc.aws_subnet.this
  ii) Then run the application using this command 
>     terraform plan -var-file dev.tfvars
>     terraform apply -var-file dev.tfvars
         
Delete infrastructure

>     terraform destroy -var-file dev.tfvars
