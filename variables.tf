variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr_block" {
  default = "10.0.0.0/16"

}
variable "public1a_cidr_block" {
  default = "10.0.1.0/24"
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


