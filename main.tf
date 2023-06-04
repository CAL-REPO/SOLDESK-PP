# Standard AWS Provider Block
terraform {
    required_version = ">= 1.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 5.0"
        }
    }
}

# AWS_REG1
provider "aws" {
    region = local.AWS_REGIONs[0].CODE
    profile = local.AWS_PROFILEs[0].NAME
    alias = "Seoul"
}

module "AWS_REG1_KEY" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-EC2KEY.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    KEYs = local.AWS_REG1_KEYs
}

module "AWS_REG1_ADD" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-ADD.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    EIPs = local.AWS_REG1_EIPs
}

module "AWS_REG1_VPC1" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-VPC.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    VPC = local.AWS_REG1_VPC1
    SGs = local.AWS_REG1_VPC1_SGs
    RTBs = local.AWS_REG1_VPC1_RTBs
}

module "AWS_REG1_VPC1_INS" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-EC2INS.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    INSs = local.AWS_REG1_VPC1_INSs
    INS_UDs = local.AWS_REG1_VPC1_INS_UDs
}

module "AWS_REG1_VPC2" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-VPC.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    VPC = local.AWS_REG1_VPC2
    SGs = local.AWS_REG1_VPC2_SGs
    RTBs = local.AWS_REG1_VPC2_RTBs
}

module "AWS_REG1_VPC2_INS" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-EC2INS.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    INSs = local.AWS_REG1_VPC2_INSs
    INS_UDs = local.AWS_REG1_VPC2_INS_UDs
}

module "AWS_REG1_CONNECTION" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-CONNECTION.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    IGW = local.AWS_REG1_IGW
    CGW = local.AWS_REG1_CGW
    TGW = local.AWS_REG1_TGW    
    TGW_CON_VPC = local.AWS_REG1_TGW_CON_VPC
    TGW_CON_CGW = local.AWS_REG1_TGW_CON_CGW
    TGW_PEER_REQUEST = local.AWS_REG1_TGW_PEER_REQUEST
    TGW_PEER_REQUEST_ADD_ROUTE = local.AWS_REG1_TGW_PEER_REQUEST_ADD_ROUTE
    PEER_REQUEST = local.AWS_REG1_PEER_REQUEST
}

module "AWS_REG1_SERVICE" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-SERVICE.git"
    providers = {
        aws = aws.Seoul
    }

    PROFILE = local.AWS_PROFILEs[0].NAME
    RT53_ZONE = local.AWS_REG1_RT53_ZONE
    RT53_ZONE_RECORD = local.AWS_REG1_RT53_ZONE_RECORD
    RT53_HC =  local.AWS_REG1_RT53_HC
    RT53_RESOLV_EP = local.AWS_REG1_RT53_RESOLV_EP
    RT53_RESOLV_EP_RULE = local.AWS_REG1_RT53_RESOLV_EP_RULE
    LB_TG = local.AWS_REG1_LB_TG
    LB_TG_ATT = local.AWS_REG1_LB_TG_ATT
    LB = local.AWS_REG1_LB
    LB_LS = local.AWS_REG1_LB_LS
    GAC = local.AWS_GAC
    GAC_EP = local.AWS_REG1_GAC_EP
}

# AWS_REG2
provider "aws" {
    region = local.AWS_REGIONs[1].CODE
    profile = local.AWS_PROFILEs[1].NAME
    alias = "Singapore"
}

module "AWS_REG2_KEY" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-EC2KEY.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    KEYs = local.AWS_REG2_KEYs
}

module "AWS_REG2_ADD" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-ADD.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    EIPs = local.AWS_REG2_EIPs
}

module "AWS_REG2_VPC1" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-VPC.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    VPC = local.AWS_REG2_VPC1
    SGs = local.AWS_REG2_VPC1_SGs
    RTBs = local.AWS_REG2_VPC1_RTBs
}

module "AWS_REG2_VPC1_INS" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-EC2INS.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    INSs = local.AWS_REG2_VPC1_INSs
    INS_UDs = local.AWS_REG2_VPC1_INS_UDs
}

module "AWS_REG2_VPC2" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-VPC.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    VPC = local.AWS_REG2_VPC2
    SGs = local.AWS_REG2_VPC2_SGs
    RTBs = local.AWS_REG2_VPC2_RTBs
}

module "AWS_REG2_VPC2_INS" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-EC2INS.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    INSs = local.AWS_REG2_VPC2_INSs
    INS_UDs = local.AWS_REG2_VPC2_INS_UDs
}

module "AWS_REG2_CONNECTION" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-CONNECTION.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    IGW = local.AWS_REG2_IGW
    CGW = local.AWS_REG2_CGW
    TGW = local.AWS_REG2_TGW
    TGW_CON_VPC = local.AWS_REG2_TGW_CON_VPC
    TGW_CON_CGW = local.AWS_REG2_TGW_CON_CGW    
    TGW_PEER_ACCEPT = local.AWS_REG2_TGW_PEER_ACCEPT
    TGW_PEER_ACCEPT_ADD_ROUTE = local.AWS_REG2_TGW_PEER_ACCEPT_ADD_ROUTE
    PEER_ACCEPT = local.AWS_REG2_PEER_ACCEPT
}

module "AWS_REG2_SERVICE" {
    source = "git@github.com:CAL-REPO/TERRAFORM-AWS-SERVICE.git"
    providers = {
        aws = aws.Singapore
    }

    PROFILE = local.AWS_PROFILEs[1].NAME
    RT53_ZONE = local.AWS_REG2_RT53_ZONE
    RT53_ZONE_RECORD = local.AWS_REG2_RT53_ZONE_RECORD
    RT53_HC =  local.AWS_REG2_RT53_HC
    RT53_RESOLV_EP = local.AWS_REG2_RT53_RESOLV_EP
    RT53_RESOLV_EP_RULE =local.AWS_REG2_RT53_RESOLV_EP_RULE
    GAC_EP = local.AWS_REG2_GAC_EP    
}
