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

data "aws_caller_identity" "current" {}

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
  
    ebs_block_device {
    device_name           = "/dev/sdh"
    volume_type           = var.volume_type
    volume_size           = var.volume_size_suse
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }

  ebs_block_device {
    device_name           = "/dev/sdi"
    volume_type           = var.volume_type
    volume_size           = var.volume_size_suse
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }

    ebs_block_device {
    device_name           = "/dev/sdj"
    volume_type           = var.volume_type
    volume_size           = var.volume_size_suse
    delete_on_termination = false
    encrypted             = true  # Encriptar el volumen EBS
  }

  user_data = <<-EOF
    #!/bin/bash
    # Configurar RAID 5 entre root block device, /dev/sdf y /dev/sdg
    mdadm --create --verbose /dev/md0 --level=5 --raid-devices=3 /dev/xvda /dev/sdf /dev/sdg
    mkfs.ext4 /dev/md0
    echo '/dev/md0  /mnt/raid5_1  ext4  defaults,nofail  0  2' >> /etc/fstab
    mount -a

    # Configurar RAID 5 entre /dev/sdh, /dev/sdj y /dev/sdk
    mdadm --create --verbose /dev/md1 --level=5 --raid-devices=3 /dev/sdh /dev/sdj /dev/sdk
    mkfs.ext4 /dev/md1
    echo '/dev/md1  /mnt/raid5_2  ext4  defaults,nofail  0  2' >> /etc/fstab
    mount -a

    # Configurar RAID 0 entre /dev/md0 y /dev/md1 y asignarlo como disco raíz
    mdadm --create --verbose /dev/md2 --level=0 --raid-devices=2 /dev/md0 /dev/md1
    mkfs.ext4 /dev/md2
    mount /dev/md2 /
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