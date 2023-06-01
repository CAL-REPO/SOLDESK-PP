variable "INS_KEY_FILE" {
    type = string
}

variable "INS_NAME" {
    type = list(string)
    default = []
}

variable "INS_INFO" {
    type = list(object({
        KEY_NAME = string
        AMI = string
        INS_TYPE = string
        SN_ID = string
        VPC_SG_IDS = list(string)
        AUTO_PUBLIC_IP = bool
        SRC_DEST_CHECK = bool
        PRI_IPV4S = optional(list(string))
    }))
    default = []
}

variable "INS_VOL" {
    type = list(object({
        VOL_NAME = string
        VOL_SIZE = number
        VOL_TYPE = string
    }))
    default = []    
}

variable "INS_UD" {
    type = list(object({
        SCRIPT = string
    }))
    default = []
}