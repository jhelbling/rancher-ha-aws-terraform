resource "aws_vpc" "ll_ha" {
    cidr_block           = "10.2.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags {
        Name = "${var.tag_name}-vpc"
    }
}

resource "aws_subnet" "ll_ha_a" {
    vpc_id                  = "${aws_vpc.ll_ha.id}"
    cidr_block              = "10.2.90.0/24"
    availability_zone       = "${var.region}a"
    map_public_ip_on_launch = true
    tags {
      Name = "${var.tag_name}-subnet-a"
    }
}

resource "aws_subnet" "ll_ha_b" {
    vpc_id                  = "${aws_vpc.ll_ha.id}"
    cidr_block              = "10.2.91.0/24"
    availability_zone       = "${var.region}b"
    map_public_ip_on_launch = true
    tags {
      Name = "${var.tag_name}-subnet-b"
    }
}

resource "aws_subnet" "ll_ha_c" {
    vpc_id                  = "${aws_vpc.ll_ha.id}"
    cidr_block              = "10.2.92.0/24"
    availability_zone       = "${var.region}c"
    map_public_ip_on_launch = true
    tags {
      Name = "${var.tag_name}-subnet-d"
    }
}

resource "aws_internet_gateway" "ll_ha" {
    vpc_id     = "${aws_vpc.ll_ha.id}"
    depends_on = ["aws_vpc.ll_ha"]
    tags {
      Name = "${var.tag_name}-igw"
    }
}

resource "aws_route" "ll_ha" {
    route_table_id         = "${aws_vpc.ll_ha.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.ll_ha.id}"
    depends_on             = ["aws_vpc.ll_ha", "aws_internet_gateway.ll_ha"]
}
