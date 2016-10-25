variable "access_key" {
    description = "AWS account access key ID"
}

variable "secret_key" {
    description = "AWS account secret access key"
}

variable "region" {
    default     = "eu-west-1"
    description = "AMI lookups."
}

variable "ami" {
    description = "AWS LL-DockerOS AMI ID"
    default {
        eu-west-1 = "ami-997b1eea"
    }
}

variable "key_name" {
    default = "ra-key"
    description = "SSH key name in your AWS account for AWS instances."
}

variable "key_path" {
    default = "~/.ssh/ra-key"
    description = "Local path of the SSH private key"
}

variable "instance_type" {
    default     = "m4.large" 
    description = "AWS Instance type"
}

variable "tag_name" {
    default     = "ll-docker-ha"
    description = "Name tag for the servers"
}

variable "vpc_cidr" {
    default     = "10.2.79.0/20"
    description = "Subnet in CIDR format to assign to VPC"
}

variable "db_password" {
    description = "Password for connecting to the ll RDS database"
}

variable "cert_body" {}
variable "cert_private_key" {}
variable "cert_chain" {}
