package test

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVariables(t *testing.T) {
	t.Parallel()
	ex, err := os.Getwd()
	if err != nil {
		panic(err)
	}
	exPath := filepath.Dir(ex)
	exPath2 := filepath.Dir(exPath)
	fmt.Println(exPath2)
	// Directorio del módulo Terraform
	terraformDir := exPath2

	// Variables para la prueba
	awsProfileName := "default"
	awsRegion := "us-east-2"
	availabilityZone := "us-west-2a"
	instanceTypeWin := "t2.medium"
	instanceTypeSuse := "m5.large"
	volumeType := "gp2"
	volumeSizeWin := "50"
	volumeSizeSuse := "500"

	// Configurar opciones para Terraform
	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"aws_profile_name":   awsProfileName,
			"aws_region":         awsRegion,
			"availability_zone":  availabilityZone,
			"instance_type_win":  instanceTypeWin,
			"instance_type_suse": instanceTypeSuse,
			"volume_type":        volumeType,
			"volume_size_win":    volumeSizeWin,
			"volume_size_suse":   volumeSizeSuse,
		},
	}

	// Ejecutar 'terraform init' y 'terraform apply' en el directorio del módulo Terraform
	terraform.InitAndApply(t, terraformOptions)

	// Asegurarse de que las variables de entrada se hayan configurado correctamente
	profileName := terraform.Output(t, terraformOptions, "aws_profile_name")
	region := terraform.Output(t, terraformOptions, "aws_region")
	az := terraform.Output(t, terraformOptions, "availability_zone")
	instanceTypeWinOutput := terraform.Output(t, terraformOptions, "instance_type_win")
	instanceTypeSuseOutput := terraform.Output(t, terraformOptions, "instance_type_suse")
	volumeTypeOutput := terraform.Output(t, terraformOptions, "volume_type")
	volumeSizeWinOutput := terraform.Output(t, terraformOptions, "volume_size_win")
	volumeSizeSuseOutput := terraform.Output(t, terraformOptions, "volume_size_suse")

	assert.Equal(t, awsProfileName, profileName)
	assert.Equal(t, awsRegion, region)
	assert.Equal(t, availabilityZone, az)
	assert.Equal(t, instanceTypeWin, instanceTypeWinOutput)
	assert.Equal(t, instanceTypeSuse, instanceTypeSuseOutput)
	assert.Equal(t, volumeType, volumeTypeOutput)
	assert.Equal(t, volumeSizeWin, volumeSizeWinOutput)
	assert.Equal(t, volumeSizeSuse, volumeSizeSuseOutput)
}
