Run Command For first set Up New IP Tables 
inventory.ini add ssh details
main.yml uses for Back Up, IP Tables checking and debuging

copy.yml uses for set up iptables with default rule.
/rule/input file can use for default IP Rule 

ansible-playbook -i inventory.ini scripts/main.yml  scripts/copy.yml 
