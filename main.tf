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
# definición del proveedor de aws
provider "aws" {
  region              = "${var.aws_region}"
  profile             = "${var.aws_profile_name}"

}

resource "aws_instance" "windows_server" {
  ami                    = data.aws_ami.windows-2022.id
  instance_type          = var.instance_type_win
  availability_zone      = "us-east-1a"
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  private_ip             = var.windows_server_ip
  associate_public_ip_address = true
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size_win
    delete_on_termination = false
     }
    tags = {
    "Name" = "WIN Server"
  }
}

resource "aws_instance" "suse_server" {
  ami                    = data.aws_ami.suse-server.id
  instance_type          = var.instance_type_suse
  availability_zone      = "us-east-1a"
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids     = [aws_security_group.security_group.id]
  private_ip             = var.suse_server_ip
  associate_public_ip_address = true
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size_suse
    delete_on_termination = false
    }

  tags = {
    "Name" = "SUSE Server"
  }
}