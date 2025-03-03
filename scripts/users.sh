username="ant3"
password="Ans@123"

touch /etc/sudoers.d/$username
# Check if user already exists
if id $username &>/dev/null; then
    echo "User $username already exists!" >&2
    exit 1
fi

#!/bin/bash

file= /etc/sysconfig/iptables.BK
if [ -e $file ]; then
    echo "File exists. Setting permissions..."
else
    echo "File does not exist. Creating file..."
    touch $file
fi

temp = /etc/sysconfig/temp


# Create the user
useradd -m -s /bin/bash $username
echo "User $username created successfully."

echo $username:$password | chpasswd

echo "Password set successfully."
chown $username /etc/sysconfig/ 
chown $username $temp
chown $username /etc/sysconfig/iptables
chown $username /etc/sysconfig/iptables.BK
# Add the user to the group
sudo usermod -aG root $USERNAME

echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl  start  iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl reload iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl reload iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl restart iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl  start  iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl status iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl  status  iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /bin/systemctl is-active iptables"| sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /usr/bin/systemctl is-active iptables"| sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /usr/bin/systemctl is-inactive iptables"| sudo tee -a /etc/sudoers.d/$username > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl is-inactive iptables" | sudo tee -a /etc/sudoers.d/$username > /dev/null

echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl  start  iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl reload iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl reload iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl restart iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl  start  iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl status iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl  status  iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /bin/systemctl is-active iptables"| sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /usr/bin/systemctl is-active iptables"| sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /bin/systemctl is-inactive iptables"| sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD:  /usr/bin/systemctl is-inactive iptables"| sudo tee -a /etc/sudoers > /dev/null
