# Variable que contiene el perfil de usuario default de AWS
variable "aws_profile_name" {
  description = "Perfil de AWS"
  default     = "default"
}

# Variable que contiene la región default de AWS
variable "aws_region" {
  description = "Región AWS para despliegue de una instancia"
  default   = "us-east-1"
}

# Variable que contiene la zona de disponibilidad
variable "availability_zone" {
  type = string
  default = "us-east-1a"
}

# Variable que contiene el tipo de instancia de AWS para Windows
variable "instance_type_win" {
  description = "Tipo de instancia para EC2 (Windows)"
  default   =  "t2.micro"
}

# Variable que contiene el tipo de instancia de AWS para SUSE
variable "instance_type_suse" {
  description = "Tipo de instancia para EC2 (SUSE)"
  default   =  "t2.large"
}

# Variable que contiene el tipo de volumen para EBS
variable "volume_type" {
  description = "Tipo de volumen para EBS"
  type        = string
  default     = "gp2"
}

# Variable que contiene el tamaño del volumen para Windows
variable "volume_size_win" {
  description = "Tamaño del volumen para Windows"
  type        = string
  default     = "35"
}

# Variable que contiene el tamaño del volumen para SUSE
variable "volume_size_suse" {
  description = "Tamaño del volumen para SUSE"
  type        = string
  default     = "300"
}



