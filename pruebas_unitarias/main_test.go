package main

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestInfrastructure(t *testing.T) {
	t.Parallel()

	// Directorio del módulo Terraform
	terraformDir := "./"

	// Variables para la prueba
	awsRegion := "us-west-2"
	awsProfileName := "my-aws-profile"
	instanceType := "t2.micro"
	windowsServerIP := "10.0.0.10"
	suseServerIP := "10.0.0.20"
	volumeType := "gp2"
	volumeSize := "8"

	// Configurar opciones para Terraform
	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"aws_region":        awsRegion,
			"aws_profile_name":  awsProfileName,
			"instance_type":     instanceType,
			"windows_server_ip": windowsServerIP,
			"suse_server_ip":    suseServerIP,
			"volume_type":       volumeType,
			"volume_size":       volumeSize,
		},
	}

	// Ejecutar 'terraform init' y 'terraform apply' en el directorio del módulo Terraform
	terraform.InitAndApply(t, terraformOptions)

	// Asegurarse de que las instancias de AWS se hayan creado correctamente
	windowsServerID := terraform.Output(t, terraformOptions, "aws_instance.windows_server.id")
	suseServerID := terraform.Output(t, terraformOptions, "aws_instance.suse_server.id")

	assert.NotEmpty(t, windowsServerID)
	assert.NotEmpty(t, suseServerID)

	// Limpiar los recursos al finalizar la prueba
	defer terraform.Destroy(t, terraformOptions)

	// También puedes realizar más verificaciones sobre los recursos creados si es necesario
}