echo '####################### creating ssh connection ######################'
num=$1
for (( i=0; i< $num; i++ ))
do
    gcloud compute scp ~/.ssh/id_rsa.pub terraform-$i:~/.ssh/authorized_keys --strict-host-key-checking=no --zone=asia-east1-a
done
for j in `cat ip_list`
do
  ssh-keygen -f "/home/reddisekhara_n/.ssh/known_hosts" -R $j
done

