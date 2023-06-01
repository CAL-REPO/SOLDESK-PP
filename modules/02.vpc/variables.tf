variable "VPC" {
    type = any
    default = []
}

variable "VPC_SG_NAME" {
    type = list(string)
    default = []
}

variable "VPC_SG_RULE" {
    type = list(object({
        INGRESS = list(object({
            from_port   = string
            to_port     = string
            protocol    = string
            cidr_blocks = list(string)
            description = string
        }))
        EGRESS = list(object({
            from_port   = string
            to_port     = string
            protocol    = string
            cidr_blocks = list(string)
            description = string
        }))
        }))
    default = []
}

variable "VPC_RTB" {
    type = list(object({
        NAME = string
        SN_ID = string
        ROUTE = list(object({
            cidr_block                  = optional(string)
            ipv6_cidr_block             = optional(string)
            egress_only_gateway_id      = optional(string)
            gateway_id                  = optional(string)
            nat_gateway_id              = optional(string)
            network_interface_id        = optional(string)
            transit_gateway_id          = optional(string)
            vpc_endpoint_id             = optional(string)
            vpc_peering_connection_id   = optional(string)
            SN_ID                       = optional(string)
        }))
    }))
    default = []
}

