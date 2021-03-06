num=$1
echo '#####################gcloud authentication#####################'
gcloud auth activate-service-account --key-file /home/reddisekhara_n/iaas-provision-236417-83c0879798aa.json
export GOOGLE_CLOUD_KEYFILE_JSON=/home/reddisekhara_n/iaas-provision-236417-83c0879798aa.json

echo '######################number of vms to be created#####################'
sed -i "s/count =.*/count = $num/g" main.tf

echo '######################vm creation#####################'
terraform init
terraform plan -out out.terraform
terraform apply out.terraform

echo '######################list of vms created#####################'
gcloud compute instances list | awk '{print $5}' | sed 1d | sed 's/34.73.216.180//g' | sudo tee ip_list
cat ip_list

echo '######################updating the ansible hosts file#####################'
cat <<EOF > /home/reddisekhara_n/iaas-kubernetes/final_list
[master]
`sed -n '1p' ip_list`
[nodes]
`sed -e '1d' ip_list`
[others]
EOF
cat /home/reddisekhara_n/iaas-kubernetes/final_list | sudo tee /etc/ansible/hosts 

