# variables.tfvars

ENV = {
    PROFILE = "thkim"
}

KEY = {
    NAME = "AWS_CDN_PRI_KEY"
    FORMAT = "pem"
    DIR = "/mnt/c/Users/thkim/CALife/CALife - CODE/01.KEY/AWS"
    SSH-DIR = "$HOME/.ssh"
    HOME-DIR = "$HOME"
    INS-DIR = "/home/ec2-user"
}

REGIONS = {
    AWS_REG1 = { NAME = "Seoul", CODE = "ap-northeast-2"}
    AWS_REG2 = { NAME = "Singapore", CODE = "ap-southeast-1"}
}