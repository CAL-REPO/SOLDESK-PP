
variable "IGW" {
    type = list(object({
        NAME = string
        VPC_ID = string
    }))
    default = []
}

variable "NAT" {
    type = list(object({
        NAME = string
        VPC_ID = string
    }))    
    default = []
}

variable "VGW" {
    type = list(object({
        NAME = string
        AWS_ASN = string
        VPC_ID = string
        ZONE = string
    }))
    default = []    
}

variable "CGW" {
    type = list(object({
        NAME = string
        BGP_ASN = string
        IP = string
        TYPE = string 
    }))
    default = []
}

variable "TGW" {
    type = list(object({
        NAME = string
        AWS_ASN =string
        DNS_SUP = string
        VPN_DEFAULT_RTB_ASS = optional(string)
        VPN_DEFAULT_RTB_PROP = optional(string)
        VPN_ECMP_SUP = string
        MULTICAST_SUP = string
        AUTO_CROSS_ACC_ATT = string
        CIDRS = optional(list(string))
    }))
    default = []   
}