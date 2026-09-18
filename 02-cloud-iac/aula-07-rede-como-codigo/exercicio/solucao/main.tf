terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "criar_nat_gateway" {
  description = "Se true, cria um NAT Gateway para dar saida a internet a partir da subnet privada. COBRA POR HORA (~US$32/mes) + trafego. Padrao: false."
  type        = bool
  default     = false
}

data "aws_availability_zones" "disponiveis" {
  state = "available"
}

resource "aws_vpc" "curso" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "do-zero-ao-deploy-vpc"
  }
}

resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.curso.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.disponiveis.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "do-zero-ao-deploy-subnet-publica"
  }
}

resource "aws_subnet" "privada" {
  vpc_id            = aws_vpc.curso.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.disponiveis.names[0]

  tags = {
    Name = "do-zero-ao-deploy-subnet-privada"
  }
}

resource "aws_internet_gateway" "curso" {
  vpc_id = aws_vpc.curso.id

  tags = {
    Name = "do-zero-ao-deploy-igw"
  }
}

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.curso.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.curso.id
  }

  tags = {
    Name = "do-zero-ao-deploy-rt-publica"
  }
}

resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table" "privada" {
  vpc_id = aws_vpc.curso.id

  tags = {
    Name = "do-zero-ao-deploy-rt-privada"
  }
}

resource "aws_route_table_association" "privada" {
  subnet_id      = aws_subnet.privada.id
  route_table_id = aws_route_table.privada.id
}

# --- NAT Gateway: opcional, custa dinheiro mesmo parado. Ver variable acima. ---

resource "aws_eip" "nat" {
  count  = var.criar_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "do-zero-ao-deploy-nat-eip"
  }
}

resource "aws_nat_gateway" "curso" {
  count         = var.criar_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.publica.id

  tags = {
    Name = "do-zero-ao-deploy-nat"
  }

  depends_on = [aws_internet_gateway.curso]
}

resource "aws_route" "privada_nat" {
  count                  = var.criar_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.privada.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.curso[0].id
}
