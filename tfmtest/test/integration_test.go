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
	}

	// Ejecutar 'terraform init' y 'terraform apply' en el directorio del módulo Terraform
	terraform.InitAndApply(t, terraformOptions)

	// prueba que asegura que las instancias de AWS se hayan creado correctamente
	windowsServerID := terraform.Output(t, terraformOptions, "windows_server_instance_id")
	suseServerID := terraform.Output(t, terraformOptions, "suse_server_instance_id")
	keyPairName := terraform.Output(t, terraformOptions, "key_pair_name")
	keyPairPublicKey := terraform.Output(t, terraformOptions, "key_pair_public_key")
	awsRegion := terraform.Output(t, terraformOptions, "aws_region")
	instanceTypeWin := terraform.Output(t, terraformOptions, "instance_type_win")
	instanceTypeSuse := terraform.Output(t, terraformOptions, "instance_type_suse")
	securityGroupNameSuse := terraform.Output(t, terraformOptions, "security_group_name_suse")
	securityGroupDescriptionSuse := terraform.Output(t, terraformOptions, "security_group_description_suse")
	securityGroupNameWinserv := terraform.Output(t, terraformOptions, "security_group_name_winserv")
	securityGroupDescriptionWinserv := terraform.Output(t, terraformOptions, "security_group_description_winserv")
	amiSuseServer := terraform.Output(t, terraformOptions, "ami_suse_server")
	amiWindows2022 := terraform.Output(t, terraformOptions, "ami_windows_2022")
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	subnetIDSuse := terraform.Output(t, terraformOptions, "subnet_id_suse")
	subnetIDWinserv := terraform.Output(t, terraformOptions, "subnet_id_winserv")
	windowsServerInstanceID := terraform.Output(t, terraformOptions, "windows_server_instance_id")
	suseServerInstanceID := terraform.Output(t, terraformOptions, "suse_server_instance_id")
	variableKeyPair := terraform.Output(t, terraformOptions, "variable_key-pair")

	assert.NotEmpty(t, windowsServerID)
	assert.NotEmpty(t, suseServerID)
	assert.NotEmpty(t, keyPairName)
	assert.NotEmpty(t, keyPairPublicKey)
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

	// Limpiar los recursos al finalizar la prueba
	defer terraform.Destroy(t, terraformOptions)

}
