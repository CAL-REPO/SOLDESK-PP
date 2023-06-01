variable "DEFAULT_EIP_NAME" {
    type = list(string)
    default = []
}

variable "DEFAULT_EIP_INS_ID" {
    type = list(string)
    default = []
}

variable "ADD_EIP_NAME" {
    type = list(string)
    default = []
}

variable "ADD_EIP_NIC_ID" {
    type = list(string)
    default = []
}

variable "ADD_NIC_NAME" {
    type = list(string)
    default = []
}

variable "ADD_NIC_INS_ID" {
    type = list(string)
    default = []
}

variable "ADD_NIC_INFO" {
    type = list(object({
        SN_ID = optional(string)
        PRI_IPV4S = optional(list(string))
        VPC_SG_IDS = optional(list(string))
        EC2_NIC_INDEX = optional(number)
       
    }))
    default = []
}