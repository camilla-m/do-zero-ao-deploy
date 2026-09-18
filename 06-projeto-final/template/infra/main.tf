terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # TODO: descomente e configure depois de criar o bucket de state
  # (mesmo padrao do Modulo 2, Aula 06)
  # backend "s3" {
  #   bucket       = "SEU-BUCKET-DE-STATE"
  #   key          = "projeto-final/terraform.tfstate"
  #   region       = "us-east-1"
  #   encrypt      = true
  #   use_lockfile = true
  # }
}

provider "aws" {
  region = "us-east-1"
}

# TODO: rede -- VPC + subnets, se seu projeto precisar de rede propria
# (ver Modulo 2, Aula 07, como referencia)

# TODO: onde a aplicacao vai rodar -- EC2 sozinho? Um cluster EKS?
# Este curso usa kind LOCAL pra Kubernetes (sem custo de nuvem) -- decida se
# seu projeto final precisa de um cluster gerenciado de verdade na AWS (EKS,
# que tem custo) ou se roda em kind/minikube local mesmo, com a infra AWS
# limitada a rede + outros recursos de apoio (bucket, banco gerenciado, etc).

# TODO: outputs relevantes (IP, endpoint, nome de recurso) -- ver Modulo 2, Aula 05
