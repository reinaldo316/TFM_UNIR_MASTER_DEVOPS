terraform {

#configuración de restricciones de versión para el proveedor 
  required_providers {
    aws = {
    source  = "hashicorp/aws"

    version = "~> 3.27"

    }
  }


  required_version = ">= 0.14.9"

}
# definición del proveedor de aws
provider "aws" {
  region              = "${var.aws_region}"
  profile             = "${var.aws_profile_name}"

}

resource "aws_instance" "windows_server" {
  ami                    = data.aws_ami.windows-2022.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = aws_subnet.subnet.id
  security_group_ids     = [aws_security_group.security_group.id]
  private_ip             = var.windows_server_ip
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    delete_on_termination = false
     }
}

resource "aws_instance" "suse_server" {
  ami                    = data.aws_ami.suse-server.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = aws_subnet.subnet.id
  security_group_ids     = [aws_security_group.security_group.id]
  private_ip             = var.suse_server_ip
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    delete_on_termination = false
    }
}