
variable "virginia_cidr"{
    description = "Prueba de creacion de reed virtual"
    type = string
    sensitive = false
} 

variable "subnets" {
    description = "public subnet"
    type = list(string)
}   

variable "enable_monitoring" {
    description = "monitoreo"
    type = number
}   