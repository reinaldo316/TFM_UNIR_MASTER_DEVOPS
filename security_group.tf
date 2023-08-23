# Definición del grupo de seguridad para SAP SUSE Server
resource "aws_security_group" "security_group_suse" {
  name        = "suse_security_group"
  description = "Grupo de seguridad para SAP SUSE Server"
  vpc_id      = aws_vpc.vpc.id

  # Reglas de entrada permitidas para SSH (puerto 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow SSH traffic"
  }

  # Reglas de entrada permitidas para HTTP (puerto 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow HTTP traffic"
  }

  # Reglas de entrada permitidas para HTTPS (puerto 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow HTTPS traffic"
  }

  # Resto de las reglas de entrada para puertos específicos
  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 30000"
  }

  ingress {
    from_port   = 30010
    to_port     = 30010
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 30010"
  }

  ingress {
    from_port   = 30015
    to_port     = 30015
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 30015"
  }

  ingress {
    from_port   = 40000
    to_port     = 40000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 40000"
  }

  # Regla de entrada permitida para RDP (puerto 3389)
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow RDP traffic"
  }

  # Regla de salida permitida para cualquier puerto (egreso)
  egress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow outgoing traffic"
  }
}

# Definición del grupo de seguridad para la instancia de Windows Server
resource "aws_security_group" "security_group_winserv" {
  name        = "security_group_winserv"
  description = "Grupo de seguridad para SAP Windows Server"
  vpc_id      = aws_vpc.vpc.id

  # Reglas de entrada permitidas para SSH (puerto 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow SSH traffic"
  }

  # Reglas de entrada permitidas para un puerto específico (8100)
  ingress {
    from_port   = 8100
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 8100"
  }

  # Resto de las reglas de entrada para puertos específicos
  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 30000"
  }

  ingress {
    from_port   = 30010
    to_port     = 30010
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 30010"
  }

  ingress {
    from_port   = 30015
    to_port     = 30015
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 30015"
  }

  ingress {
    from_port   = 40000
    to_port     = 40000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow custom port 40000"
  }

  # Regla de entrada permitida para RDP (puerto 3389) desde cualquier IP (0.0.0.0/0)
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow RDP traffic from any IP"
  }

  # Regla de salida permitida para cualquier puerto (egreso)
  egress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"

    # Restringir el tráfico de salida a direcciones IP dentro de la VPC
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow outgoing traffic"
  }
}