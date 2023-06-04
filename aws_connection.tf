# REG1
locals {
    AWS_REG1_IGW = [
        {
            NAME = "SEOUL_VPC_IGW"
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID
        }
        ,{
            NAME = "SEOUL_IDC_IGW"
            VPC_ID = module.AWS_REG1_VPC2.VPC_ID
        }
    ]
    AWS_REG1_CGW = [
        {
            NAME = "SEOUL_IDC_CGW"
            BGP_ASN = 65010
            IP = "${module.AWS_REG1_ADD.EIP_IP[2]}"
            TYPE = "ipsec.1"
        }
    ]
    AWS_REG1_TGW = [
        {
            NAME = "SEOUL_TGW"
            AWS_ASN = 65000
            DNS_SUP = "enable"
            VPN_ECMP_SUP = "enable"
            MULTICAST_SUP = "enable"
            AUTO_CROSS_ACC_ATT = "disable"
            CIDRS = ["0.0.0.0/0"]
        }
    ]
    AWS_REG1_TGW_CON_VPC = [
        {
            NAME = "SEOUL_TGW_VPC1"
            TGW_ID = module.AWS_REG1_CONNECTION.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG1_CONNECTION.TGW_RTB_ID[0]
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID
            SN_IDs = [module.AWS_REG1_VPC1.Za_SN1_ID]
        }
    ]
    AWS_REG1_TGW_CON_CGW = [
        {
            NAME = "SEOUL_TGW_CON_IDC"
            TGW_ID = module.AWS_REG1_CONNECTION.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG1_CONNECTION.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.2.0.0/16"
            CGW_ID = module.AWS_REG1_CONNECTION.CGW_ID[0]
            TYPE = "ipsec.1"
            STATIC_ROUTE = true
            TUNNEL1_PSK = "${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_PSK}"
            TUNNEL2_PSK = null
        }
    ]

    AWS_REG1_TGW_CON_CGW_TUNNEL1_LEFT_SN = "${local.AWS_REG1_VPC2.CIDR}"
    AWS_REG1_TGW_CON_CGW_TUNNEL1_LEFT_IP = "${module.AWS_REG1_ADD.EIP_IP[2]}"
    AWS_REG1_TGW_CON_CGW_TUNNEL1_RIGHT_SN = "10.0.0.0/8"
    AWS_REG1_TGW_CON_CGW_TUNNEL1_RIGHT_IP = "${module.AWS_REG1_CONNECTION.TGW_CON_CGW_TUNNEL1_OUT_IP[0]}"
    AWS_REG1_TGW_CON_CGW_TUNNEL1_PSK = "cloudneta"

    AWS_REG1_TGW_PEER_REQUEST = [
        {
            NAME = "PEER_TO_SINGAPORE_TGW"
            TGW_ID = module.AWS_REG1_CONNECTION.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG1_CONNECTION.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.3.0.0/16"
            PEER_OWNER_ID = module.AWS_REG2_KEY.OWNER_ID
            PEER_REG_NAME = local.AWS_REGIONs[1].CODE
            PEER_TGW_ID = module.AWS_REG2_CONNECTION.TGW_ID[0]
            PEER_VPC_ID = module.AWS_REG2_VPC1.VPC_ID
        }
    ]

    AWS_REG1_TGW_PEER_REQUEST_ADD_ROUTE = [
        {
            DESTINATION_CIDR    = "10.4.0.0/16"
            TGW_ATT_ID          = module.AWS_REG1_CONNECTION.TGW_PEER_ATT_ID[0]
            TGW_RTB_ID          = module.AWS_REG1_CONNECTION.TGW_RTB_ID[0]
            BLACKHOLE           = false 
        }
    ]

    AWS_REG1_PEER_REQUEST = [
        {
            NAME = "PEER_TO_SINGAPORE_IDC"
            VPC_ID = module.AWS_REG1_VPC2.VPC_ID
            PEER_OWNER_ID = module.AWS_REG2_KEY.OWNER_ID
            PEER_REGION_NAME = local.AWS_REGIONs[1].CODE
            PEER_VPC_ID = module.AWS_REG2_VPC2.VPC_ID
            AUTO_ACCEPT = true
        }
    ]
}

# REG2
locals {
    AWS_REG2_IGW = [
        {
            NAME = "SINGAPORE_VPC_IGW"
            VPC_ID = module.AWS_REG2_VPC1.VPC_ID
        }
        ,{
            NAME = "SINGAPORE_IDC_IGW"
            VPC_ID = module.AWS_REG2_VPC2.VPC_ID
        }
    ]
    AWS_REG2_CGW = [
        {
            NAME = "SEOUL_IDC_CGW"
            BGP_ASN = 65110
            IP = "${module.AWS_REG2_ADD.EIP_IP[1]}"
            TYPE = "ipsec.1"
        }
    ]
    AWS_REG2_TGW = [
        {
            NAME = "SINGAPORE_TGW"
            AWS_ASN = 65100
            DNS_SUP = "enable"
            VPN_ECMP_SUP = "enable"
            MULTICAST_SUP = "enable"
            AUTO_CROSS_ACC_ATT = "disable"
            CIDRS = ["0.0.0.0/0"]
        }
    ]
    AWS_REG2_TGW_CON_VPC = [
        {
            NAME = "SINGAPORE_TGW_VPC1"
            TGW_ID = module.AWS_REG2_CONNECTION.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG2_CONNECTION.TGW_RTB_ID[0]
            VPC_ID = module.AWS_REG2_VPC1.VPC_ID
            SN_IDs = [module.AWS_REG2_VPC1.Za_SN1_ID]
        }
    ]
    AWS_REG2_TGW_CON_CGW = [
        {
            NAME = "SINGAPORE_TGW_CON_IDC"
            TGW_ID = module.AWS_REG2_CONNECTION.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG2_CONNECTION.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.4.0.0/16"
            CGW_ID = module.AWS_REG2_CONNECTION.CGW_ID[0]
            TYPE = "ipsec.1"
            STATIC_ROUTE = true
            TUNNEL1_PSK = "${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_PSK}"
            TUNNEL2_PSK = null
        }
    ]

    AWS_REG2_TGW_CON_CGW_TUNNEL1_LEFT_SN = "${local.AWS_REG2_VPC2.CIDR}"
    AWS_REG2_TGW_CON_CGW_TUNNEL1_LEFT_IP = "${module.AWS_REG2_ADD.EIP_IP[1]}"
    AWS_REG2_TGW_CON_CGW_TUNNEL1_RIGHT_SN = "10.0.0.0/8"
    AWS_REG2_TGW_CON_CGW_TUNNEL1_RIGHT_IP = "${module.AWS_REG2_CONNECTION.TGW_CON_CGW_TUNNEL1_OUT_IP[0]}"
    AWS_REG2_TGW_CON_CGW_TUNNEL1_PSK = "cloudneta"

    AWS_REG2_TGW_PEER_ACCEPT = [
        {
            NAME = "PEER_FROM_SEOUL_TGW1"
            TGW_ATT_ID = module.AWS_REG1_CONNECTION.TGW_PEER_ATT_ID[0]
            TGW_RTB_ID = module.AWS_REG2_CONNECTION.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.1.0.0/16"
        }
    ]

    AWS_REG2_TGW_PEER_ACCEPT_ADD_ROUTE = [
        {
            DESTINATION_CIDR    = "10.2.0.0/16"
            TGW_ATT_ID          = module.AWS_REG1_CONNECTION.TGW_PEER_ATT_ID[0]
            TGW_RTB_ID          = module.AWS_REG2_CONNECTION.TGW_RTB_ID[0]
            BLACKHOLE           = false 
        }
    ]

    AWS_REG2_PEER_ACCEPT = [
        {
            NAME = "PEER_FROM_SEOUL_IDC"
            PEER_ID = module.AWS_REG1_CONNECTION.PEER_ID[0]
            AUTO_ACCEPT = true
        }
    ]
}
