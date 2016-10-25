resource "aws_key_pair" "ll" {
    key_name = "${var.key_name}"
    public_key = "${file("${var.key_path}.pub")}"
}

resource "aws_instance" "ll_ha_a" {
    ami                         = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.instance_type}"
    availability_zone           = "${var.region}a"
    key_name                    = "${aws_key_pair.ll.key_name}"
    subnet_id                   = "${aws_subnet.ll_ha_a.id}"
    security_groups             = ["${aws_security_group.ll_ha.id}"]
    associate_public_ip_address = true

    tags {
        Name = "${var.tag_name}-instance-a"
    }

    root_block_device {
        volume_size = "100"
        delete_on_termination = true
    }
}

resource "aws_instance" "ll_ha_b" {
    ami                         = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.instance_type}"
    availability_zone           = "${var.region}b"
    key_name                    = "${aws_key_pair.ll.key_name}"
    subnet_id                   = "${aws_subnet.ll_ha_b.id}"
    security_groups             = ["${aws_security_group.ll_ha.id}"]
    associate_public_ip_address = true

    tags {
        Name = "${var.tag_name}-instance-b"
    }

    root_block_device {
        volume_size = "100"
        delete_on_termination = true
    }
}

resource "aws_instance" "ll_ha_c" {
    ami                         = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.instance_type}"
    availability_zone           = "${var.region}c"
    key_name                    = "${aws_key_pair.ll.key_name}"
    subnet_id                   = "${aws_subnet.ll_ha_b.id}"
    subnet_id                   = "${aws_subnet.ll_ha_c.id}"
    security_groups             = ["${aws_security_group.ll_ha.id}"]
    associate_public_ip_address = true

    tags {
        Name = "${var.tag_name}-instance-c"
    }

    root_block_device {
        volume_size = "100"
        delete_on_termination = true
    }
}

resource "aws_security_group" "ll_ha" {
    name        = "${var.tag_name}-secgroup"
    description = "Docker HA Ports"
    vpc_id      = "${aws_vpc.ll_ha.id}"

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "udp"
        self      = true
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["10.2.88.0/20"]
    }

    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "udp"
        cidr_blocks = ["10.2.88.0/20"]
    }

    ingress {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
