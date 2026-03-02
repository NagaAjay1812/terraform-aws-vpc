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


