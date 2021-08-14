#!/bin/bash

#-----------Deploy to AWS EC2 instance-----------
#ansible-playbook -i scripts/ec2.py main.yml

#-----------Deploy to Home Virtual Host---------
ansible-playbook -i inventory/hosts main.yml
