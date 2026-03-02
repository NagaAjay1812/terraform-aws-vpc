variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr_block" {
  default = "10.0.0.0/16"

}


variable "public_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "database_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}


variable "vpc_tags" {
  type = map(any)
  default = {
  }
}
variable "ig_tags" {
  type = map(any)
  default = {
  }
}

variable "public_subnet_tags" {
  type = map(any)
  default = {

  }
}
variable "private_subnet_tags" {
  type = map(any)
  default = {

  }
}
variable "database_subnet_tags" {
  type = map(any)
  default = {

  }
}


