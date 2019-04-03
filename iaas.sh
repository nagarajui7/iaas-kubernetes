num=$1
#number of vm's to be created
sed -i "s/count =.*/count = $num/g" main.tf

#vm creation
terraform init
terraform plan -out out.terraform
terraform apply out.terraform

#list of vm's created
gcloud compute instances list | awk '{print $5}'

