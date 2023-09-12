# TFM_UNIR_MASTER_DEVOPS
Prototipo de infraestructura como servicio para automatizar la creación de entornos de prueba en la nube de Amazon Web Services (AWS) utilizando la herramienta de infraestructura como código (IaC) Terraform. 
Este prototipo se utiliza específicamente para facilitar la actualización de versiones del software empresarial SAP Business One (B1).

## Documentación para la Automatización de Creación de Ambientes de Prueba con IaaS para el procedimiento de actualización de versiones del ERP SAP Business One 

### Introducción
El prototipo de Infraestructura como Servicio (IaaS) permite automatizar la creación de entornos de prueba en la nube que serán ocupados para el procedimiento de actualización de versiones del ERP SAP Business One, El prototipo se basa en la automatización de Terraform para definir la infraestructura y en GitHub Actions para implementar un proceso de Integración Continua y Entrega Continua (CI/CD). Esta documentación proporciona una guía básica para comenzar a utilizar el prototipo y aprovechar sus capacidades de forma eficiente.

### Requisitos Previos
- <Una cuenta en GitHub.
- <Cuenta en el proveedor de nube (AWS).
- <Acceso a las credenciales y claves de acceso a la nube(AWS).
- <Conocimientos básicos sobre Git y GitHub Actions.
- <Conocimientos básicos sobre infraestructura en la nube y terminología asociada.
- <Conocimientos básicos sobre infraestructura como codigo en Terraform.

### Pasos para levantar la infraestructura de manera local modificando las variables
A continuación, se describen los pasos para utilizar el prototipo de IaaS:
- [Paso 1:] Clonar el Repositorio
Abrir una terminal en la máquina local.
Clona el repositorio del proyecto desde GitHub utilizando el siguiente comando
```sh
git clone https://github.com/reinaldo316/TFM_UNIR_MASTER_DEVOPS.git
```
- [Paso 2:] Configurar Credenciales
Asegurarse de tener las credenciales de acceso a tu proveedor de nube (AWS) listas.
Configura las credenciales en tu entorno local, ya que el código en terraform busca el perfil AWS que se crea localmente, esto con el fin de separar cualquier tipo de credencial del código como tal. Por ejemplo, en AWS, puedes configurarlas con el comando:
```sh
aws configure
```
Este comando al ejecutarlo en la terminal les solicitara las siguientes credenciales:
- AWS Access Key ID
- AWS Secret Access Key
Esto es importante si van a realizar pruebas de manera local este comando funcionara siempre y cuando tengan instalado el CLI de AWS en caso de no tenerlo favor revisar el siguiente link:
```sh
https://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-chap-configure.html
```


