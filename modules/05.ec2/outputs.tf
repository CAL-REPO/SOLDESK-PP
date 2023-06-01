output "EC2_ID"{
    value = aws_instance.EC2[*].id
}

output "EC2_SN_ID" {
    value = aws_instance.EC2[*].subnet_id
}

output "DEFAULT_NIC_ID" {
    value = aws_network_interface.DEFAULT_NIC[*].id
}