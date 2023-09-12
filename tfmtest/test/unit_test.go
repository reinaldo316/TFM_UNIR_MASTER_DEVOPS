package test

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
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

		PlanFilePath: ".terraform/plan",
		NoColor:      true,
	}

	//terraform.Plan(t, terraformOptions)

	// Ejecutar 'terraform init', 'terraform plan' y 'terraform show' con las opciones dadas, y parsear el resultado JSON en una estructura Go
	plan, err := terraform.InitAndPlanAndShowWithStructE(t, terraformOptions)
	if err != nil {
		t.Errorf("Error running terraform: %s", err)
	}
	//value := plan.RawPlan.Variables["aws_instance.windows_server"]

	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_instance.windows_server")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_key_pair.key_pair")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_security_group.security_group_suse")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_security_group.security_group_winserv")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_internet_gateway.internet_gateway")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_subnet.subnet_windows")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_route_table.route_table_suse")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_route_table.route_table_windows")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_instance.suse_server")
	terraform.AssertPlannedValuesMapKeyExists(t, plan, "aws_vpc.vpc")

	// Limpiar los recursos al finalizar la prueba
	defer terraform.Destroy(t, terraformOptions)

}
