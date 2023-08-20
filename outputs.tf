# Generación de outputs
output "key_pair_name" {
  value = aws_key_pair.key_pair.key_name
}

output "key_pair_public_key" {
  value = aws_key_pair.key_pair.public_key
}

output "aws_profile_name" {
  value = var.aws_profile_name
}

output "aws_region" {
  value = var.aws_region
}

output "instance_type_win" {
  value = var.instance_type_win
}

output "instance_type_suse" {
  value = var.instance_type_suse
}

output "volume_type" {
  value = var.volume_type
}

output "volume_size_win" {
  value = var.volume_size_win
}

output "volume_size_suse" {
  value = var.volume_size_suse
}



output "security_group_name_suse" {
  value = aws_security_group.security_group_suse.name
}

output "security_group_description_suse" {
  value = aws_security_group.security_group_suse.description
}

output "security_group_name_winserv" {
  value = aws_security_group.security_group_winserv.name
}

output "security_group_description_winserv" {
  value = aws_security_group.security_group_winserv.description
}


output "ami_suse_server" {
  value = data.aws_ami.suse-server.id
}

output "ami_windows_2022" {
  value = data.aws_ami.windows-2022.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id_suse" {
  value = aws_subnet.subnet_suse.id
}
output "subnet_id_winserv" {
  value = aws_subnet.subnet_windows.id
}

output "windows_server_instance_id" {
  value = aws_instance.windows_server.id
}

output "suse_server_instance_id" {
  value = aws_instance.suse_server.id
}

output "variable_key-pair" {
  value = random_pet.my_name.id
}