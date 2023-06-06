# REG1
locals {
    AWS_REG1_EIPs = [
        {
            NAME = "AWS-SEOUL-NAT1-EIP"
            # INS_ID = module.AWS_REG1_VPC1_INS.ID[0]
            NIC_ID = module.AWS_REG1_VPC1_INS.NIC_ID[0]
        }
        ,{
            NAME = "AWS-SEOUL-NAT2-EIP"
            # INS_ID = module.AWS_REG1_VPC1_INS.ID[2]
            NIC_ID = module.AWS_REG1_VPC1_INS.NIC_ID[2]
        }
        ,{
            NAME = "IDC-SEOUL-CGW-EIP"
            # INS_ID = module.AWS_REG1_VPC2_INS.ID[0]
            NIC_ID = module.AWS_REG1_VPC2_INS.NIC_ID[0]
        }
    ]
}

# REG2
locals {
    AWS_REG2_EIPs = [
        {
            NAME = "AWS-SINGAPORE-NAT-EIP"
            # INS_ID = module.AWS_REG2_VPC1_INS.ID[0]
            NIC_ID = module.AWS_REG2_VPC1_INS.NIC_ID[0]
        }
        ,{
            NAME = "IDC-SINGAPORE-CGW-EIP"
            # INS_ID = module.AWS_REG2_VPC2_INS.ID[0]
            NIC_ID = module.AWS_REG2_VPC2_INS.NIC_ID[0]
        }
    ]
}