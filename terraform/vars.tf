# Fichero de variables para ficheros de configuración de Terraform

variable "location" {
  type = string
  description = "Región de Azure de la infraestructura groupId: azunir"
  default = "West Europe"
}

# Cambiar la variable vm_size. No interesa que todas las máquinas tengan las mismas características !!!
# O se incluye en local, o se hace una variable por rol.

variable "vm_size" {
  type = string
  description = "Clase de máquina virtual"
  default = "Standard_D1_v2" # 3.5 GB, 1 CPU // Cambiar, ya que para k8s con 1 CPU no da.
}