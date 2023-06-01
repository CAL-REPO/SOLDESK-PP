# mainKEY.tf

# Standard AWS Provider Block

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.0"
    }
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Create private key

resource "tls_private_key" "AWS_PRI_KEY" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "AWS_KEY" {

    key_name = var.KEY_NAME
    public_key = tls_private_key.AWS_PRI_KEY.public_key_openssh

    provisioner "local-exec" {
        command = <<EOF
                sudo echo "${tls_private_key.AWS_PRI_KEY.private_key_pem}" > "${var.KEY_BACKUP_FILE}"
                sudo cp "${var.KEY_BACKUP_FILE}" "${var.KEY_SSH_FILE}"
                sudo chmod 400 "${var.KEY_SSH_FILE}"
                sudo chown $USER:$USER "${var.KEY_SSH_FILE}"
                sudo cp "${var.KEY_BACKUP_FILE}" "${var.KEY_HOME_FILE}"
                sudo chmod 400 "${var.KEY_HOME_FILE}"
                sudo chown $USER:$USER "${var.KEY_HOME_FILE}"
                EOF
    }

    lifecycle {
        create_before_destroy = true
    }
}

# # Remove private key when command terraform destroy
# resource "null_resource" "REMOVE_KEY" {
    
#     for_each = local.KEY_FILE
#     triggers = {
#         KEY_FILE_BACKUP = each.value.BACKUP
#         KEY_FILE_SSH = each.value.SSH
#     }

#     provisioner "local-exec" {
#         when    = destroy
#         command = <<EOF
#                 if [ -f "${self.triggers.KEY_FILE_BACKUP}" ]
#                 then sudo rm -rf "${self.triggers.KEY_FILE_BACKUP}"
#                 fi
#                 if [ -f "${self.triggers.KEY_FILE_SSH}" ]
#                 then sudo rm -rf "${self.triggers.KEY_FILE_SSH}"
#                 fi
#                 EOF
#     }
  
# }