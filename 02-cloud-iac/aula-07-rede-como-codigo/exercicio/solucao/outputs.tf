output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.curso.id
}

output "subnet_publica_id" {
  description = "ID da subnet pública"
  value       = aws_subnet.publica.id
}

output "subnet_privada_id" {
  description = "ID da subnet privada"
  value       = aws_subnet.privada.id
}
