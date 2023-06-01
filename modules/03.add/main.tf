# mainEC2.tf

# Standard AWS Provider Block

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 1.0"
        }
    }
}

resource "aws_eip" "DEFAULT_EIP" {
    count = (length(var.DEFAULT_EIP_NAME) > 0 ?
            length(var.DEFAULT_EIP_NAME) : 0)
    domain = "vpc"
    tags = {
        Name = "${var.DEFAULT_EIP_NAME[count.index]}"
    }
}

resource "aws_eip_association" "DEFAULT_EIP_ASS" {
    count = (length(var.DEFAULT_EIP_NAME) > 0 ?
            length(var.DEFAULT_EIP_NAME) : 0)
    depends_on = [aws_eip.DEFAULT_EIP]

    allocation_id = aws_eip.DEFAULT_EIP[count.index].id
    instance_id = var.DEFAULT_EIP_INS_ID[count.index]
}

resource "aws_eip" "ADD_EIP" {
    count = (length(var.ADD_EIP_NAME) > 0 ?
            length(var.ADD_EIP_NAME) : 0)
    domain = "vpc"
    tags = {
        Name = "${var.ADD_EIP_NAME[count.index]}"
    }
}

resource "aws_eip_association" "ADD_EIP_ASS" {
    count = (length(var.ADD_EIP_NAME) > 0 ?
            length(var.ADD_EIP_NAME) : 0)
    depends_on = [aws_eip.ADD_EIP]

    allocation_id = aws_eip.ADD_EIP[count.index].id
    network_interface_id = aws_network_interface.ADD_NIC[count.index].id
}

resource "aws_network_interface" "ADD_NIC" {
    count = (length(var.ADD_NIC_NAME) > 0 ?
            length(var.ADD_NIC_NAME) : 0)

    subnet_id       = var.ADD_NIC_INFO[count.index].SN_ID
    private_ips     = var.ADD_NIC_INFO[count.index].PRI_IPV4S
    security_groups = var.ADD_NIC_INFO[count.index].VPC_SG_IDS

    tags = {
        Name = "${var.ADD_NIC_NAME[count.index]}${count.index}"
    }
}

resource "aws_network_interface_attachment" "ADD_NIC_ATT" {
    count = (length(var.ADD_NIC_NAME) > 0 ?
            length(var.ADD_NIC_NAME) : 0)

    network_interface_id = aws_network_interface.ADD_NIC[count.index].id
    instance_id          = var.ADD_NIC_INS_ID[count.index]
    device_index         = var.ADD_NIC_INFO[count.index].EC2_NIC_INDEX
}

