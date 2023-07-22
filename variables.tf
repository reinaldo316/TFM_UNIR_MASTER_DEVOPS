#varible que contiene el perfil de usuario default de AWS
variable "aws_profile_name" {
  description = "perfil de AWS"
  default     = "default"
}
#varible que contiene la region default de AWS
variable "aws_region" {
  description = "Region AWS para despliegue de una instancia"
  default   = "us-east-1"
}
#varible que contiene el tipo de instancia de AWS
variable "instance_type_win" {
  description = "tipo de instancia para ec2"
  default   =  "t2.micro"
}
#varible que contiene el tipo de instancia de AWS
variable "instance_type_suse" {
  description = "tipo de instancia para ec2"
  default   =  "t2.large"
}

variable "volume_type" {
  description = "Tipo de volumen"
  type        = string
  default     = "gp2"
}

variable "volume_size_win" {
  description = "Tamaño del volumen"
  type        = string
  default     = "35"
}
variable "volume_size_suse" {
  description = "Tamaño del volumen"
  type        = string
  default     = "35"
}


variable "windows_server_ip" {
  description = "Dirección IP para el servidor Windows Server"
  default     = "10.0.0.10"
}

variable "suse_server_ip" {
  description = "Dirección IP para el servidor SUSE Server"
  default     = "10.0.0.11"
}
