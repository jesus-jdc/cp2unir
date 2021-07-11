# Fichero de credenciales (oculto)

variable "subscription_id" {
  type = string
  description = "ID de la suscripción de Azure"
  default = "609e9b68-b0e5-4a40-b1d1-3f1735109e81"
}

variable "client_id" {
  type = string
  description = "App ID del Service Principal de Azure"
  default = "5b549e16-047e-418c-902e-4a609c258b2d"
}

variable "client_secret" {
  type = string
  description = "Contraseña del Service Principal de Azure"
  default = "7XBLUUo5sibPQCg7lN0aJmyfue4McI.TqI"
}

variable "tenant_id" {
  type = string
  description = "ID del Tenant de Azure"
  default = "899789dc-202f-44b4-8472-a6d40f9eb440"
}