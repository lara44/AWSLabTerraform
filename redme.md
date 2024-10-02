## inicializar terraform
terraform init
## lista espacio de trabajo
terraform workspace list
## crear nuevo espacio de trabajo
terraform workspace new pdn
## eliminar workspace
terraform workspace delete pdn
## seleccionar espacio de trabajo
terraform workspace select pdn
## Crear informe de creación
terraform plan
## Ejecutar plan
terraform apply
## Ejecución del plan sin confirmación:
terraform apply -auto-approve
## Eliminar recursos
terraform destroy