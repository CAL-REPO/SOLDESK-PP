# REG1
locals {
    AWS_REG1_KEYs = [
        {
            NAME = "${local.PRJ.NAME}-AWS-${local.AWS_PROFILEs[0].NAME}" 
            ALGORITHM = "RSA"
            RSA_SIZE = 4096
            WIN_DIR = "/mnt/c/Users/thkim/CALife/CALife - CODE/01.KEY/AWS"
            LINUX_DIR = "$HOME/.ssh"
        }
    ]
}

# REG2
locals {
    AWS_REG2_KEYs = [
        {
            NAME = "${local.PRJ.NAME}-AWS-${local.AWS_PROFILEs[1].NAME}" 
            ALGORITHM = "RSA"
            RSA_SIZE = 4096
            WIN_DIR = "/mnt/c/Users/thkim/CALife/CALife - CODE/01.KEY/AWS"
            LINUX_DIR = "$HOME/.ssh"
        }
    ]
}