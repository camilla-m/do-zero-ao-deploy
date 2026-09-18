output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.minha_vm.public_ip
}

output "bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.dados_curso.bucket
}

output "bucket_arn" {
  description = "ARN do bucket S3 criado"
  value       = aws_s3_bucket.dados_curso.arn
}
