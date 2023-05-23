
# genera una clave privada segura utilizando el algoritmo RSA con una longitud de 4096 bits y la codifica en formato PEM
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# crea un par de claves en AWS utilizando el nombre especificado
resource "aws_key_pair" "key_pair" {
  key_name   = "${lower(var.app_name)}-${lower(var.app_environment)}-windows-${lower(var.aws_region)}"  
  public_key = tls_private_key.key_pair.public_key_openssh
}

# guarda el archivo de clave privada localmente
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.key_pair.private_key_pem
}