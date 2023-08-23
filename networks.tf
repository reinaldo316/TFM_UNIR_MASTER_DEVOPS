
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_flow_log" "vpc_flow_log" {
  depends_on = [aws_vpc.vpc]

  # Log Destination ARN con interpolación correcta
  log_destination = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:destination-prefix"
  
  traffic_type = "ALL"
  vpc_id       = aws_vpc.vpc.id
}

# Creación de un Internet Gateway y asociación con la VPC creada
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

# Creación de una subred para SAP SUSE en la Zona de Disponibilidad us-east-1a
resource "aws_subnet" "subnet_suse" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Creación de una subred para Windows Server con la Zona de Disponibilidad definida por una variable
resource "aws_subnet" "subnet_windows" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.availability_zone
}

# Creación de una tabla de ruteo para SAP SUSE asociada a la VPC
resource "aws_route_table" "route_table_suse" {
  vpc_id = aws_vpc.vpc.id

  # Ruta predeterminada para el tráfico saliente a través del Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Asociación de la tabla de ruteo de SAP SUSE con la subred correspondiente
resource "aws_route_table_association" "route_table_association_suse" {
  subnet_id = aws_subnet.subnet_suse.id
  route_table_id = aws_route_table.route_table_suse.id
}

# Creación de una tabla de ruteo para Windows Server asociada a la VPC
resource "aws_route_table" "route_table_windows" {
  vpc_id = aws_vpc.vpc.id

  # Ruta predeterminada para el tráfico saliente a través del Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Asociación de la tabla de ruteo de Windows Server con la subred correspondiente
resource "aws_route_table_association" "route_table_association_windows" {
  subnet_id = aws_subnet.subnet_windows.id
  route_table_id = aws_route_table.route_table_windows.id
}
