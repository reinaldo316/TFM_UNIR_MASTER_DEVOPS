package test

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestInfrastructure(t *testing.T) {
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
	awsregion := "us-east-1"
	awsProfileName := "default"
	awsAvailabilityZone := "us-east-1a"
	awsInstanceTypeWin := "t2.micro"
	awsInstanceTypeSuse := "t2.large"
	volumeType := "gp2"
	volumeSizeWin := "100"
	volumeSizeSuse := "100"

	// Configurar opciones para Terraform
	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"aws_region":         awsregion,
			"aws_profile_name":   awsProfileName,
			"availability_zone":  awsAvailabilityZone,
			"instance_type_win":  awsInstanceTypeWin,
			"instance_type_suse": awsInstanceTypeSuse,
			"volume_type":        volumeType,
			"volume_size_win":    volumeSizeWin,
			"volume_size_suse":   volumeSizeSuse,
		},
		NoColor: true,
	}

	// Ejecutar 'terraform init' y 'terraform apply' en el directorio del módulo Terraform
	terraform.InitAndApply(t, terraformOptions)

	// prueba que asegura que las instancias de AWS se hayan creado correctamente
	windowsServerID := terraform.OutputJson(t, terraformOptions, "windows_server_instance_id")
	suseServerID := terraform.OutputJson(t, terraformOptions, "suse_server_instance_id")
	keyPairName := terraform.OutputJson(t, terraformOptions, "key_pair_name")
	//keyPairPublicKey := terraform.Output(t, terraformOptions, "key_pair_public_key")
	awsRegion := terraform.OutputJson(t, terraformOptions, "aws_region")
	instanceTypeWin := terraform.OutputJson(t, terraformOptions, "instance_type_win")
	instanceTypeSuse := terraform.OutputJson(t, terraformOptions, "instance_type_suse")
	securityGroupNameSuse := terraform.OutputJson(t, terraformOptions, "security_group_name_suse")
	securityGroupDescriptionSuse := terraform.OutputJson(t, terraformOptions, "security_group_description_suse")
	securityGroupNameWinserv := terraform.OutputJson(t, terraformOptions, "security_group_name_winserv")
	securityGroupDescriptionWinserv := terraform.OutputJson(t, terraformOptions, "security_group_description_winserv")
	amiSuseServer := terraform.OutputJson(t, terraformOptions, "ami_suse_server")
	amiWindows2022 := terraform.OutputJson(t, terraformOptions, "ami_windows_2022")
	vpcID := terraform.OutputJson(t, terraformOptions, "vpc_id")
	subnetIDSuse := terraform.OutputJson(t, terraformOptions, "subnet_id_suse")
	subnetIDWinserv := terraform.OutputJson(t, terraformOptions, "subnet_id_winserv")
	windowsServerInstanceID := terraform.OutputJson(t, terraformOptions, "windows_server_instance_id")
	suseServerInstanceID := terraform.OutputJson(t, terraformOptions, "suse_server_instance_id")
	variableKeyPair := terraform.OutputJson(t, terraformOptions, "variable_key-pair")

	// Se comprueba que elrecurso esta presente

	assert.NotEmpty(t, windowsServerID)
	assert.NotEmpty(t, suseServerID)
	assert.NotEmpty(t, keyPairName)
	//assert.NotEmpty(t, keyPairPublicKey)
	assert.NotEmpty(t, awsRegion)
	assert.NotEmpty(t, instanceTypeWin)
	assert.NotEmpty(t, instanceTypeSuse)
	assert.NotEmpty(t, securityGroupNameSuse)
	assert.NotEmpty(t, securityGroupDescriptionSuse)
	assert.NotEmpty(t, securityGroupNameWinserv)
	assert.NotEmpty(t, securityGroupDescriptionWinserv)
	assert.NotEmpty(t, amiSuseServer)
	assert.NotEmpty(t, amiWindows2022)
	assert.NotEmpty(t, vpcID)
	assert.NotEmpty(t, subnetIDSuse)
	assert.NotEmpty(t, subnetIDWinserv)
	assert.NotEmpty(t, windowsServerInstanceID)
	assert.NotEmpty(t, suseServerInstanceID)
	assert.NotEmpty(t, variableKeyPair)

	// Limpia los recursos al finalizar la prueba
	defer terraform.Destroy(t, terraformOptions)

}
