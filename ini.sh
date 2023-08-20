echo "[frontend]" > /opt/inventory.ini
/usr/local/bin/aws ec2 describe-instances --filters --region us-east-1 "Name=tag:Name,Values=c8.local" --query "Reservations[].Instances[].PublicIpAddress" --output=text >> /opt/inventory.ini
sed -i 's/^\([0-9.]*\)$/\1 ansible_ssh_user=root ansible_ssh_pass=redhat/' /opt/inventory.ini
echo "[backend]" >> /opt/inventory.ini
/usr/local/bin/aws ec2 describe-instances --filters --region us-east-1 "Name=tag:Name,Values=u21.local" --query "Reservations[].Instances[].PublicIpAddress" --output=text >> /opt/inventory.ini
sed -i 's/^\([0-9.]*\)$/\1 ansible_ssh_user=root ansible_ssh_pass=redhat/' /opt/inventory.ini

