username="ans2"
password="Ans@123"

touch /etc/sudoer.d/$username
# Check if user already exists
if id $username &>/dev/null; then
    echo "User $username already exists!" >&2
    exit 1
fi

# Create the user
useradd -m -s /bin/bash $username
echo "User $username created successfully."

echo $username:$password | chpasswd

echo "Password set successfully."

chown $username /etc/sysconfig/iptables
# Add the user to the group
sudo usermod -aG root $USERNAME

echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl  start  iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl reload iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl reload iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl restart iptables" | sudo tee -a /etc/sudoers > /dev/null
echo "$username  ALL=(ALL) NOPASSWD: /bin/systemctl  start  iptables" | sudo tee -a /etc/sudoers > /dev/null