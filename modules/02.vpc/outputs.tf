output "REGION_ID" {
    value = data.aws_region.current.id
}

output "REGION_NAME" {
    value = data.aws_region.current.name
}

output "VPC_ID"{
    value = aws_vpc.VPC[0].id
}

output "SG_ID" {
    value = aws_security_group.VPC_SG[*].id
}

output "Z1_SN1_ID"{
    value = try(aws_subnet.Z1_SN1[0].id, null)
}

output "Z1_SN2_ID"{
    value = try(aws_subnet.Z1_SN2[0].id, null)
}

output "Z1_SN3_ID"{
    value = try(aws_subnet.Z1_SN3[0].id, null)
}

output "Z2_SN1_ID"{
    value = try(aws_subnet.Z2_SN1[0].id, null)
}

output "Z2_SN2_ID"{
    value = try(aws_subnet.Z2_SN2[0].id, null)
}

output "Z2_SN3_ID"{
    value = try(aws_subnet.Z2_SN3[0].id, null)
}

output "Z3_SN1_ID"{
    value = try(aws_subnet.Z3_SN1[0].id, null)
}

output "Z3_SN2_ID"{
    value = try(aws_subnet.Z3_SN2[0].id, null)
}

output "Z3_SN3_ID"{
    value = try(aws_subnet.Z3_SN3[0].id, null)
}

output "RTB_ID"{
    value = try(aws_route_table.RTB[*].id, null)
}

