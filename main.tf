module "AWS_REG1_KEY" {
    source = "./modules/01.key"
    providers = {
        aws = aws.Seoul
    }
    KEY_NAME = var.KEY["NAME"]
    KEY_BACKUP_FILE = local.KEY_FILE["AWS_REG1"].BACKUP
    KEY_SSH_FILE = local.KEY_FILE["AWS_REG1"].SSH
    KEY_HOME_FILE = local.KEY_FILE["AWS_REG1"].HOME
}

module "AWS_REG1_ADD" {
    source = "./modules/03.add"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_KEY ]
    DEFAULT_EIP_NAME = local.AWS_REG1_DEFAULT_EIP_NAME
    DEFAULT_EIP_INS_ID = local.AWS_REG1_DEFAULT_EIP_INS_ID
    ADD_EIP_NAME = local.AWS_REG1_ADD_EIP_NAME
    ADD_NIC_NAME = local.AWS_REG1_ADD_NIC_NAME
    ADD_NIC_INS_ID = local.AWS_REG1_ADD_NIC_INS_ID
    ADD_NIC_INFO = local.AWS_REG1_ADD_NIC_INFO
}

module "AWS_REG1_VPC1" {
    source = "./modules/02.vpc"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_KEY ]
    VPC = var.AWS["REG1_VPC1"]
    VPC_SG_NAME = local.AWS_REG1_VPC1_SG.NAME
    VPC_SG_RULE = local.AWS_REG1_VPC1_SG.RULE
    VPC_RTB = local.AWS_REG1_VPC1_RTB
}

module "AWS_REG1_VPC1_INS" {
    source = "./modules/05.ec2"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_GW ]
    INS_KEY_FILE = local.KEY_FILE["AWS_REG1"].SSH
    INS_NAME = local.AWS_REG1_VPC1_INS_NAME
    INS_INFO = local.AWS_REG1_VPC1_INS_INFO
    INS_VOL = local.AWS_REG1_VPC1_INS_DEFAULT_VOL
    INS_UD = local.AWS_REG1_VPC1_INS_UD
}

module "AWS_REG1_VPC2" {
    source = "./modules/02.vpc"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_KEY ]
    VPC = var.AWS["REG1_VPC2"]
    VPC_SG_NAME = local.AWS_REG1_VPC2_SG.NAME
    VPC_SG_RULE = local.AWS_REG1_VPC2_SG.RULE
    VPC_RTB = local.AWS_REG1_VPC2_RTB
}

module "AWS_REG1_VPC2_INS" {
    source = "./modules/05.ec2"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_GW ]
    INS_KEY_FILE = local.KEY_FILE["AWS_REG1"].SSH
    INS_NAME = local.AWS_REG1_VPC2_INS_NAME
    INS_INFO = local.AWS_REG1_VPC2_INS_INFO
    INS_VOL = local.AWS_REG1_VPC2_INS_DEFAULT_VOL
    INS_UD = local.AWS_REG1_VPC2_INS_UD
}

module "AWS_REG1_GW" {
    source = "./modules/04.gw"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_KEY ]
    IGW = local.AWS_REG1_IGW
    CGW = local.AWS_REG1_CGW
    TGW = local.AWS_REG1_TGW
}

module "AWS_REG1_CONNECTION" {
    source = "./modules/06.connection"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_GW ]
    TGW_CON_VPC = local.AWS_REG1_TGW_CON_VPC
    TGW_CON_CGW = local.AWS_REG1_TGW_CON_CGW
    TGW_PEER_REQUEST = local.AWS_REG1_TGW_PEER_REQUEST
    TGW_PEER_REQUEST_ADD_ROUTE = local.AWS_REG1_TGW_PEER_REQUEST_ADD_ROUTE
    PEER_REQUEST = local.AWS_REG1_PEER_REQUEST
}

module "AWS_REG1_SERVICE" {
    source = "./modules/07.service"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_VPC1 ]
    ZONE = local.AWS_REG1_VPC1_ZONE
    ZONE_RECORD = local.AWS_REG1_ZONE_RECORD
    RESOLV_EP = local.AWS_REG1_VPC1_RESOLV_EP
    RESOLV_EP_RULE = local.AWS_REG1_VPC1_RESOLV_EP_RULE
    RT53_HC = local.AWS_REG1_VPC1_RT53_HC
    LB_TG = local.AWS_REG1_LB_TG
    LB_TG_ATT = local.AWS_REG1_LB_TG_ATT
    LB = local.AWS_REG1_LB
    LB_LS = local.AWS_REG1_LB_LS
    GAC = local.AWS_GAC
    GAC_EP = local.AWS_REG1_GAC_EP
}

module "AWS_REG2_KEY" {
    source = "./modules/01.key"
    providers = {
        aws = aws.Singapore
    }
    KEY_NAME = var.KEY["NAME"]
    KEY_BACKUP_FILE = local.KEY_FILE["AWS_REG2"].BACKUP
    KEY_SSH_FILE = local.KEY_FILE["AWS_REG2"].SSH
    KEY_HOME_FILE = local.KEY_FILE["AWS_REG2"].HOME
}

module "AWS_REG2_ADD" {
    source = "./modules/03.add"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_KEY ]
    DEFAULT_EIP_NAME = local.AWS_REG2_DEFAULT_EIP_NAME
    DEFAULT_EIP_INS_ID = local.AWS_REG2_DEFAULT_EIP_INS_ID
    ADD_EIP_NAME = local.AWS_REG2_ADD_EIP_NAME
    ADD_NIC_NAME = local.AWS_REG2_ADD_NIC_NAME
    ADD_NIC_INS_ID = local.AWS_REG2_ADD_NIC_INS_ID
    ADD_NIC_INFO = local.AWS_REG2_ADD_NIC_INFO
}

module "AWS_REG2_VPC1" {
    source = "./modules/02.vpc"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_KEY ]
    VPC = var.AWS.REG2_VPC1
    VPC_SG_NAME = local.AWS_REG2_VPC1_SG.NAME
    VPC_SG_RULE = local.AWS_REG2_VPC1_SG.RULE
    VPC_RTB = local.AWS_REG2_VPC1_RTB
}

module "AWS_REG2_VPC1_INS" {
    source = "./modules/05.ec2"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_GW ]
    INS_KEY_FILE = local.KEY_FILE["AWS_REG2"].SSH
    INS_NAME = local.AWS_REG2_VPC1_INS_NAME
    INS_INFO = local.AWS_REG2_VPC1_INS_INFO
    INS_VOL = local.AWS_REG2_VPC1_INS_DEFAULT_VOL
    INS_UD = local.AWS_REG2_VPC1_INS_UD
}

module "AWS_REG2_VPC2" {
    source = "./modules/02.vpc"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_KEY ]
    VPC = var.AWS["REG2_VPC2"]
    VPC_SG_NAME = local.AWS_REG2_VPC2_SG.NAME
    VPC_SG_RULE = local.AWS_REG2_VPC2_SG.RULE
    VPC_RTB = local.AWS_REG2_VPC2_RTB
}

module "AWS_REG2_VPC2_INS" {
    source = "./modules/05.ec2"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_GW ]
    INS_KEY_FILE = local.KEY_FILE["AWS_REG2"].SSH
    INS_NAME = local.AWS_REG2_VPC2_INS_NAME
    INS_INFO = local.AWS_REG2_VPC2_INS_INFO
    INS_VOL = local.AWS_REG2_VPC2_INS_DEFAULT_VOL
    INS_UD = local.AWS_REG2_VPC2_INS_UD
}

module "AWS_REG2_GW" {
    source = "./modules/04.gw"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_KEY ]
    IGW = local.AWS_REG2_IGW
    CGW = local.AWS_REG2_CGW
    TGW = local.AWS_REG2_TGW
}

module "AWS_REG2_CONNECTION" {
    source = "./modules/06.connection"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_GW ]
    TGW_CON_VPC = local.AWS_REG2_TGW_CON_VPC
    TGW_CON_CGW = local.AWS_REG2_TGW_CON_CGW
    TGW_PEER_ACCEPT = local.AWS_REG2_TGW_PEER_ACCEPT
    TGW_PEER_ACCEPT_ADD_ROUTE = local.AWS_REG2_TGW_PEER_ACCEPT_ADD_ROUTE
    PEER_ACCEPT = local.AWS_REG2_PEER_ACCEPT
}

module "AWS_REG2_SERVICE" {
    source = "./modules/07.service"
    providers = {
        aws = aws.Singapore
    }
    depends_on = [ module.AWS_REG2_VPC1 ]
    ZONE = local.AWS_REG2_VPC1_ZONE
    ZONE_RECORD = local.AWS_REG2_ZONE_RECORD
    RESOLV_EP = local.AWS_REG2_VPC1_RESOLV_EP
    RESOLV_EP_RULE = local.AWS_REG2_VPC1_RESOLV_EP_RULE
    RT53_HC = local.AWS_REG2_VPC1_RT53_HC
    GAC_EP = local.AWS_REG2_GAC_EP
}

module "AWS_GLOBAL_SERVICE" {
    source = "./modules/07.service"
    providers = {
        aws = aws.Seoul
    }
    depends_on = [ module.AWS_REG1_SERVICE, module.AWS_REG2_SERVICE ]
}