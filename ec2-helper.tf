# EC2 Instance to Upload NGINX Config
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instance to upload NGINX config"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "conf_uploader" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = element(data.aws_subnets.default.ids, 0)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  
  user_data = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nfs-common 
sudo mkdir -p /mnt/efs
sudo sh -c "cd /mnt && mount -t nfs4 -o nfsvers=4.1 ${aws_efs_file_system.nginx_efs.dns_name}:/ efs"
# Create the directory for NGINX configuration and write default.conf
sudo mkdir -p /mnt/efs/nginx/conf.d
sudo bash -c 'cat <<EOC > /mnt/efs/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    error_page 404 /404.html;
    location = /404.html {
        root /usr/share/nginx/html;
    }
}
EOC'

# Wait a few seconds to ensure file write completion
sleep 10
sudo umount /mnt/efs
EOF

  tags = {
    Name = "EFS-HELPER"
  }
}
