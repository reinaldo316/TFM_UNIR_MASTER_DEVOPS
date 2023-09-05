import unittest

from terraform import terraform

class TestVariableInPlan(unittest.TestCase):

    def test_variable_in_plan(self):
        # Ruta al directorio donde se encuentra tu código de Terraform
        terraform_options = terraform.Options(
            TerraformDir="./"
        )

        # Genera el plan de Terraform sin aplicarlo
        plan = terraform.InitAndPlan(terraform_options)

        # Verifica que la variable está en el plan
        self.assertIn("aws_profile_name", plan.Variables)

        # Obtiene el valor de la variable
        variable_value = plan.Variables["aws_profile_name"]

        # Verifica el valor de la variable
        self.assertEqual(variable_value, "default")

