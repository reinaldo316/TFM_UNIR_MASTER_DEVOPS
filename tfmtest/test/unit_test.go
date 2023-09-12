package test

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestUnitInfrastructure(t *testing.T) {
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

		PlanFilePath: "./plan",
		NoColor:      true,
	}

	// Ejecutar 'terraform init', 'terraform plan' y 'terraform show' con las opciones dadas, y parsear el resultado JSON en una estructura Go
	plan := terraform.InitAndPlanAndShow(t, terraformOptions)

	//Revisa que los recursos de terraform se encuentren en el plan
	assert.Contains(t, plan, "aws_instance.windows_server")
	assert.Contains(t, plan, "aws_subnet.subnet_suse")
	assert.Contains(t, plan, "aws_key_pair.key_pair")
	assert.Contains(t, plan, "aws_security_group.security_group_suse")
	assert.Contains(t, plan, "aws_security_group.security_group_winserv")
	assert.Contains(t, plan, "aws_internet_gateway.internet_gateway")
	assert.Contains(t, plan, "aws_subnet.subnet_windows")
	assert.Contains(t, plan, "aws_route_table.route_table_suse")
	assert.Contains(t, plan, "aws_route_table.route_table_windows")
	assert.Contains(t, plan, "aws_instance.suse_server")
	assert.Contains(t, plan, "aws_vpc.vpc")

	//Revisa que las variables de terraform se encuentren en el plan
	assert.Contains(t, plan, "var.aws_profile_name")
	assert.Contains(t, plan, "aws_region")
	assert.Contains(t, plan, "availability_zone")
	assert.Contains(t, plan, "instance_type_win")
	assert.Contains(t, plan, "instance_type_suse")
	assert.Contains(t, plan, "volume_type")
	assert.Contains(t, plan, "volume_size_win")
	assert.Contains(t, plan, "volume_size_suse")
}
