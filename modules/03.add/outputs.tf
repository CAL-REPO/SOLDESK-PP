output "DEFAULT_EIP_ID" {
    value = try(aws_eip.DEFAULT_EIP[*].id, null)
}

output "DEFAULT_EIP_IP" {
    value = try(aws_eip.DEFAULT_EIP[*].public_ip, null)
}

output "EIP_ID" {
    value = try(aws_eip.ADD_EIP[*].id, null)
}

output "EIP_IP" {
    value = try(aws_eip.ADD_EIP[*].public_ip, null)
}

output "NIC_ID" {
    value = try(aws_network_interface.ADD_NIC[*].id, null)
}