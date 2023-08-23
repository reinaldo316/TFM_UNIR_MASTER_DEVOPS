# Configuración del backend para almacenar el estado en S3
terraform {
  backend "s3" {
    bucket          = "terraform-state-bucket-tfm-eg-unir-316"  # Nombre del bucket de S3 para almacenar el estado
    key             = "terraform.tfstate"  # Ruta dentro del bucket para el archivo de estado
    dynamodb_table  = "terraform_state_versioning-tfm-eg-unir-316"  # Nombre de la tabla de DynamoDB para el bloqueo de estado
    region          = "us-east-1"  # Región de AWS donde se encuentra el bucket y la tabla de DynamoDB
  }
}
