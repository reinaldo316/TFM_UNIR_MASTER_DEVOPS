package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformVariables(t *testing.T) {
	t.Parallel()

	// Ruta al directorio que contiene tus archivos de configuración de Terraform.
	terraformOptions := &terraform.Options{
		TerraformDir: "/home/reinaldo316/Desktop/TFM_UNIR_MASTER_DEVOPS",
	}

	defer terraform.Destroy(t, terraformOptions)

	// Ejecuta 'terraform init' para inicializar el directorio.
	terraform.Init(t, terraformOptions)

	// Ejecuta 'terraform apply' para aplicar la configuración y obtener los valores de las variables.
	terraform.Apply(t, terraformOptions)

	// Verifica que las variables estén definidas correctamente y tengan los valores esperados.
	expectedAwsProfile := "default"
	actualAwsProfile := terraformOptions.Vars["aws_profile_name"].(string)
	assert.Equal(t, expectedAwsProfile, actualAwsProfile, "Valor de aws_profile_name incorrecto")

	expectedAwsRegion := "us-east-1"
	actualAwsRegion := terraformOptions.Vars["aws_region"].(string)
	assert.Equal(t, expectedAwsRegion, actualAwsRegion, "Valor de aws_region incorrecto")

	expectedAvailabilityZone := "us-east-1a"
	actualAvailabilityZone := terraformOptions.Vars["availability_zone"].(string)
	assert.Equal(t, expectedAvailabilityZone, actualAvailabilityZone, "Valor de availability_zone incorrecto")

	// Ejecuta 'terraform destroy' para eliminar los recursos creados durante las pruebas.
	terraform.Destroy(t, terraformOptions)
}
