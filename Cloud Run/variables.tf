# Variables to configure the google provider
variable "project_id" {
  type        = string
  description = "The peoject ID of the project in which the services are to be created"
}
variable "region" {
  type        = string
  description = "The region in which the services are to be created"
}
#########


# Variables related to the public service
variable "public_service_name" {
  type        = string
  description = "Name of the public service"
}
variable "public_service_location" {
  type        = string
  description = "Location of the public service"
}
#########


# Variables related to private service
variable "private_service_name" {
  type        = string
  description = "Name of the private service"
}
variable "private_service_location" {
  type        = string
  description = "Location of the private service"
}
