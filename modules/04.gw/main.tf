# mainNET.tf

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

# Set Internet Gateway
resource "aws_internet_gateway" "IGW" {
    count = (length(var.IGW) > 0 ? length(var.IGW) : 0)
    vpc_id = var.IGW[count.index].VPC_ID

    tags = {
        Name = "${var.IGW[count.index].NAME}"
    }
}

resource "aws_vpn_gateway" "VGW" {
    count = (length(var.VGW) > 0 ? length(var.VGW) : 0)

    amazon_side_asn = var.VGW[count.index].AWS_ASN
    vpc_id = var.VGW[count.index].VPC_ID
    availability_zone = var.VGW[count.index].ZONE

    tags = {
        Name = "${var.VGW[count.index].NAME}"
    }
}

resource "aws_customer_gateway" "CGW" {
    count = (length(var.CGW) > 0 ? length(var.CGW) : 0)

    bgp_asn    = var.CGW[count.index].BGP_ASN
    ip_address = var.CGW[count.index].IP
    type       = var.CGW[count.index].TYPE

    tags = {
        Name = "${var.CGW[count.index].NAME}"
    }
}

resource "aws_ec2_transit_gateway" "TGW" {
    count = (length(var.TGW) > 0 ? length(var.TGW) : 0)

    amazon_side_asn    = var.TGW[count.index].AWS_ASN
    dns_support = var.TGW[count.index].DNS_SUP
    vpn_ecmp_support = var.TGW[count.index].VPN_ECMP_SUP
    default_route_table_association = var.TGW[count.index].VPN_DEFAULT_RTB_ASS == null ? "disable" : var.TGW[count.index].VPN_DEFAULT_RTB_ASS 
    default_route_table_propagation = var.TGW[count.index].VPN_DEFAULT_RTB_PROP == null ? "disable" : var.TGW[count.index].VPN_DEFAULT_RTB_PROP 
    multicast_support = var.TGW[count.index].MULTICAST_SUP
    auto_accept_shared_attachments = var.TGW[count.index].AUTO_CROSS_ACC_ATT
    transit_gateway_cidr_blocks = var.TGW[count.index].CIDRS
    tags = {
        Name = "${var.TGW[count.index].NAME}"
    }
}

resource "aws_ec2_transit_gateway_route_table" "TGW_RTB" {
    count = (length(var.TGW) > 0 ? length(var.TGW) : 0)    
    transit_gateway_id = aws_ec2_transit_gateway.TGW[count.index].id
    tags = {
        Name = "${var.TGW[count.index].NAME}_RTB"
    }
}