# Configuración de restricciones de versión para el proveedor
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.59"  # Versión actualizada del proveedor aws
    }
  }
 
  required_version = ">= 1.0.0"  # Versión mínima requerida de Terraform
}

# Definición del proveedor de AWS
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile_name
}

# Recurso para crear una instancia de Windows Server
resource "aws_instance" "windows_server" {
  ami                    = data.aws_ami.windows-2022.id
  instance_type          = var.instance_type_win
  availability_zone      = var.availability_zone
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = aws_subnet.subnet_windows.id
  vpc_security_group_ids = [aws_security_group.security_group_winserv.id]

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size_win
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }
  
  user_data = <<-EOF
    powershell -command "
      Install-WindowsFeature Server-Gui-Mgmt-Tools
      New-LocalUser sap -Password (ConvertTo-SecureString -String sap -AsPlainText -Force)
      Exit"
    EOF
    
  tags = {
    "Name" = "WIN Server"
  }
}

# Recurso para crear una instancia de SUSE Server
resource "aws_instance" "suse_server" {
  ami                    = data.aws_ami.suse-server.id
  instance_type          = var.instance_type_suse
  availability_zone      = var.availability_zone
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = aws_subnet.subnet_suse.id
  vpc_security_group_ids = [aws_security_group.security_group_suse.id]
  
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size_suse
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }
  
  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_type           = var.volume_type
    volume_size           = var.volume_size_suse
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_type           = var.volume_type
    volume_size           = var.volume_size_suse
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo mdadm --create /dev/md0 --level=5 --raid-devices=4 /dev/xvdf /dev/xvdg --assume-clean
    sudo mkfs.ext4 /dev/md0
    sudo mkdir /data
    sudo mount /dev/md0 /data
    echo '/dev/md0 /data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab
    sudo mount -a
    EOF

  tags = {
    "Name" = "SUSE Server"
  }
}

# Creación de una Elastic IP para la instancia de Windows Server
resource "aws_eip" "instance_eip" {
  instance = aws_instance.windows_server.id
}

# Asociación de la Elastic IP creada con la instancia de Windows Server
resource "aws_eip_association" "instance_eip_association" {
  instance_id          = aws_instance.windows_server.id
  allocation_id        = aws_eip.instance_eip.id
  allow_reassociation = true
}