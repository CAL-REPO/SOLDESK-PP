# SG Rule List
locals {
    SG_ALL = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All traffic"
    }    
    SG_ICMP = {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Ping"
    }
    SG_SSH = {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH"        
    }
    SG_HTTP = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP"
    }
    SG_HTTPS = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS"
    }
    SG_DB = {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "DB"
    }
    SG_DNS_TCP = {
        from_port   = 53
        to_port     = 53
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "DNS" 
    }
    SG_DNS_UDP = {
        from_port   = 53
        to_port     = 53
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "DNS"
    }
    SG_VPN_500 = {
        from_port   = 500
        to_port     = 500
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "VPN"
    }
    SG_VPN_4500 = {
        from_port   = 4500
        to_port     = 4500
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "VPN"
    }
}

# REG1
locals {
    AWS_REG1_VPC1 = {
        NAME                = "AWS-SEOUL-VPC"
        CIDR                = "10.1.0.0/16"
        DNS_SUP             = true
        DNS_HOST            = true
        DHCP_NAME           = ""
        DHCP_DOMAIN         = ""
        DHCP_DOMAIN_NSs     = []
        DHCP_DOMAIN_NTPs    = []
        DHCP_DOMAIN_NBSs    = []
        DHCP_DOMAIN_NODE    = null
        Za_SN1_NAME         = "AWS-SEOUL-NAT1-Za-SN"
        Za_SN2_NAME         = "AWS-SEOUL-WEB1-Za-SN"
        Za_SN3_NAME         = ""
        Za_SN1_CIDR         = "10.1.1.0/24"
        Za_SN2_CIDR         = "10.1.3.0/24"
        Za_SN3_CIDR         = ""
        Zb_SN1_NAME         = ""
        Zb_SN2_NAME         = ""
        Zb_SN3_NAME         = ""
        Zb_SN1_CIDR         = ""
        Zb_SN2_CIDR         = ""
        Zb_SN3_CIDR         = ""
        Zc_SN1_NAME         = "AWS-SEOUL-NAT2-Zc-SN"
        Zc_SN2_NAME         = "AWS-SEOUL-WEB2-Zc-SN"
        Zc_SN3_NAME         = ""
        Zc_SN1_CIDR         = "10.1.2.0/24"
        Zc_SN2_CIDR         = "10.1.4.0/24"
        Zc_SN3_CIDR         = ""
    }
    AWS_REG1_VPC2 = {
        NAME                = "IDC-SEOUL-VPC"
        CIDR                = "10.2.0.0/16"
        DNS_SUP             = true
        DNS_HOST            = true
        DHCP_NAME           = ""
        DHCP_DOMAIN         = ""
        DHCP_DOMAIN_NSs     = []
        DHCP_DOMAIN_NTPs    = []
        DHCP_DOMAIN_NBSs    = []
        DHCP_DOMAIN_NODE    = null
        Za_SN1_NAME         = "IDC-SEOUL-CGW-Za-SN"
        Za_SN2_NAME         = "IDC-SEOUL-DB-DNS-Za-SN"
        Za_SN3_NAME         = ""
        Za_SN1_CIDR         = "10.2.0.0/24"
        Za_SN2_CIDR         = "10.2.1.0/24"
        Za_SN3_CIDR         = ""
        Zb_SN1_NAME         = ""
        Zb_SN2_NAME         = ""
        Zb_SN3_NAME         = ""
        Zb_SN1_CIDR         = ""
        Zb_SN2_CIDR         = ""
        Zb_SN3_CIDR         = ""
        Zc_SN1_NAME         = ""
        Zc_SN2_NAME         = ""
        Zc_SN3_NAME         = ""
        Zc_SN1_CIDR         = ""
        Zc_SN2_CIDR         = ""
        Zc_SN3_CIDR         = ""            
    }
    AWS_REG1_VPC1_RTBs = [
        # RTB1
        {   
            NAME = "AWS-SEOUL-NAT1-RTB"
            SN_ID = module.AWS_REG1_VPC1.Za_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_CONNECTION.IGW_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    transit_gateway_id = module.AWS_REG1_CONNECTION.TGW_ID[0]
                }
                ,{
                    cidr_block = "10.3.0.0/16"
                    transit_gateway_id = module.AWS_REG1_CONNECTION.TGW_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    transit_gateway_id = module.AWS_REG1_CONNECTION.TGW_ID[0]
                }
            ]
        }
        # RTB2
        ,{
            NAME = "AWS-SEOUL-WEB1-RTB"
            SN_ID = module.AWS_REG1_VPC1.Za_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }
            ]
        }
        # RTB3
        ,{
            NAME = "AWS-SEOUL-NAT2-RTB"
            SN_ID = module.AWS_REG1_VPC1.Zc_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_CONNECTION.IGW_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.3.0.0/16"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }                                                    
            ]
        }
        # RTB4
        ,{
            NAME = "AWS-SEOUL-WEB2-RTB"
            SN_ID = module.AWS_REG1_VPC1.Zc_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[2]
                }
            ]
        }
    ]
    AWS_REG1_VPC2_RTBs = [
        # RTB1
        {   
            NAME = "IDC-SEOUL-CGW-RTB" 
            SN_ID = module.AWS_REG1_VPC2.Za_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_CONNECTION.IGW_ID[1]
                }              
            ]
        }
        # RTB2
        ,{
            NAME = "IDC-SEOUL-DB-DNS-RTB"
            SN_ID = module.AWS_REG1_VPC2.Za_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG1_VPC2_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    vpc_peering_connection_id = module.AWS_REG1_CONNECTION.PEER_ID[0]
                }  
            ]
        }
    ]
    AWS_REG1_VPC1_SGs = [
        {
            NAME = "AWS-SEOUL-NAT1-SG"
            INGRESS = [ 
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP,
                local.SG_VPN_500,
                local.SG_VPN_4500
            ]
            EGRESS = [
                local.SG_ALL
            ]
        },
        {
            NAME = "AWS-SEOUL-NAT2-SG"
            INGRESS = [ 
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }        
        ,{
            NAME = "AWS-SEOUL-WEB-SG"
            INGRESS = [
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }
        ,{
            NAME = "AWS-SEOUL-ALB-SG"
            INGRESS = [
                local.SG_HTTP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }
    ]
    AWS_REG1_VPC2_SGs = [
        {
            NAME = "IDC-SEOUL-CGW-SG"
            INGRESS = [ 
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP,
                local.SG_VPN_500,
                local.SG_VPN_4500
            ]
            EGRESS = [
                local.SG_ALL
            ]
        },
        {
            NAME = "IDC-SEOUL-DB-SG"
            INGRESS = [ 
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }        
        ,{
            NAME = "IDC-SEOUL-DNS-SG"
            INGRESS = [
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }
    ]
}

# REG2
locals {
    AWS_REG2_VPC1 = {
        NAME                = "AWS-SINGAPORE-VPC"
        CIDR                = "10.3.0.0/16"
        DNS_SUP             = true
        DNS_HOST            = true
        DHCP_NAME           = ""
        DHCP_DOMAIN         = ""
        DHCP_DOMAIN_NSs     = []
        DHCP_DOMAIN_NTPs    = []
        DHCP_DOMAIN_NBSs    = []
        DHCP_DOMAIN_NODE    = null
        Za_SN1_NAME         = "AWS-SINGAPORE-NAT-Za-SN"
        Za_SN2_NAME         = "AWS-SINGAPORE-WEB-Za-SN"
        Za_SN3_NAME         = ""
        Za_SN1_CIDR         = "10.3.1.0/24"
        Za_SN2_CIDR         = "10.3.3.0/24"
        Za_SN3_CIDR         = ""
        Zb_SN1_NAME         = ""
        Zb_SN2_NAME         = ""
        Zb_SN3_NAME         = ""
        Zb_SN1_CIDR         = ""
        Zb_SN2_CIDR         = ""
        Zb_SN3_CIDR         = ""
        Zc_SN1_NAME         = "AWS-SINGAPORE-Zc-SN"
        Zc_SN2_NAME         = ""
        Zc_SN3_NAME         = ""
        Zc_SN1_CIDR         = "10.3.4.0/24"
        Zc_SN2_CIDR         = ""
        Zc_SN3_CIDR         = ""
    }
    AWS_REG2_VPC2 = {
        NAME                = "IDC-SINGAPORE-VPC"
        CIDR                = "10.4.0.0/16"
        DNS_SUP             = true
        DNS_HOST            = true
        DHCP_NAME           = ""
        DHCP_DOMAIN         = ""
        DHCP_DOMAIN_NSs     = []
        DHCP_DOMAIN_NTPs    = []
        DHCP_DOMAIN_NBSs    = []
        DHCP_DOMAIN_NODE    = null
        Za_SN1_NAME         = "IDC-SINGAPORE-CGW-Za-SN"
        Za_SN2_NAME         = "IDC-SINGAPORE-DB-DNS-Za-SN"
        Za_SN3_NAME         = ""
        Za_SN1_CIDR         = "10.4.0.0/24"
        Za_SN2_CIDR         = "10.4.1.0/24"
        Za_SN3_CIDR         = ""
        Zb_SN1_NAME         = ""
        Zb_SN2_NAME         = ""
        Zb_SN3_NAME         = ""
        Zb_SN1_CIDR         = ""
        Zb_SN2_CIDR         = ""
        Zb_SN3_CIDR         = ""
        Zc_SN1_NAME         = ""
        Zc_SN2_NAME         = ""
        Zc_SN3_NAME         = ""
        Zc_SN1_CIDR         = ""
        Zc_SN2_CIDR         = ""
        Zc_SN3_CIDR         = ""        
    }   
    AWS_REG2_VPC1_RTBs = [
        # RTB1
        {   
            NAME = "AWS-SINGAPORE-NAT-RTB" 
            SN_ID = module.AWS_REG2_VPC1.Za_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG2_CONNECTION.IGW_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    transit_gateway_id = module.AWS_REG2_CONNECTION.TGW_ID[0]
                }
                ,{
                    cidr_block = "10.1.0.0/16"
                    transit_gateway_id = module.AWS_REG2_CONNECTION.TGW_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    transit_gateway_id = module.AWS_REG2_CONNECTION.TGW_ID[0]
                }                                   
            ]
        }
        # RTB2
        ,{
            NAME = "AWS-SINGAPORE-WEB-RTB"
            SN_ID = module.AWS_REG2_VPC1.Za_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG2_VPC1_INS.DEFAULT_NIC_ID[0]
                }    
            ]
        }
    ]
    AWS_REG2_VPC2_RTBs = [
        # RTB1
        {   
            NAME = "IDC-SINGAPORE-CGW-RTB" 
            SN_ID = module.AWS_REG2_VPC2.Za_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG2_CONNECTION.IGW_ID[1]
                }
            ]
        }
        # RTB2
        ,{
            NAME = "IDC-SINGAPORE-DB-DNS-RTB"
            SN_ID = module.AWS_REG2_VPC2.Za_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG2_VPC2_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    vpc_peering_connection_id = module.AWS_REG1_CONNECTION.PEER_ID[0]
                }                
            ]
        }
    ]
    AWS_REG2_VPC1_SGs = [
        {
            NAME = "AWS-SINGAPORE-NAT-SG"
            INGRESS = [
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP,
                local.SG_VPN_500,
                local.SG_VPN_4500
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }
        ,{
            NAME = "AWS-SINGAPORE-WEB-SG"
            INGRESS = [
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }
    ]
    AWS_REG2_VPC2_SGs = [
        {
            NAME = "IDC-SINGAPORE-CGW-SG"
            INGRESS = [ 
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP,
                local.SG_VPN_500,
                local.SG_VPN_4500
            ]
            EGRESS = [
                local.SG_ALL
            ]
        },
        {
            NAME = "IDC-SINGAPORE-DB-SG"
            INGRESS = [ 
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DB,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }        
        ,{
            NAME = "IDC-SINGAPORE-DNS-SG"
            INGRESS = [
                local.SG_ICMP,
                local.SG_SSH,
                local.SG_HTTP,
                local.SG_HTTPS,
                local.SG_DNS_TCP,
                local.SG_DNS_UDP
            ]
            EGRESS = [
                local.SG_ALL
            ]
        }
    ]
}