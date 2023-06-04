# REG1
locals {
    AWS_REG1_RT53_ZONE = [
        {  
            NAME = "SEOUL_AWS"
            REGION_ID = local.AWS_REGIONs[0].CODE
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID                
            DOMAIN_NAME = "awsseoul.internal"
            TYPE_PRIVATE = true
        }
    ]

    AWS_REG1_RT53_ZONE_RECORD = [
        {
            ZONE_ID = module.AWS_REG1_SERVICE.RT53_ZONE_ID[0]
            NAME = "websrv1.${local.AWS_REG1_RT53_ZONE[0].DOMAIN_NAME}"               
            TYPE = "A"
            TTL = 300
            IPs = ["10.1.3.100"]
        }
        ,{
            ZONE_ID = module.AWS_REG1_SERVICE.RT53_ZONE_ID[0]
            NAME = "websrv2.${local.AWS_REG1_RT53_ZONE[0].DOMAIN_NAME}"               
            TYPE = "A"
            TTL = 300
            IPs = ["10.1.4.100"]
        }
    ]

    AWS_REG1_RT53_HC = [
        { 
            NAME                = "websrv1_health"
            DOMAIN              = "websrv1.${local.AWS_REG1_RT53_ZONE[0].DOMAIN_NAME}"
            PROTOCOL            = "HTTP"
            PORT                = 80
            RESOURCE_PATH       = "/var/www/html/db.php"
            FAIL_THRESHOLD      = "5"
            REQ_INTERVAL        = "30"
        }
        ,{
            NAME                = "websrv2_health"
            DOMAIN              = "websrv2.${local.AWS_REG1_RT53_ZONE[0].DOMAIN_NAME}"
            PROTOCOL            = "HTTP"
            PORT                = 80
            RESOURCE_PATH       = "/var/www/html/db.php"
            FAIL_THRESHOLD      = "5"
            REQ_INTERVAL        = "30"
        }
    ]

    AWS_REG1_RT53_RESOLV_EP = [
        {  
            NAME        = "AWS_SEOUL_EP_IN"
            DIRECTION   = "INBOUND"
            SG_IDs      = [module.AWS_REG1_VPC1.SG_ID[0]]
            IPs = [
                {
                    SN_ID = module.AWS_REG1_VPC1.Za_SN2_ID 
                    IP = "10.1.3.150"
                }
                ,{
                    SN_ID = module.AWS_REG1_VPC1.Zc_SN2_ID
                    IP = "10.1.4.150"
                }
            ]
        }
        ,{  
            NAME        = "AWS_SEOUL_EP_OUT"
            DIRECTION   = "OUTBOUND"
            SG_IDs      = [module.AWS_REG1_VPC1.SG_ID[0]]
            IPs = [
                {
                    SN_ID = module.AWS_REG1_VPC1.Za_SN1_ID
                    IP = "10.1.1.150"
                }
                ,{
                    SN_ID = module.AWS_REG1_VPC1.Zc_SN1_ID
                    IP = "10.1.2.150"
                }
            ]
        }            
    ]

    AWS_REG1_RT53_RESOLV_EP_RULE = [
        {  
            NAME            = "EP_OUT_IDCSEOUL"
            EP_ID           = module.AWS_REG1_SERVICE.RT53_RESOLVE_EP_ID[1]
            DOMAIN_NAME     = "idcseoul.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG1_VPC1.VPC_ID
            IPs = [
                {
                    IP = "10.2.1.200"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_AWSSINGAPORE"
            EP_ID           = module.AWS_REG1_SERVICE.RT53_RESOLVE_EP_ID[1]
            DOMAIN_NAME     = "awssingapore.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG1_VPC1.VPC_ID
            IPs = [
                {
                    IP = "10.3.0.2"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_IDCSINGAPORE"
            EP_ID           = module.AWS_REG1_SERVICE.RT53_RESOLVE_EP_ID[1]
            DOMAIN_NAME     = "idcsingapore.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG1_VPC1.VPC_ID
            IPs = [
                {
                    IP = "10.4.1.200"
                }
            ]
        }        
    ]

    AWS_REG1_LB_TG = [
        {
            NAME = "SEOUL-LB-TG"
            TARGET_TYPE = "instance" # "instance", "ip", "lambda", "alb"
            PORT = 80
            PROTOCOL = "HTTP"
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID
            HC_ENABLE = true
            HC_PROTOCOL = "HTTP"
            HC_PORT = "traffic-port"
            HC_PATH = "/index.html"
            HC_HEALTHY_THRESHOLD = null
            HC_UNHEALTY_THRESHOLD = null
            HC_TIMEOUT = null
            HC_INTERVAL = null
            HC_MATCHER = null
        }
    ]

    AWS_REG1_LB_TG_ATT = [
        {
            TG_ID = module.AWS_REG1_SERVICE.LB_TG_ID[0]
            TARGET_ID = module.AWS_REG1_VPC1_INS.ID[1]
            PORT = 80
        }
        ,{
            TG_ID = module.AWS_REG1_SERVICE.LB_TG_ID[0]
            TARGET_ID = module.AWS_REG1_VPC1_INS.ID[3]
            PORT = 80
        }
    ]

    AWS_REG1_LB = [
        {
        
            NAME = "SEOUL-LB"
            TYPE = "application" # "application", "network"
            INTERNAL = false
            SNs = [module.AWS_REG1_VPC1.Za_SN1_ID, module.AWS_REG1_VPC1.Zc_SN1_ID]
            DELETE_PROTECTION = false
            SGs = [module.AWS_REG1_VPC1.SG_ID[3]] # "application"
            # SNs_MAP = [
            #     {
            #         SN_ID     = ""
            #         EIP_ID    = ""
            #     }
            # ]

        }
    ]

    AWS_REG1_LB_LS = [
        {
            NAME        = "SEOUL_LB_LS"
            PRIORITY    = 100
            PORT        = 80
            DEFAULT_ACTION = [
                {
                    TYPE    = "forward"
                    TG_ID   = module.AWS_REG1_SERVICE.LB_TG_ID[0]
                }
            ]
            # ACTION = [
            #     {
            #         TYPE    = "forward"
            #         TG_ID   = module.AWS_REG1_SERVICE.LB_TG_ID[0]
            #     }
            # ]
            # CONDITION = [
            #     {
            #         PATH_PATTERN_VALUE = []
            #         HOST_HEADER_VALUE = []
            #         HTTP_HEADER_NAME = ""
            #         HTTP_HEADER_VALUE = []
            #         QUERY_STRING_KEY = ""
            #         QUERY_STRING_VALUE = ""
            #     }
            # ]
            # FORWARD = [
            #     {
            #         TG_ID = ""
            #         TG_WEIGHT = 0
            #         STICK_ENABLE = false
            #         STICK_DURATION = 0
            #     }
            # ]

        }
    ]
}

# REG2
locals {
        
    AWS_REG2_RT53_ZONE = [
        {  
            NAME = "SINGAPORE_AWS"
            REGION_ID = local.AWS_REGIONs[1].CODE
            VPC_ID = module.AWS_REG2_VPC1.VPC_ID
            DOMAIN_NAME = "awssingapore.internal"
            TYPE_PRIVATE = true
        }
    ]

    AWS_REG2_RT53_ZONE_RECORD = [
        {
            ZONE_ID = module.AWS_REG2_SERVICE.RT53_ZONE_ID[0]
            NAME = "websrv1.${local.AWS_REG2_RT53_ZONE[0].DOMAIN_NAME}"           
            TYPE = "A"
            TTL = 300
            IPs = ["10.3.3.100"]
        }
    ]

    AWS_REG2_RT53_HC = [
        {
            NAME                = "websrv1_health"
            DOMAIN              = "websrv1.${local.AWS_REG2_RT53_ZONE[0].DOMAIN_NAME}"
            PROTOCOL            = "HTTP"
            PORT                = 80
            RESOURCE_PATH       = "/index.html"
            FAIL_THRESHOLD      = "5"
            REQ_INTERVAL        = "30"
        }
    ]

    AWS_REG2_RT53_RESOLV_EP = [
        {  
            NAME        = "AWS_SINGAPORE_EP_IN"
            DIRECTION   = "INBOUND"
            SG_IDs      = [module.AWS_REG2_VPC1.SG_ID[0]]
            IPs = [
                {
                    SN_ID = module.AWS_REG2_VPC1.Za_SN2_ID 
                    IP = "10.3.3.150"
                }
                ,{
                    SN_ID = module.AWS_REG2_VPC1.Zc_SN2_ID
                    IP = "10.3.4.150"
                }
            ]
        }
        ,{  
            NAME        = "AWS_SINGAPORE_EP_OUT"
            DIRECTION   = "OUTBOUND" 
            SG_IDs      = [module.AWS_REG2_VPC1.SG_ID[0]]
            IPs = [
                {
                    SN_ID = module.AWS_REG2_VPC1.Za_SN1_ID
                    IP = "10.3.1.150"
                }
                ,{
                    SN_ID = module.AWS_REG2_VPC1.Za_SN1_ID
                    IP = "10.3.1.160"
                }
            ]
        }            
    ]

    AWS_REG2_RT53_RESOLV_EP_RULE = [
        {  
            NAME            = "EP_OUT_IDCSINGAPORE"
            EP_ID           = module.AWS_REG2_SERVICE.RT53_RESOLVE_EP_ID[1]
            DOMAIN_NAME     = "idcsingapore.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG2_VPC1.VPC_ID
            IPs = [
                {
                    IP = "10.4.1.200"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_AWSSEOUL"
            EP_ID           = module.AWS_REG2_SERVICE.RT53_RESOLVE_EP_ID[1]
            DOMAIN_NAME     = "awsseoul.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG2_VPC1.VPC_ID
            IPs = [
                {
                    IP = "10.1.0.2"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_IDCSEOUL"
            EP_ID           = module.AWS_REG2_SERVICE.RT53_RESOLVE_EP_ID[1]
            DOMAIN_NAME     = "idcseoul.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG2_VPC1.VPC_ID
            IPs = [
                {
                    IP = "10.2.1.200"
                }
            ]
        }
    ]


}

# GLOBAL
locals {

    AWS_GAC = [
        {
            NAME = "SEOUL-SINGAPORE-GAC"
            IP_TYPE = "IPV4"
            # IPs = ""
            ENABLED = true
            LS_AFFINITY = "SOURCE_IP"
            LS_PROTOCOL = "TCP"
            LS_PORT_RANGE = [
                {
                    FROM = 80
                    TO = 80
                }
            ]
        }
    ]
    AWS_REG1_GAC_EP = [
        {
            LS_ID = module.AWS_REG1_SERVICE.GAC_LS_ID[0]
            HC_PROTOCOL = "HTTP"
            HC_PORT = 80
            HC_PATH = "/index.html"
            HC_INTERVAL = 30
            HC_THRESOLD_COUNT = null
            HC_DIST_VALUE = 100
            CONFIGURATION = [
                {
                    IP_PRESERVATION = true
                    ID = module.AWS_REG1_SERVICE.LB_ID[0]
                    WEIGHT = 100
                }
            ]
        }
    ]

    AWS_REG2_GAC_EP = [
        {
            LS_ID = module.AWS_REG1_SERVICE.GAC_LS_ID[0]
            HC_PROTOCOL = "HTTP"
            HC_PORT = 80
            HC_PATH = "/index.html"
            HC_INTERVAL = 30
            HC_THRESOLD_COUNT = null
            HC_DIST_VALUE = 100
            CONFIGURATION = [
                {
                    IP_PRESERVATION = true
                    ID = module.AWS_REG2_VPC1_INS.ID[0]
                    WEIGHT = 100
                }
            ]
        }
    ]    
}


