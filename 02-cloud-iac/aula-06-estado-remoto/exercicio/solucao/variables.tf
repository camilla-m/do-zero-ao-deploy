variable "meu_ip" {
  description = "Seu IP público, em CIDR (ex: 203.0.113.10/32), para liberar acesso SSH"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small"], var.instance_type)
    error_message = "instance_type deve ser t3.micro ou t3.small (mantendo custo baixo pro curso)."
  }
}
