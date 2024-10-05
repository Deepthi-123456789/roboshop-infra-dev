variable project_name {
    default = "roboshop"
}
variable environment {
    default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "tags" {
  default = {
    component = "catalogue"
  }
}

variable "zone_name" {
  default = "daws76s.online"
}