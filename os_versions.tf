#Obtener la AMI más reciente de SUSE Linux Server
data "aws_ami" "suse-server" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["suse-sles-sap-15-sp3-*"]
  }
    filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Obtener la AMI más reciente de Windows Server 2022
data "aws_ami" "windows-2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}


