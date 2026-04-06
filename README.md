Run Command For first set Up New IP Tables 
1. #inventory.ini is used to add ssh details
2. main.yml uses for Back Up, IP Tables checking and debuging

copy.yml uses for set up iptables with default rule.
/rule/input file can use for default IP Rule 

#new  Rule Setup
ansible-playbook -i inventory.ini scripts/main.yml  scripts/copy.yml 

#Input Edit on Ipables on centos 
ansible-playbook -i inventory.ini scripts/main.yml scripts/input_edit.yml

Input edit file for rule
