# mainVPC.tf

# Standard AWS Provider Block
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 1.0"
        }
    }
}

data "aws_region" "current" {}

# Set VPC
resource "aws_vpc" "VPC"{
    count = (var.VPC["VPC_NAME"] != "" ? 1 : 0)

    tags = {
        Name = var.VPC["VPC_NAME"]
    }

    cidr_block = var.VPC["CIDR"]
    enable_dns_support = var.VPC["DNS_SUP"]
    enable_dns_hostnames = var.VPC["DNS_HOST"]
}

# Set Security Group
resource "aws_default_security_group" "SG_DEFAULT" {
    count = (length(aws_vpc.VPC) > 0 ? 1 : 0)

    vpc_id = aws_vpc.VPC[count.index].id

    tags = {
        Name = "${var.VPC["VPC_NAME"]}_DEFAULT"
    }
}

resource "aws_security_group" "VPC_SG" {
    count = (length(var.VPC_SG_NAME) > 0 ?
            length(var.VPC_SG_NAME) : 0)
    depends_on = [aws_vpc.VPC]
    vpc_id = aws_vpc.VPC[0].id
    name_prefix = "${var.VPC_SG_NAME[count.index]}"
    tags = {
        Name = "${var.VPC_SG_NAME[count.index]}"
    }

    dynamic "ingress" {
        for_each = length(var.VPC_SG_RULE[count.index].INGRESS) > 0 ? (var.VPC_SG_RULE[count.index].INGRESS) : [null]
        content {
            from_port   = try(ingress.value.from_port, 0)
            to_port     = try(ingress.value.to_port, 0)
            protocol    = try(ingress.value.protocol, "")
            cidr_blocks = try(ingress.value.cidr_blocks, [])
            description = try(ingress.value.description, "")
        }
    }

    dynamic "egress" {    
        for_each = length(var.VPC_SG_RULE[count.index].EGRESS) > 0 ? (var.VPC_SG_RULE[count.index].EGRESS) : [null]
        content {
            from_port   = try(egress.value.from_port, 0)
            to_port     = try(egress.value.to_port, 0)
            protocol    = try(egress.value.protocol, "")
            cidr_blocks = try(egress.value.cidr_blocks, [])
            description = try(egress.value.description, "")
        }
    }

    revoke_rules_on_delete = true
    lifecycle {
        create_before_destroy = true
    }

}

# Set Subnet
data "aws_availability_zones" "available" {}

resource "aws_subnet" "Z1_SN1" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z1_SN1_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]
    vpc_id = aws_vpc.VPC[count.index].id

    cidr_block = var.VPC["Z1_SN1_CIDR"]
    availability_zone = "${data.aws_region.current.name}a"
    tags = {
        Name = var.VPC["Z1_SN1_NAME"]
    }
}

resource "aws_subnet" "Z1_SN2" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z1_SN2_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]
    vpc_id = aws_vpc.VPC[count.index].id

    cidr_block = var.VPC["Z1_SN2_CIDR"]
    availability_zone = "${data.aws_region.current.name}a"
    tags = {
        Name = var.VPC["Z1_SN2_NAME"]
    }
}

resource "aws_subnet" "Z1_SN3" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z1_SN3_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]
    vpc_id = aws_vpc.VPC[count.index].id

    cidr_block = var.VPC["Z1_SN3_CIDR"]
    availability_zone = "${data.aws_region.current.name}a"
    tags = {
        Name = var.VPC["Z1_SN3_NAME"]
    }
}

resource "aws_subnet" "Z2_SN1" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z2_SN1_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]
    vpc_id = aws_vpc.VPC[count.index].id

    cidr_block = var.VPC["Z2_SN1_CIDR"]
    availability_zone = "${data.aws_region.current.name}b"
    tags = {
        Name = var.VPC["Z2_SN1_NAME"]
    }
}

resource "aws_subnet" "Z2_SN2" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z2_SN2_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    vpc_id = aws_vpc.VPC[count.index].id
    cidr_block = var.VPC["Z2_SN2_CIDR"]
    availability_zone = "${data.aws_region.current.name}b"
    tags = {
        Name = var.VPC["Z2_SN2_NAME"]
    }
}

resource "aws_subnet" "Z2_SN3" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z2_SN3_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    vpc_id = aws_vpc.VPC[count.index].id
    cidr_block = var.VPC["Z2_SN3_CIDR"]
    availability_zone = "${data.aws_region.current.name}b"
    tags = {
        Name = var.VPC["Z2_SN3_NAME"]
    }
}

resource "aws_subnet" "Z3_SN1" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z3_SN1_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    vpc_id = aws_vpc.VPC[count.index].id
    cidr_block = var.VPC["Z3_SN1_CIDR"]
    availability_zone = "${data.aws_region.current.name}c"
    tags = {
        Name = var.VPC["Z3_SN1_NAME"]
    }
}

resource "aws_subnet" "Z3_SN2" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z3_SN2_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    vpc_id = aws_vpc.VPC[count.index].id
    cidr_block = var.VPC["Z3_SN2_CIDR"]
    availability_zone = "${data.aws_region.current.name}c"
    tags = {
        Name = var.VPC["Z3_SN2_NAME"]
    }
}

resource "aws_subnet" "Z3_SN3" {
    count = (length(aws_vpc.VPC) > 0 &&
            var.VPC["Z3_SN3_NAME"] != "" ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    vpc_id = aws_vpc.VPC[count.index].id
    cidr_block = var.VPC["Z3_SN3_CIDR"]
    availability_zone = "${data.aws_region.current.name}c"
    tags = {
        Name = var.VPC["Z3_SN3_NAME"]
    }
}

resource "aws_default_route_table" "VPC_DEFAULT_RT" {
    count = (length(aws_vpc.VPC) > 0 ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    default_route_table_id = "${aws_vpc.VPC[count.index].default_route_table_id}"
    tags = {
        Name = "${var.VPC["VPC_NAME"]}_DEFAULT"   
    }
}

# Set Route Table
resource "aws_route_table" "RTB" {
    count = (length(aws_vpc.VPC) > 0 &&        
            length(var.VPC_RTB) > 0 ? length(var.VPC_RTB) : 0)
    depends_on = [aws_vpc.VPC]
    vpc_id = aws_vpc.VPC[0].id

    tags = {
        Name = "${var.VPC_RTB[count.index].NAME}"
    }

    # One of the following targets must be provided
    # Gateway_id and Instance_id will be conflict
    dynamic "route" {
        for_each = var.VPC_RTB[count.index].ROUTE
        content {
            cidr_block      = try(route.value.cidr_block, null)
            ipv6_cidr_block = try(route.value.ipv6_cidr_block, null)   
            egress_only_gateway_id    = try(route.value.egress_only_gateway_id, null)
            gateway_id                = try(route.value.gateway_id, null)
            nat_gateway_id            = try(route.value.nat_gateway_id, null)
            network_interface_id      = try(route.value.network_interface_id, null)
            transit_gateway_id        = try(route.value.transit_gateway_id, null)
            vpc_endpoint_id           = try(route.value.vpc_endpoint_id, null)
            vpc_peering_connection_id = try(route.value.vpc_peering_connection_id, null)            
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}

# Associate Route table with Subnet
resource "aws_route_table_association" "RTB_ASS" {
    count = (length(aws_vpc.VPC) > 0 &&        
            length(var.VPC_RTB) > 0 ? length(var.VPC_RTB) : 0)

    depends_on = [aws_vpc.VPC, aws_route_table.RTB]
    subnet_id      = var.VPC_RTB[count.index].SN_ID
    route_table_id = aws_route_table.RTB[count.index].id
}

# Set DHCP options sets

resource "aws_default_vpc_dhcp_options" "DEFAULT_DHCP" {
    count = (length(aws_vpc.VPC) > 0 ? 1 : 0)    
    tags = {
        Name = "Default DHCP"
    }
}

resource "aws_vpc_dhcp_options" "DHCP"{
    count = (length(aws_vpc.VPC) > 0 &&    
            var.VPC["DEFAULT_DHCP"] == false ? 1 : 0)
    depends_on = [aws_vpc.VPC]

    tags = {
        Name = "${var.VPC["DHCP_NAME"]}" == "" ? "${var.VPC["VPC_NAME"]}" : "${var.VPC["DHCP_NAME"]}"
    }

    domain_name = var.VPC["DHCP_NAME"] != "" ? var.VPC["DOMAIN"] : ""
    domain_name_servers = var.VPC["DHCP_NAME"] != "" ? var.VPC["DOMAIN_NS"] : []
    ntp_servers  = var.VPC["DHCP_NAME"] != "" ? var.VPC["DOMAIN_NTP"] : []
    netbios_name_servers = var.VPC["DHCP_NAME"] != "" ? var.VPC["DOMAIN_NBS"] : []
    netbios_node_type    = var.VPC["DHCP_NAME"] != "" ? var.VPC["DOMAIN_NODE"] : 2
}

resource "aws_vpc_dhcp_options_association" "DHCP" {
    count = (length(aws_vpc_dhcp_options.DHCP) > 0 &&
            var.VPC["DEFAULT_DHCP"] == false ? 1 : 0)
    depends_on = [aws_vpc.VPC, aws_vpc_dhcp_options.DHCP]

    vpc_id = aws_vpc.VPC[0].id
    dhcp_options_id = aws_vpc_dhcp_options.DHCP[count.index].id
}

resource "aws_route53_resolver_config" "RESOLV" {
    count = (var.VPC["RESOLVER_DEFAULT_RULE"] != "" ? 1 : 0)
    resource_id              = aws_vpc.VPC[0].id
    autodefined_reverse_flag = var.VPC["RESOLVER_DEFAULT_RULE"]
}