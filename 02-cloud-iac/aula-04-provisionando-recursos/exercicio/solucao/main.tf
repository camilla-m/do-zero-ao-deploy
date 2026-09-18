terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "meu_ip" {
  description = "Seu IP público, em CIDR (ex: 203.0.113.10/32), para liberar acesso SSH"
  type        = string
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "vm_ssh" {
  name        = "minha-primeira-vm-ssh"
  description = "Libera SSH apenas do meu IP"

  ingress {
    description = "SSH do meu IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.meu_ip]
  }

  egress {
    description = "Todo trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minha-primeira-vm-ssh"
  }
}

resource "aws_instance" "minha_vm" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.vm_ssh.id]

  tags = {
    Name = "minha-primeira-vm-tf"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "dados_curso" {
  bucket = "do-zero-ao-deploy-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "dados-curso"
  }
}

resource "aws_s3_bucket_public_access_block" "dados_curso" {
  bucket = aws_s3_bucket.dados_curso.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dados_curso" {
  bucket = aws_s3_bucket.dados_curso.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
