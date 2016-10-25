output "elb_endpoint" {
    value = "${aws_elb.ll_ha.dns_name}"
}

output "instance_a_ip" {
    value = "${aws_instance.ll_ha_a.public_ip}"
}

output "instance_b_ip" {
    value = "${aws_instance.ll_ha_b.public_ip}"
}

output "instance_c_ip" {
    value = "${aws_instance.ll_ha_c.public_ip}"
}

output "CATTLE_DB_CATTLE_MYSQL_HOST" {
    value = "${aws_rds_cluster.ll_ha.endpoint}"
}

output "CATTLE_DB_CATTLE_MYSQL_PORT" {
    value = "${aws_rds_cluster.ll_ha.port}"
}

output "CATTLE_DB_CATTLE_MYSQL_NAME" {
    value = "${aws_rds_cluster.ll_ha.database_name}"
}

output "CATTLE_DB_CATTLE_USERNAME" {
    value = "lldocker"
}

output "CATTLE_DB_CATTLE_PASSWORD" {
    value = "${var.db_password}"
}
