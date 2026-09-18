terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Este projeto NÃO usa backend remoto — ele é o que CRIA o backend
  # que todo o resto do curso vai usar. State local aqui é intencional.
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3 que vai guardar o state do curso (globalmente único)"
  type        = string
}

resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name

  tags = {
    Name    = "do-zero-ao-deploy-tfstate"
    Purpose = "terraform-remote-state"
  }
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  description = "Nome do bucket a usar no backend \"s3\" do projeto principal"
  value       = aws_s3_bucket.tfstate.bucket
}
