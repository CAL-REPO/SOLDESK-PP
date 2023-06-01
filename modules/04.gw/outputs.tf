output "IGW_ID"{
    value = try(aws_internet_gateway.IGW[*].id, null)
}

output "VGW_ID"{
    value = try(aws_vpn_gateway.VGW[*].id, null)
}

output "CGW_ID"{
    value = try(aws_customer_gateway.CGW[*].id, null)
}

output "TGW_ID"{
    value = try(aws_ec2_transit_gateway.TGW[*].id, null)
}

output "TGW_RTB_ID" {
    value = try(aws_ec2_transit_gateway_route_table.TGW_RTB[*].id, null)
}