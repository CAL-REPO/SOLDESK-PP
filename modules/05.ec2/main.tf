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

resource "aws_instance" "EC2" {
    count = (length(var.INS_NAME) > 0 ?
            length(var.INS_NAME) : 0)

    key_name      = var.INS_INFO[count.index].KEY_NAME
    ami           = var.INS_INFO[count.index].AMI
    instance_type = var.INS_INFO[count.index].INS_TYPE
    tags = {
        Name = "${var.INS_NAME[count.index]}"
    }
    
    associate_public_ip_address = var.INS_INFO[count.index].AUTO_PUBLIC_IP == false ? null : var.INS_INFO[count.index].AUTO_PUBLIC_IP
    subnet_id     = var.INS_INFO[count.index].AUTO_PUBLIC_IP == false ? null : var.INS_INFO[count.index].SN_ID
    vpc_security_group_ids = var.INS_INFO[count.index].AUTO_PUBLIC_IP == false ? null : var.INS_INFO[count.index].VPC_SG_IDS 
    private_ip     = var.INS_INFO[count.index].AUTO_PUBLIC_IP == false ? null : var.INS_INFO[count.index].PRI_IPV4S[0]
    source_dest_check = var.INS_INFO[count.index].AUTO_PUBLIC_IP == false ? null : var.INS_INFO[count.index].SRC_DEST_CHECK

    dynamic "ebs_block_device" {
        for_each = var.INS_INFO[count.index]
        content {
            device_name = var.INS_VOL[count.index].VOL_NAME
            volume_size = var.INS_VOL[count.index].VOL_SIZE
            volume_type = var.INS_VOL[count.index].VOL_TYPE
            tags = {
                Name = "${var.INS_NAME[count.index]}_VOL"
            }
        }
    }

    dynamic "network_interface" {
        for_each = var.INS_INFO[count.index].AUTO_PUBLIC_IP == false ? [1] : []
        content {
            device_index         = 0
            network_interface_id = aws_network_interface.DEFAULT_NIC[count.index].id
        }
    }

    user_data = var.INS_UD[count.index].SCRIPT == ""  ? null : var.INS_UD[count.index].SCRIPT

}

resource "aws_network_interface" "DEFAULT_NIC" {
    count = (length(var.INS_NAME) > 0 ?
            length(var.INS_NAME) : 0)

    subnet_id       = var.INS_INFO[count.index].SN_ID
    security_groups = var.INS_INFO[count.index].VPC_SG_IDS
    private_ips     = var.INS_INFO[count.index].AUTO_PUBLIC_IP == true ? null : var.INS_INFO[count.index].PRI_IPV4S
    source_dest_check = var.INS_INFO[count.index].SRC_DEST_CHECK 

    tags = {
        Name = "${var.INS_NAME[count.index]}_DEFAULT_NIC"
    }
}
