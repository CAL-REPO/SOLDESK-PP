# Provider Data
locals {

    PRJ = {
        NAME = "SPP"
        VERSION = "1.0"
    }

    AWS_PROFILE = "thkim"

    AWS_REGIONs = [
        {
            NAME = "Seoul"
            CODE = "ap-northeast-2"
        }
        ,{
            NAME = "Singapore"
            CODE = "ap-southeast-1"
        }
    ]

    AWS_PROFILEs = {
        for EACH, AWS_REGION in local.AWS_REGIONs:
            EACH => {
                NAME = "${local.AWS_PROFILE}-${AWS_REGION.NAME}"
            }
    }

}