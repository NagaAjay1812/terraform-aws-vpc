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

variable "desired_azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
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
variable "public" {
  type    = string
  default = "public"
}
variable "private" {
  type    = string
  default = "private"
}
variable "database" {
  type    = string
  default = "database"
}

variable "subnet_tags" {
  type = map(any)
  default = {

  }
}


