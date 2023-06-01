output "TGW_CON_CGW_TUNNEL1_OUT_IP" {
    value = try(aws_vpn_connection.TGW_CON_CGW[*].tunnel1_address, null)
}

output "TGW_CON_CGW_TUNNEL2_OUT_IP" {
    value = try(aws_vpn_connection.TGW_CON_CGW[*].tunnel2_address, null)
}

output "TGW_ATT_ID"{
    value = try(aws_ec2_transit_gateway_vpc_attachment.TGW_CON_VPC[*].id, null)
}

output "TGW_PEER_ATT_ID" {
    value = try(aws_ec2_transit_gateway_peering_attachment.TGW_PEER_REQUEST[*].id, null)
}

output "PEER_ID" {
    value = try(aws_vpc_peering_connection.PEER_REQUEST[*].id, null)    
}