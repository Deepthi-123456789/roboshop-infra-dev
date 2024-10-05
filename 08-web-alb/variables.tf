variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "tags" {
  default = {
    component = "web-alb"
  }
}

variable "project_name"{
    default = "roboshop"
}
variable "environment"{
    default = "dev"
}