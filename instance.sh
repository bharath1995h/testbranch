#!/bin/bash
echo enter the keypair name
read mykeypair
#step 1: create a keypair
aws ec2 create-key-pair --key-name $mykeypair  --query 'KeyMaterial' --output text > $mykeypair.pem

echo enter the securitygroup name
read sg
#step 2 : craete a security group
sgid=$(aws ec2 create-security-group --group-name $sg --description "My security group" --vpc-id vpc-c40d89b9)


#step3: add port no to security groups:
aws ec2 authorize-security-group-ingress --group-name $sg --protocol tcp --port 22 --cidr 0.0.0.0/0

echo enter the AMI ID
read ami
#step 4:create a instace:
aws ec2 run-instances --image-id $ami --count 1 --instance-type t2.micro --key-name $mykeypair --security-group-ids $sgid  --subnet-id subnet-1ea51a2f

