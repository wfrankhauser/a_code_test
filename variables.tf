variable "aws_region" {
  type    = string
  default = "us-west-2"
}

#expects CIDRs
variable "ssh_whitelist" {
  type    = list(string)
  default = ["76.91.207.0/32"]
}

variable "http_whitelist" {
  type    = list(string)
  default = ["76.91.207.0/32"]
}

variable "instance_count" {
  type    = number
  default = 1
}
