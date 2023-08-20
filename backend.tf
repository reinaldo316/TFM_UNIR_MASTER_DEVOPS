terraform {
  backend "s3" {
    bucket          = "terraform-state-bucket-tfm-eg-unir-316"
    key             = "terraform.tfstate"
    dynamodb_table  = "terraform_state_versioning-tfm-eg-unir-316"
    region          = "us-east-1"
  }
}