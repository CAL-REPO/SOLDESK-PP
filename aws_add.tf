# REG1
locals {
    AWS_REG1_EIPs = [
        {
            NAME = "SEOUL_VPC1_INS1_NAT1_EIP"
            # INS_ID = module.AWS_REG1_VPC1_INS.ID[0]
            NIC_ID = module.AWS_REG1_VPC1_INS.NIC_ID[0]
        }
        ,{
            NAME = "SEOUL_VPC1_INS3_NAT2_EIP"
            # INS_ID = module.AWS_REG1_VPC1_INS.ID[2]
            NIC_ID = module.AWS_REG1_VPC1_INS.NIC_ID[2]
        }
        ,{
            NAME = "SEOUL_VPC2_INS1_CGW_EIP"
            # INS_ID = module.AWS_REG1_VPC2_INS.ID[0]
            NIC_ID = module.AWS_REG1_VPC2_INS.NIC_ID[0]
        }
    ]
}

# REG2
locals {
    AWS_REG2_EIPs = [
        {
            NAME = "SINGAPORE_VPC1_INS_NAT1_EIP"
            # INS_ID = module.AWS_REG2_VPC1_INS.ID[0]
            NIC_ID = module.AWS_REG2_VPC1_INS.NIC_ID[0]
        }
        ,{
            NAME =  "SINGAPORE_VPC2_`INS_CGW_EIP"
            # INS_ID = module.AWS_REG2_VPC2_INS.ID[0]
            NIC_ID = module.AWS_REG2_VPC2_INS.NIC_ID[0]
        }
    ]
}