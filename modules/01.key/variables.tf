variable "KEY_NAME" {
    description = "The name for the new key pair."
    type = string
    default = ""
}

variable "KEY_BACKUP_FILE" {
    description = "The back up directory file for the new private key."
    type = string
    default = ""
}

variable "KEY_SSH_FILE" {
    description = "The SSH directory file for the new private key."
    type = string
    default = ""
}

variable "KEY_HOME_FILE" {
    description = "The HOME directory file for the new private key."
    type = string
    default = ""
}