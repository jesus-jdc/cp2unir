# Fichero de variables para ficheros de configuración de Terraform no incluidos en el correction-vars.tf

variable "rg_name" {
  type = string
  description = "Nombre del Resource Group"
  default = "azunir-rg"
}

variable "mt_vm_size" {
  type = string
  description = "Clase de máquina virtual para los nodos master"
  default = "Standard_B2s" # 4 GB RAM, 2 vCPU
}

variable "wk_vm_size" {
  type = string
  description = "Clase de máquina virtual para los nodos worker"
  default = "Standard_D1_v2" # 3.5 GB RAM, 1 vCPU
}

variable "wk_count" {
  type = number
  description = "Define el número de nodos worker"
  default = 2
}