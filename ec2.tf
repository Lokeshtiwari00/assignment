resource "aws_security_group" "demo_var" {

name = "demo_var"
vpc_id = "vpc-036ca802fe01f782f"

ingress {
        description = "Demo-SG"
        from_port = 19999
        to_port = 19999
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
ingress {
        description = "Demo-SG"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
ingress {
        description = "Demo-SG"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

}
resource "aws_instance" "centos_instance" {
  ami = "ami-026ebd4cfe2c043b2"
  instance_type = "t2.micro"
  key_name = "npmkey"
  security_groups = [aws_security_group.demo_var.id]
  subnet_id = "subnet-03cb7df9a5df33b18"

  tags = {
    Name = "c8.local"
  }
user_data = <<EOF
#!/bin/bash
sed -i '/^PasswordAuthentication/s/no/yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config
systemctl restart sshd
echo "redhat" | passwd --stdin root
hostnamectl set-hostname c8.local
EOF
}

output "frontend_ip" {
  value = aws_instance.centos_instance.public_ip
}

resource "aws_instance" "ubuntu_instance" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "npmkey"
  security_groups = [aws_security_group.demo_var.id]
  subnet_id = "subnet-03cb7df9a5df33b18"
  tags = {
    Name = "u21.local"
  }
user_data = <<EOF
#!/bin/bash
sed -i '/^PasswordAuthentication/s/no/yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config
systemctl restart sshd
echo "root:redhat" | sudo chpasswd
hostnamectl set-hostname u21.local
EOF
}

output "backend_ip" {
  value = aws_instance.ubuntu_instance.public_ip
}
