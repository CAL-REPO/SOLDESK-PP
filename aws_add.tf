# REG1
locals {
    AWS_REG1_EIPs = [
        {
            NAME = "AWS_SEOUL_NAT1_EIP"
            # INS_ID = module.AWS_REG1_VPC1_INS.ID[0]
            NIC_ID = module.AWS_REG1_VPC1_INS.NIC_ID[0]
        }
        ,{
            NAME = "AWS_SEOUL_NAT2_EIP"
            # INS_ID = module.AWS_REG1_VPC1_INS.ID[2]
            NIC_ID = module.AWS_REG1_VPC1_INS.NIC_ID[2]
        }
        ,{
            NAME = "IDC_SEOUL_CGW_EIP"
            # INS_ID = module.AWS_REG1_VPC2_INS.ID[0]
            NIC_ID = module.AWS_REG1_VPC2_INS.NIC_ID[0]
        }
    ]
}

# REG2
locals {
    AWS_REG2_EIPs = [
        {
            NAME = "AWS_SINGAPORE_NAT_EIP"
            # INS_ID = module.AWS_REG2_VPC1_INS.ID[0]
            NIC_ID = module.AWS_REG2_VPC1_INS.NIC_ID[0]
        }
        ,{
            NAME =  "IDC_SINGAPORE_CGW_EIP"
            # INS_ID = module.AWS_REG2_VPC2_INS.ID[0]
            NIC_ID = module.AWS_REG2_VPC2_INS.NIC_ID[0]
        }
    ]
}