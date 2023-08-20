resource "aws_security_group" "security_group_suse" {
  name        = "suse_security_group"
  description = "Grupo de seguridad para SAP SUSE Server"
  vpc_id = aws_vpc.vpc.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 30010
    to_port     = 30010
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 30015
    to_port     = 30015
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 40000
    to_port     = 40000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }


    egress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_security_group" "security_group_winserv" {
  name        = "security_group_winserv"
  description = "Grupo de seguridad para SAP Windows Server"
  vpc_id = aws_vpc.vpc.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

    ingress {
    from_port   = 8100
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 30010
    to_port     = 30010
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 30015
    to_port     = 30015
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 40000
    to_port     = 40000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

    egress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]

  }
}

