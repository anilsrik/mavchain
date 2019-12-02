gcloud config set account anil@mavblockchain.com
gcloud config set project decoded-core-251710
glcoud config set zone us-east1-c
gcloud init
INSTANCE_NAME="hyperledger-fabric-01"
if gcloud compute instances list | grep -q $INSTANCE_NAME
then
 echo $INSTANCE_NAME + " is already created";
else
 echo $INSTANCE_NAME + " not found and will be created";
 gcloud compute instances create $INSTANCE_NAME  --image-family ubuntu-1804-lts --image-project ubuntu-os-cloud;
 echo $INSTANCE_NAME + " instance created successfully";

INSTANCE_IP=$(gcloud compute instances list | awk '/'$INSTNACE_NAME'/ {print $5}')
if nc -w 1 -z $IP 22; then
    echo "Instance is started and SSH port is open";
else
    echo "Starting instance " + $INSTANCE_NAME
    gcloud compute instances start $INSTANCE_NAME;
fi

echo "SSH to " + $INSTANCE_NAME
gcloud compute ssh $INSTANCE_NAME
