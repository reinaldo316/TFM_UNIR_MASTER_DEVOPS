# Generación de salidas (outputs) para información relevante del despliegue

# Salida del nombre del par de claves
output "key_pair_name" {
  value = aws_key_pair.key_pair.key_name
}

# Salida de la clave pública del par de claves
output "key_pair_public_key" {
  value = aws_key_pair.key_pair.public_key
}

# Salida del nombre del perfil de usuario de AWS
output "aws_profile_name" {
  value = var.aws_profile_name
}

# Salida de la región de AWS
output "aws_region" {
  value = var.aws_region
}

# Salida del tipo de instancia para Windows
output "instance_type_win" {
  value = var.instance_type_win
}

# Salida del tipo de instancia para SUSE
output "instance_type_suse" {
  value = var.instance_type_suse
}

# Salida del tipo de volumen para EBS
output "volume_type" {
  value = var.volume_type
}

# Salida del tamaño del volumen para Windows
output "volume_size_win" {
  value = var.volume_size_win
}

# Salida del tamaño del volumen para SUSE
output "volume_size_suse" {
  value = var.volume_size_suse
}

# Salidas para nombres y descripciones de grupos de seguridad

# Nombre del grupo de seguridad para SAP SUSE Server
output "security_group_name_suse" {
  value = aws_security_group.security_group_suse.name
}

# Descripción del grupo de seguridad para SAP SUSE Server
output "security_group_description_suse" {
  value = aws_security_group.security_group_suse.description
}

# Nombre del grupo de seguridad para SAP Windows Server
output "security_group_name_winserv" {
  value = aws_security_group.security_group_winserv.name
}

# Descripción del grupo de seguridad para SAP Windows Server
output "security_group_description_winserv" {
  value = aws_security_group.security_group_winserv.description
}

# Salidas para IDs de recursos creados

# ID de la AMI de SUSE Server
output "ami_suse_server" {
  value = data.aws_ami.suse-server.id
}

# ID de la AMI de Windows Server 2022
output "ami_windows_2022" {
  value = data.aws_ami.windows-2022.id
}

# ID de la VPC creada
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# ID de la subred de SUSE
output "subnet_id_suse" {
  value = aws_subnet.subnet_suse.id
}

# ID de la subred de Windows Server
output "subnet_id_winserv" {
  value = aws_subnet.subnet_windows.id
}

# ID de la instancia de Windows Server
output "windows_server_instance_id" {
  value = aws_instance.windows_server.id
}

# ID de la instancia de SUSE Server
output "suse_server_instance_id" {
  value = aws_instance.suse_server.id
}

# Salida de la variable generada "variable_key-pair"
output "variable_key-pair" {
  value = random_pet.my_name.id
}
