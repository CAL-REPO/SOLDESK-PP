# variables.tf

variable ENV {type = map}
variable KEY {type = map}
variable REGIONS {
    type = map(object({
        NAME = string
        CODE = string
    }))
}

variable AWS {
    default = {
        REG1_VPC1 = {
            VPC_NAME        = "SEOUL_VPC"
            CIDR            = "10.1.0.0/16"
            DNS_SUP         = true
            DNS_HOST        = true
            RESOLVER_DEFAULT_RULE = "ENABLE"
            DEFAULT_DHCP    = true
            DHCP_NAME       = ""
            DOMAIN          = ""
            DOMAIN_NS       = []
            DOMAIN_NTP      = []
            DOMAIN_NBS      = []
            DOMAIN_NODE     = null
            Z1_SN1_NAME     = "SEOUL_Z1_SN1_NAT1"
            Z1_SN2_NAME     = "SEOUL_Z1_SN2_WEB1"
            Z1_SN3_NAME     = ""
            Z2_SN1_NAME     = ""
            Z2_SN2_NAME     = ""
            Z2_SN3_NAME     = ""
            Z3_SN1_NAME     = "SEOUL_Z3_SN1_NAT2"
            Z3_SN2_NAME     = "SEOUL_Z3_SN2_WEB2"
            Z3_SN3_NAME     = ""
            Z1_SN1_CIDR     = "10.1.1.0/24"
            Z1_SN2_CIDR     = "10.1.3.0/24"
            Z1_SN3_CIDR     = ""
            Z2_SN1_CIDR     = ""
            Z2_SN2_CIDR     = ""
            Z2_SN3_CIDR     = ""
            Z3_SN1_CIDR     = "10.1.2.0/24"
            Z3_SN2_CIDR     = "10.1.4.0/24"
            Z3_SN3_CIDR     = ""
        },
        REG1_VPC2 = {
            VPC_NAME        = "SEOUL_IDC_VPC"
            CIDR            = "10.2.0.0/16"
            DNS_SUP         = true
            DNS_HOST        = true
            RESOLVER_DEFAULT_RULE = "ENABLE"
            DEFAULT_DHCP    = true
            DHCP_NAME       = ""
            DOMAIN          = ""
            DOMAIN_NS       = []
            DOMAIN_NTP      = []
            DOMAIN_NBS      = []
            DOMAIN_NODE     = null
            Z1_SN1_NAME     = "SEOUL_IDC_Z1_SN1_CGW"
            Z1_SN2_NAME     = "SEOUL_IDC_Z1_SN2_DB_DNS"
            Z1_SN3_NAME     = ""
            Z2_SN1_NAME     = ""
            Z2_SN2_NAME     = ""
            Z2_SN3_NAME     = ""
            Z3_SN1_NAME     = ""
            Z3_SN2_NAME     = ""
            Z3_SN3_NAME     = ""
            Z1_SN1_CIDR     = "10.2.0.0/24"
            Z1_SN2_CIDR     = "10.2.1.0/24"
            Z1_SN3_CIDR     = ""
            Z2_SN1_CIDR     = ""
            Z2_SN2_CIDR     = ""
            Z2_SN3_CIDR     = ""
            Z3_SN1_CIDR     = ""
            Z3_SN2_CIDR     = ""
            Z3_SN3_CIDR     = ""
        },
        REG2_VPC1 = {
            VPC_NAME        = "SINGAPORE_VPC"
            CIDR            = "10.3.0.0/16"
            DNS_SUP         = true
            DNS_HOST        = true
            RESOLVER_DEFAULT_RULE = "ENABLE"
            DEFAULT_DHCP    = true
            DHCP_NAME       = ""
            DOMAIN          = ""
            DOMAIN_NS       = []
            DOMAIN_NTP      = []
            DOMAIN_NBS      = []
            DOMAIN_NODE     = null
            Z1_SN1_NAME     = "SINGAPORE_Z1_SN1_NAT1"
            Z1_SN2_NAME     = "SINGAPORE_Z1_SN2_WEB1"
            Z1_SN3_NAME     = ""
            Z2_SN1_NAME     = ""
            Z2_SN2_NAME     = ""
            Z2_SN3_NAME     = ""
            Z3_SN1_NAME     = ""
            Z3_SN2_NAME     = "SINGAPORE_Z3_SN2"
            Z3_SN3_NAME     = ""
            Z1_SN1_CIDR     = "10.3.1.0/24"
            Z1_SN2_CIDR     = "10.3.3.0/24"
            Z1_SN3_CIDR     = ""
            Z2_SN1_CIDR     = ""
            Z2_SN2_CIDR     = ""
            Z2_SN3_CIDR     = ""
            Z3_SN1_CIDR     = ""
            Z3_SN2_CIDR     = "10.3.4.0/24"
            Z3_SN3_CIDR     = ""
        },
        REG2_VPC2 = {
            VPC_NAME        = "SINGAPORE_IDC_VPC"
            CIDR            = "10.4.0.0/16"
            DNS_SUP         = true
            DNS_HOST        = true
            RESOLVER_DEFAULT_RULE = "ENABLE"
            DEFAULT_DHCP    = true
            DHCP_NAME       = ""
            DOMAIN          = ""
            DOMAIN_NS       = []
            DOMAIN_NTP      = []
            DOMAIN_NBS      = []
            DOMAIN_NODE     = null
            Z1_SN1_NAME     = "SINGAPORE_IDC_Z1_SN1_CGW"
            Z1_SN2_NAME     = "SINGAPORE_IDC_Z1_SN2_DB_DNS"
            Z1_SN3_NAME     = ""
            Z2_SN1_NAME     = ""
            Z2_SN2_NAME     = ""
            Z2_SN3_NAME     = ""
            Z3_SN1_NAME     = ""
            Z3_SN2_NAME     = ""
            Z3_SN3_NAME     = ""
            Z1_SN1_CIDR     = "10.4.0.0/24"
            Z1_SN2_CIDR     = "10.4.1.0/24"
            Z1_SN3_CIDR     = ""
            Z2_SN1_CIDR     = ""
            Z2_SN2_CIDR     = ""
            Z2_SN3_CIDR     = ""
            Z3_SN1_CIDR     = ""
            Z3_SN2_CIDR     = ""
            Z3_SN3_CIDR     = ""
        }                
    }
}

locals  {
########## REG1 ##########

    AWS_REG1_DEFAULT_EIP_NAME = ["SEOUL_VPC1_INS1_NAT1_EIP", "SEOUL_VPC1_INS2_NAT2_EIP", "SEOUL_VPC2_INS1_CGW_EIP"]
    AWS_REG1_DEFAULT_EIP_INS_ID = [module.AWS_REG1_VPC1_INS.EC2_ID[0], module.AWS_REG1_VPC1_INS.EC2_ID[1], module.AWS_REG1_VPC2_INS.EC2_ID[0]]

    AWS_REG1_ADD_EIP_NAME = []
    AWS_REG1_ADD_NIC_NAME = []
    AWS_REG1_ADD_NIC_INS_ID = []
    AWS_REG1_ADD_NIC_INFO = []
    AWS_REG1_ADD_VOL_NAME = []
    AWS_REG1_ADD_VOL_INS_ID = []
    AWS_REG1_ADD_VOL_INFO = []

########## REG1 VPC1 ##########

    AWS_REG1_VPC1_SG = {
        NAME = ["SEOUL_VPC_NAT_SG", "SEOUL_VPC_WEB1_SG", "SEOUL_VPC_WEB2_SG", "SEOUL_VPC_ALB_SG"]   
        RULE = [
            # Rule1
            {
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                    ,{
                        from_port   = 500
                        to_port     = 500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }
                    ,{
                        from_port   = 4500
                        to_port     = 4500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }                         
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule2
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule3
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule4
            ,{
                INGRESS = [
                    {
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
        ]
    }

    AWS_REG1_VPC1_RTB = [
        # RTB1
        {   
            NAME = "VPC1_Z1_SN1_RTB" 
            SN_ID = module.AWS_REG1_VPC1.Z1_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_GW.IGW_ID[0]                        
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    transit_gateway_id = module.AWS_REG1_GW.TGW_ID[0]                        
                }
                ,{
                    cidr_block = "10.3.0.0/16"
                    transit_gateway_id = module.AWS_REG1_GW.TGW_ID[0]                        
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    transit_gateway_id = module.AWS_REG1_GW.TGW_ID[0]                        
                }                                
            ]
        }
        # RTB2
        ,{
            NAME = "VPC1_Z1_SN2_RTB"
            SN_ID = module.AWS_REG1_VPC1.Z1_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }
            ]
        }
        # RTB3
        ,{
            NAME = "VPC1_Z3_SN1_RTB"
            SN_ID = module.AWS_REG1_VPC1.Z3_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_GW.IGW_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.3.0.0/16"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[0]
                }                                                    
            ]
        }
        # RTB4
        ,{
            NAME = "VPC1_Z3_SN2_RTB"
            SN_ID = module.AWS_REG1_VPC1.Z3_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG1_VPC1_INS.DEFAULT_NIC_ID[1]
                }
            ]
        }
    ]

########## REG1 VPC1 INS ##########
    AWS_REG1_VPC1_INS_NAME = ["SEOUL_INS1_NAT1", "SEOUL_INS2_NAT2", "SEOUL_INS3_WEB1", "SEOUL_INS4_WEB2"]
    AWS_REG1_VPC1_INS_INFO = [
        # INS1
        {
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-0d6df09d036a47c3d"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC1.Z1_SN1_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC1.SG_ID[0]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.1.1.100"]
        }
        # INS2
        ,{
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-0d6df09d036a47c3d"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC1.Z3_SN1_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC1.SG_ID[0]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.1.2.100"]
        }
        # INS3
        ,{
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-035da6a0773842f64"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC1.Z1_SN2_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC1.SG_ID[1]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = true
            PRI_IPV4S = ["10.1.3.100"]
        }
        # INS4
        ,{
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-035da6a0773842f64"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC1.Z3_SN2_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC1.SG_ID[2]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = true
            PRI_IPV4S = ["10.1.4.100"]
        }
    ]
    AWS_REG1_VPC1_INS_DEFAULT_VOL = [
        # INS1-VOL
        {
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS2-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS3-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS4-VOL      
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }                                    
    ]

    AWS_REG1_VPC1_INS_UD = [
        # INS1-UD
        {
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            yum update -y
            sed -i "s/^net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g" /etc/sysctl.conf
            sysctl -p
            yum install -y iptables
            iptables -F
            iptables -X
            iptables -t nat -F
            iptables -t nat -X
            iptables -t mangle -F
            iptables -t mangle -X
            iptables -P INPUT ACCEPT
            iptables -P FORWARD ACCEPT
            iptables -P OUTPUT ACCEPT            
            iptables -t nat -A POSTROUTING -o eth0 -s 10.1.3.0/24 -j MASQUERADE
            iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.1.3.100
            iptables-save | tee /etc/sysconfig/iptables
            EOF
        }
        # INS2-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            yum update -y
            sed -i "s/^net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g" /etc/sysctl.conf
            sysctl -p
            yum install -y iptables
            iptables -t nat -A POSTROUTING -o eth0 -s 10.1.4.0/24 -j MASQUERADE
            iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.1.4.100
            iptables-save | tee /etc/sysconfig/iptables
            EOF
        }
        # INS3-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            hostnamectl --static set-hostname Seoul-AWS-WebSrv1
            yum update -y
            amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
            yum install -y httpd lynx
            mkdir /var/www/inc
            curl -o /var/www/inc/dbinfo.inc https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/dbinfo.inc
            curl -o /var/www/html/db.php https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/db.php
            rm -rf /var/www/html/index.html
            echo "<h1>CloudNet@ FullLab - SeoulRegion - Websrv1</h1>" > /var/www/html/index.html
            systemctl start httpd && systemctl enable httpd
            curl -o /opt/pingcheck.sh https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/pingchecker.sh
            chmod +x /opt/pingcheck.sh
            cat <<-EOT>> /etc/crontab
            */3 * * * * root /opt/pingcheck.sh
            EOT
            echo "1" > /var/www/html/HealthCheck.txt
            EOF
        }            
        # INS4-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            hostnamectl --static set-hostname Seoul-AWS-WebSrv2
            yum update -y
            amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
            yum install -y httpd lynx
            mkdir /var/www/inc
            curl -o /var/www/inc/dbinfo.inc https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/dbinfo.inc
            curl -o /var/www/html/db.php https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/db.php
            rm -rf /var/www/html/index.html
            echo "<h1>CloudNet@ FullLab - SeoulRegion - Websrv2</h1>" > /var/www/html/index.html
            systemctl start httpd && systemctl enable httpd
            curl -o /opt/pingcheck.sh https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/pingchecker.sh
            chmod +x /opt/pingcheck.sh
            cat <<-EOT>> /etc/crontab
            */3 * * * * root /opt/pingcheck.sh
            EOT
            echo "1" > /var/www/html/HealthCheck.txt
            EOF
        }
    ]

########## REG1 VPC2 ##########

    AWS_REG1_VPC2_SG = {
        NAME = ["SEOUL_IDC_VPC_CGW_SG", "SEOUL_IDC_VPC_DB_SG", "SEOUL_IDC_VPC_DNS_SG"]
        RULE = [
            # Rule1
            {
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                    ,{
                        from_port   = 500
                        to_port     = 500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }
                    ,{
                        from_port   = 4500
                        to_port     = 4500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule2
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule3
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
        ]
    }

    AWS_REG1_VPC2_RTB = [
        # RTB1
        {   
            NAME = "VPC2_Z1_SN1_RTB" 
            SN_ID = module.AWS_REG1_VPC2.Z1_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_GW.IGW_ID[1]
                }              
            ]
        }
        # RTB2
        ,{
            NAME = "VPC2_Z1_SN2_RTB"
            SN_ID = module.AWS_REG1_VPC2.Z1_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG1_VPC2_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    vpc_peering_connection_id = module.AWS_REG1_CONNECTION.PEER_ID[0]
                }  
            ]
        }
    ]

########## REG1 VPC2 INS ##########
    AWS_REG1_VPC2_INS_NAME = ["SEOUL_IDC_INS1_CGW", "SEOUL_IDC_INS2_DB", "SEOUL_IDC_INS3_DNS"]
    AWS_REG1_VPC2_INS_INFO = [
        # INS1
        {
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-035da6a0773842f64"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC2.Z1_SN1_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC2.SG_ID[0]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.2.0.100"]
        }
        # INS2
        ,{
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-035da6a0773842f64"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC2.Z1_SN2_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC2.SG_ID[1]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.2.1.100"]
        }
        # INS3
        ,{
            KEY_NAME = module.AWS_REG1_KEY.KEY_PAIR_NAME
            AMI = "ami-035da6a0773842f64"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG1_VPC2.Z1_SN2_ID
            VPC_SG_IDS = [module.AWS_REG1_VPC2.SG_ID[2]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.2.1.200"]
        }
    ]
    AWS_REG1_VPC2_INS_DEFAULT_VOL = [
        # INS1-VOL
        {
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS2-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS3-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
    ]
    AWS_REG1_VPC2_INS_UD = [
        # INS1-UD
        {
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            sed -i "625,627s/make_resolv_conf/# make_resolv_conf/g" /usr/sbin/dhclient-script
            yum update -y
            hostnamectl --static set-hostname Seoul-IDC-CGW
            cat <<-EOT>> /etc/sysctl.conf
            net.ipv4.ip_forward = 1
            net.ipv4.conf.eth0.rp_filter = 0
            net.ipv4.conf.eth0.accept_source_route = 0
            EOT
            sysctl -p
            yum install -y iptables
            iptables -F
            iptables -X
            iptables -t nat -F
            iptables -t nat -X
            iptables -t mangle -F
            iptables -t mangle -X
            iptables -P INPUT ACCEPT
            iptables -P FORWARD ACCEPT
            iptables -P OUTPUT ACCEPT
            iptables -t nat -A POSTROUTING -o eth0 -s 10.2.1.0/24 -j MASQUERADE
            iptables-save | tee /etc/sysconfig/iptables
            yum install -y tcpdump openswan
            cat <<-EOT> /etc/ipsec.d/aws.conf
            conn Tunnel1
                    authby=secret
                    auto=start
                    left=%defaultroute
                    leftid=${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_LEFT_IP}
                    right=${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_RIGHT_IP}
                    type=tunnel
                    ikelifetime=8h
                    keylife=1h
                    phase2alg=aes128-sha1;modp1024
                    ike=aes128-sha1;modp1024
                    keyingtries=%forever
                    keyexchange=ike
                    leftsubnets={${var.AWS.REG1_VPC2["CIDR"]}}
                    rightsubnets={10.0.0.0/8}
                    dpddelay=10
                    dpdtimeout=30
                    dpdaction=restart_by_peer
            EOT
            cat <<-EOT> /etc/ipsec.d/aws.secrets
            ${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_LEFT_IP} ${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_RIGHT_IP}: PSK "${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_PSK}"
            EOT
            systemctl start ipsec
            systemctl enable ipsec
            cat /etc/ipsec.d/aws.conf
            cat /etc/ipsec.d/aws.secrets
            cat <<-EOT> /etc/resolv.conf
            options rotate
            options timeout:1
            search idcseoul.internal awsseoul.internal idcsingapore.internal awssingapore.internal ap-northeast-2.compute.internal
            nameserver 10.2.1.200
            nameserver 10.1.0.2
            nameserver 10.3.0.2
            nameserver 10.4.1.200
            nameserver 169.254.169.253
            EOT
            service network restart
            EOF
        }       
        # INS2-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            sed -i "625,627s/make_resolv_conf/# make_resolv_conf/g" /usr/sbin/dhclient-script
            yum update -y
            hostnamectl --static set-hostname Seoul-IDC-DB
            yum install -y mariadb-server mariadb lynx
            systemctl start mariadb
            systemctl enable mariadb
            echo -e "\n\nqwe123\nqwe123\ny\ny\ny\ny\n" | /usr/bin/mysql_secure_installation
            mysql -uroot -pqwe123 -e "CREATE DATABASE sample; GRANT ALL PRIVILEGES ON *.* TO 'gasida'@'%' IDENTIFIED BY 'qwe123'; GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%' IDENTIFIED BY 'qwe123'; flush privileges;"
            mysql -uroot -pqwe123 -e "USE sample;CREATE TABLE EMPLOYEES (ID int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,NAME VARCHAR(45),ADDRESS VARCHAR(90));"
            systemctl restart mariadb
            cat <<-EOT> /etc/my.cnf
            [mysqld]
            datadir=/var/lib/mysql
            socket=/var/lib/mysql/mysql.sock
            symbolic-links=0
            log-bin=mysql-bin
            server-id=1
            [mysqld_safe]
            log-error=/var/log/mariadb/mariadb.log
            pid-file=/var/run/mariadb/mariadb.pid
            !includedir /etc/my.cnf.d
            EOT
            cat <<-EOT> /home/ec2-user/list.txt
            10.1.3.100
            websrv1.awsseoul.internal
            10.1.4.100
            websrv2.awsseoul.internal
            10.2.1.100
            dbsrv.idcseoul.internal
            10.2.1.200
            dnssrv.idcseoul.internal
            10.3.3.100
            websrv1.awssingapore.internal
            10.4.1.100
            dbsrv.idcsingapore.internal
            10.4.1.200
            dnssrv.idcsingapore.internal
            EOT
            curl -o /home/ec2-user/pingall.sh https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter6/pingall.sh
            chmod +x /home/ec2-user/pingall.sh
            cat <<-EOT> /etc/resolv.conf
            options rotate
            options timeout:1
            search idcseoul.internal awsseoul.internal idcsingapore.internal awssingapore.internal ap-northeast-2.compute.internal
            nameserver 10.2.1.200
            nameserver 10.1.0.2
            nameserver 10.3.0.2
            nameserver 10.4.1.200
            nameserver 169.254.169.253
            EOT
            service network restart            
            EOF
        }
        # INS3-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user                
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            sed -i "625,627s/make_resolv_conf/# make_resolv_conf/g" /usr/sbin/dhclient-script
            yum update -y
            hostnamectl --static set-hostname Seoul-IDC-DNS
            yum install -y bind bind-utils bind-libs
            sed -i "s/listen-on port 53 { 127.0.0.1; };/listen-on port 53 { any; };/" /etc/named.conf
            sed -i "s/allow-query     { localhost; };/allow-query     { any; };/" /etc/named.conf
            cat <<-EOT>> /etc/named.rfc1912.zones
            zone "idcseoul.internal" IN {
                    type master;
                    file "data/idcseoul.internal.zone";
            };

            zone "1.2.10.in-addr.arpa" IN {
                    type master;
                    file "data/dbsrv.10.2.1";
            };
            EOT
            cat <<-EOT> /var/named/data/idcseoul.internal.zone
            \$TTL 3H
            @       IN SOA  dnssrv.idcseoul.internal. root.idcseoul.internal. (
                                                    20230520       ; serial
                                                    1D      ; refresh
                                                    1H      ; retry
                                                    1W      ; expire
                                                    3H )    ; minimum
            @       IN      NS      dnssrv.idcseoul.internal.
                    IN      A       10.2.1.200
            dnssrv  IN      A       10.2.1.200
            dbsrv   IN      A       10.2.1.100
            EOT
            cat <<-EOT> /var/named/data/dbsrv.10.2.1
            \$TTL 3H
            @       IN SOA  dnssrv.idcseoul.internal. root.idcseoul.internal. (
                                                    20230520       ; serial
                                                    1D      ; refresh
                                                    1H      ; retry
                                                    1W      ; expire
                                                    3H )    ; minimum
            @       IN      NS      dnssrv.idcseoul.internal.
            200     IN      PTR     dnssrv.idcseoul.internal.
            100     IN      PTR     dbsrv.idcseoul.internal.
            EOT
            chown root:named /var/named/data/idcseoul.internal.zone
            chown root:named /var/named/data/dbsrv.10.2.1
            systemctl start named
            systemctl enable named
            cat <<-EOT> /etc/resolv.conf
            options rotate
            options timeout:1
            search idcseoul.internal awsseoul.internal idcsingapore.internal awssingapore.internal ap-northeast-2.compute.internal
            nameserver 10.2.1.200
            nameserver 10.1.0.2
            nameserver 10.3.0.2
            nameserver 10.4.1.200
            nameserver 169.254.169.253
            EOT
            service network restart            
            EOF
        }
    ]

########## REG1 SERVICE ##########

    AWS_REG1_IGW = [
        {
            NAME = "SEOUL_VPC_IGW"
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID
        }
        ,{
            NAME = "SEOUL_IDC_IGW"
            VPC_ID = module.AWS_REG1_VPC2.VPC_ID
        }
    ]

    AWS_REG1_VGW = [
        {
            NAME = null
            AWS_ASN = null
            VPC_ID = null
            ZONE = null
        }
    ]

    AWS_REG1_CGW = [
        {
            NAME = "SEOUL_IDC_CGW"
            BGP_ASN = 65010
            IP = "${module.AWS_REG1_ADD.DEFAULT_EIP_IP[2]}"
            TYPE = "ipsec.1"
        }
    ]

    AWS_REG1_TGW = [
        {
            NAME = "SEOUL_TGW"
            AWS_ASN = 65000
            DNS_SUP = "enable"
            VPN_ECMP_SUP = "enable"
            MULTICAST_SUP = "enable"
            AUTO_CROSS_ACC_ATT = "disable"
            CIDRS = ["0.0.0.0/0"]
        }
    ]

    AWS_REG1_TGW_CON_VPC = [
        {
            NAME = "SEOUL_TGW_VPC1"
            TGW_ID = module.AWS_REG1_GW.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG1_GW.TGW_RTB_ID[0]
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID
            SN_IDS = [module.AWS_REG1_VPC1.Z1_SN1_ID]
        }
    ]

    AWS_REG1_TGW_CON_CGW_TUNNEL1_LEFT_IP = "${module.AWS_REG1_ADD.DEFAULT_EIP_IP[2]}"
    AWS_REG1_TGW_CON_CGW_TUNNEL1_RIGHT_IP = "${module.AWS_REG1_CONNECTION.TGW_CON_CGW_TUNNEL1_OUT_IP[0]}"
    AWS_REG1_TGW_CON_CGW_TUNNEL1_PSK = "cloudneta"
    
    AWS_REG1_TGW_CON_CGW = [
        {
            NAME = "SEOUL_TGW_CON_IDC"
            TGW_ID = module.AWS_REG1_GW.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG1_GW.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.2.0.0/16"
            CGW_ID = module.AWS_REG1_GW.CGW_ID[0]
            TYPE = "ipsec.1"
            STATIC_ROUTE = true
            TUNNEL1_PSK = "${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_PSK}"
            TUNNEL2_PSK = null
        }
    ]

    AWS_REG1_TGW_PEER_REQUEST = [
        {
            NAME = "PEER_TO_SINGAPORE_TGW"
            TGW_ID = module.AWS_REG1_GW.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG1_GW.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.3.0.0/16"
            PEER_OWNER_ID = module.AWS_REG2_KEY.OWNER_ID
            PEER_REG_NAME = module.AWS_REG2_KEY.REGION_NAME
            PEER_TGW_ID = module.AWS_REG2_GW.TGW_ID[0]
            PEER_VPC_ID = module.AWS_REG2_VPC1.VPC_ID
        }
    ]

    AWS_REG1_TGW_PEER_ACCEPT = [
        # {
        #     NAME = ""
        #     TGW_ATT_ID = module
        #     TGW_RTB_ID = module
        #     DESTINATION_CIDR = ""            
        # }
    ]        

    AWS_REG1_TGW_CON_DX = [
        # {
        #     NAME = "TGW_DX"
        #     TGW_ATT_ID = module.AWS_REG1_CONNECTION.TGW_ATT_ID[0]
        #     TARGET_TGW_ID = ""
        # }
    ]

    AWS_REG1_TGW_PEER_REQUEST_ADD_ROUTE = [
        {
            DESTINATION_CIDR    = "10.4.0.0/16"
            TGW_ATT_ID          = module.AWS_REG1_CONNECTION.TGW_PEER_ATT_ID[0]
            TGW_RTB_ID          = module.AWS_REG1_GW.TGW_RTB_ID[0]
            BLACKHOLE           = false 
        }
    ]

    AWS_REG1_PEER_REQUEST = [
        {
            NAME = "PEER_TO_SINGAPORE_IDC"
            VPC_ID = module.AWS_REG1_VPC2.VPC_ID
            PEER_OWNER_ID = module.AWS_REG2_KEY.OWNER_ID
            PEER_VPC_ID = module.AWS_REG2_VPC2.VPC_ID
            PEER_REGION_NAME = module.AWS_REG2_KEY.REGION_NAME
            AUTO_ACCEPT = true
        }
    ]

    AWS_REG1_PEER_ACCEPT = [
        # {
        #     NAME = ""
        #     PEER_ID = ""
        #     AUTO_ACCEPT = true
        # }
    ]

    AWS_REG1_VPC1_ZONE = [
        # REG1
        {  
            NAME = "SEOUL_AWS"
            REGION_ID = module.AWS_REG1_VPC1.REGION_NAME
            VPC_ID = module.AWS_REG1_VPC1.VPC_ID                
            DOMAIN_NAME = "awsseoul.internal"
            TYPE_PRIVATE = true
        }
    ]

    AWS_REG1_ZONE_RECORD = [
        {
            ZONE_ID = module.AWS_REG1_SERVICE.ZONE_ID[0]
            NAME = "websrv1.awsseoul.internal"               
            TYPE = "A"
            TTL = 300
            IPS = ["10.1.3.100"]
        }
        ,{
            ZONE_ID = module.AWS_REG1_SERVICE.ZONE_ID[0]
            NAME = "websrv2.awsseoul.internal"               
            TYPE = "A"
            TTL = 300
            IPS = ["10.1.4.100"]
        }

    ]

    AWS_REG1_VPC1_RESOLV_EP= [
        {  
            NAME        = "AWS_SEOUL_EP_IN"
            DIRECTION   = "INBOUND"
            SG_IDS      = [module.AWS_REG1_VPC1.SG_ID[0]]
            IPS = [
                {
                    SN_ID = module.AWS_REG1_VPC1.Z1_SN2_ID 
                    IP = "10.1.3.150"
                }
                ,{
                    SN_ID = module.AWS_REG1_VPC1.Z3_SN2_ID
                    IP = "10.1.4.150"
                }
            ]
        }
        ,{  
            NAME        = "AWS_SEOUL_EP_OUT"
            DIRECTION   = "OUTBOUND" 
            SG_IDS      = [module.AWS_REG1_VPC1.SG_ID[0]]
            IPS = [
                {
                    SN_ID = module.AWS_REG1_VPC1.Z1_SN1_ID
                    IP = "10.1.1.150"
                }
                ,{
                    SN_ID = module.AWS_REG1_VPC1.Z3_SN1_ID
                    IP = "10.1.2.150"
                }
            ]
        }            
    ]

    AWS_REG1_VPC1_RESOLV_EP_RULE= [
        {  
            NAME            = "EP_OUT_IDCSEOUL"
            EP_ID           = module.AWS_REG1_SERVICE.EP_ID[1]
            DOMAIN_NAME     = "idcseoul.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG1_VPC1.VPC_ID
            IPS = [
                {
                    IP = "10.2.1.200"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_AWSSINGAPORE"
            EP_ID           = module.AWS_REG1_SERVICE.EP_ID[1]
            DOMAIN_NAME     = "awssingapore.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG1_VPC1.VPC_ID
            IPS = [
                {
                    IP = "10.3.0.2"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_IDCSINGAPORE"
            EP_ID           = module.AWS_REG1_SERVICE.EP_ID[1]
            DOMAIN_NAME     = "idcsingapore.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG1_VPC1.VPC_ID
            IPS = [
                {
                    IP = "10.4.1.200"
                }
            ]
        }        
    ]

    AWS_REG1_VPC1_RT53_HC= [
        { 
            NAME                = "websrv1_health"
            DOMAIN              = "websrv1.awsseoul.internal"
            PROTOCOL            = "HTTP"
            PORT                = 80
            RESOURCE_PATH       = "/var/www/html/db.php"
            FAIL_THRESHOLD      = "5"
            REQ_INTERVAL        = "30"
        }
        ,{
            NAME                = "websrv2_health"
            DOMAIN              = "websrv2.awsseoul.internal"
            PROTOCOL            = "HTTP"
            PORT                = 80
            RESOURCE_PATH       = "/var/www/html/db.php"
            FAIL_THRESHOLD      = "5"
            REQ_INTERVAL        = "30"
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
            TARGET_ID = module.AWS_REG1_VPC1_INS.EC2_ID[2]
            PORT = 80
        }
        ,{
            TG_ID = module.AWS_REG1_SERVICE.LB_TG_ID[0]
            TARGET_ID = module.AWS_REG1_VPC1_INS.EC2_ID[3]
            PORT = 80
        }
    ]

    AWS_REG1_LB = [
        {
        
            NAME = "SEOUL-LB"
            TYPE = "application" # "application", "network"
            INTERNAL = false
            SNS = [module.AWS_REG1_VPC1.Z1_SN1_ID, module.AWS_REG1_VPC1.Z3_SN1_ID]
            DELETE_PROTECTION = false
            SGS = [module.AWS_REG1_VPC1.SG_ID[3]] # "application"
            # SNS_MAP = [
            #     {
            #         SN_ID     = ""
            #         EIP_ID    = ""
            #     }
            # ]

        }
    ]

    AWS_REG1_LB_LS = [    
        {
            NAME = "SEOUL_LB_LS"
            PRIORITY     = 100
            PORT    = 80
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

########## REG2 ##########

    AWS_REG2_DEFAULT_EIP_NAME = ["SINGAPORE_VPC1_INS1_NAT1_EIP", "SINGAPORE_VPC2_INS1_CGW_EIP"]
    AWS_REG2_DEFAULT_EIP_INS_ID = [module.AWS_REG2_VPC1_INS.EC2_ID[0], module.AWS_REG2_VPC2_INS.EC2_ID[0]]

    AWS_REG2_ADD_EIP_NAME = []
    AWS_REG2_ADD_NIC_NAME = []
    AWS_REG2_ADD_NIC_INS_ID = []
    AWS_REG2_ADD_NIC_INFO = []
    AWS_REG2_ADD_VOL_NAME = []
    AWS_REG2_ADD_VOL_INS_ID = []
    AWS_REG2_ADD_VOL_INFO = []

########## REG2 VPC1 ##########

    AWS_REG2_VPC1_SG = {
        NAME = ["SINGAPORE_VPC_NAT_SG", "SINGAPORE_VPC_WEB1_SG"]   
        RULE = [
            # Rule1
            {
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                    ,{
                        from_port   = 500
                        to_port     = 500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }
                    ,{
                        from_port   = 4500
                        to_port     = 4500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }                         
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule2
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
        ]
    }

    AWS_REG2_VPC1_RTB = [
        # RTB1
        {   
            NAME = "VPC1_Z1_SN1_RTB" 
            SN_ID = module.AWS_REG2_VPC1.Z1_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG2_GW.IGW_ID[0]
                }
                ,{
                    cidr_block = "10.4.0.0/16"
                    transit_gateway_id = module.AWS_REG2_GW.TGW_ID[0]
                }
                ,{
                    cidr_block = "10.1.0.0/16"
                    transit_gateway_id = module.AWS_REG2_GW.TGW_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    transit_gateway_id = module.AWS_REG2_GW.TGW_ID[0]
                }                                   
            ]
        }
        # RTB2
        ,{
            NAME = "VPC1_Z1_SN2_RTB"
            SN_ID = module.AWS_REG2_VPC1.Z1_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG2_VPC1_INS.DEFAULT_NIC_ID[0]
                }    
            ]
        }
    ]

########## REG2 VPC1 INS ##########
    AWS_REG2_VPC1_INS_NAME = ["SINGAPORE_INS1_NAT1", "SINGAPORE_INS3_WEB1"]
    AWS_REG2_VPC1_INS_INFO = [
        # INS1
        {
            KEY_NAME = module.AWS_REG2_KEY.KEY_PAIR_NAME
            AMI = "ami-036fb5fe12bc53979"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG2_VPC1.Z1_SN1_ID
            VPC_SG_IDS = [module.AWS_REG2_VPC1.SG_ID[0]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.3.1.100"]
        }
        # INS2
        ,{
            KEY_NAME = module.AWS_REG2_KEY.KEY_PAIR_NAME
            AMI = "ami-06ebb7936bfa62864"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG2_VPC1.Z1_SN2_ID
            VPC_SG_IDS = [module.AWS_REG2_VPC1.SG_ID[1]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = true
            PRI_IPV4S = ["10.3.3.100"]
        }
    ]
    AWS_REG2_VPC1_INS_DEFAULT_VOL = [
        # INS1-VOL
        {
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS2-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }                              
    ]

    AWS_REG2_VPC1_INS_UD = [
        # INS1-UD
        {
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            yum update -y
            sed -i "s/^net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g" /etc/sysctl.conf
            sysctl -p
            yum install -y iptables
            iptables -F
            iptables -X
            iptables -t nat -F
            iptables -t nat -X
            iptables -t mangle -F
            iptables -t mangle -X
            iptables -P INPUT ACCEPT
            iptables -P FORWARD ACCEPT
            iptables -P OUTPUT ACCEPT            
            iptables -t nat -A POSTROUTING -o eth0 -s 10.3.3.0/24 -j MASQUERADE
            iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.3.3.100           
            iptables-save | tee /etc/sysconfig/iptables
            EOF
        }
        # INS2-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            hostnamectl --static set-hostname Singapore-AWS-WebSrv1
            yum update -y
            amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
            yum install -y httpd lynx
            mkdir /var/www/inc
            curl -o /var/www/inc/dbinfo.inc https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/dbinfo.inc
            curl -o /var/www/html/db.php https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/db2.php
            rm -rf /var/www/html/index.html
            echo "<h1>CloudNet@ FullLab - SingaporeRegion - Websrv1</h1>" > /var/www/html/index.html
            systemctl start httpd && systemctl enable httpd
            curl -o /opt/pingcheck.sh https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/pingchecker2.sh
            chmod +x /opt/pingcheck.sh
            cat <<-EOT>> /etc/crontab
            */3 * * * * root /opt/pingcheck.sh
            EOT
            echo "1" > /var/www/html/HealthCheck.txt
            EOF
        }
    ]

########## REG2 VPC2 ##########

    AWS_REG2_VPC2_SG = {
        NAME = ["SINGAPORE_IDC_VPC_CGW_SG", "SINGAPORE_IDC_VPC_DB_SG", "SINGAPORE_IDC_VPC_DNS_SG"]
        RULE = [
            # Rule1
            {
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                    ,{
                        from_port   = 500
                        to_port     = 500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }
                    ,{
                        from_port   = 4500
                        to_port     = 4500
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "VPN"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule2
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 3306
                        to_port     = 3306
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DB"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
            # Rule3
            ,{
                INGRESS = [
                    {
                        from_port   = -1
                        to_port     = -1
                        protocol    = "icmp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "Ping"
                    }                        
                    ,{
                        from_port   = 22
                        to_port     = 22
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "SSH access"
                    }
                    ,{
                        from_port   = 80
                        to_port     = 80
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 443
                        to_port     = 443
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "HTTP"
                    }
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }                        
                    ,{
                        from_port   = 53
                        to_port     = 53
                        protocol    = "udp"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "DNS"
                    }
                ]
                EGRESS = [
                    {
                        from_port   = 0
                        to_port     = 0
                        protocol    = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
                        description = "All traffic"
                    }
                ]
            }
        ]
    }

    AWS_REG2_VPC2_RTB = [
        # RTB1
        {   
            NAME = "VPC2_Z1_SN1_RTB" 
            SN_ID = module.AWS_REG2_VPC2.Z1_SN1_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG2_GW.IGW_ID[1]
                }
            ]
        }
        # RTB2
        ,{
            NAME = "VPC2_Z1_SN2_RTB"
            SN_ID = module.AWS_REG2_VPC2.Z1_SN2_ID
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG2_VPC2_INS.DEFAULT_NIC_ID[0]
                }
                ,{
                    cidr_block = "10.2.0.0/16"
                    vpc_peering_connection_id = module.AWS_REG1_CONNECTION.PEER_ID[0]
                }                
            ]
        }
    ]

########## REG2 VPC2 INS ##########
    AWS_REG2_VPC2_INS_NAME = ["SINGAPORE_IDC_INS1_CGW", "SINGAPORE_IDC_INS2_DB", "SINGAPORE_IDC_INS3_DNS"]
    AWS_REG2_VPC2_INS_INFO = [
        # INS1
        {
            KEY_NAME = module.AWS_REG2_KEY.KEY_PAIR_NAME
            AMI = "ami-06ebb7936bfa62864"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG2_VPC2.Z1_SN1_ID
            VPC_SG_IDS = [module.AWS_REG2_VPC2.SG_ID[0]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.4.0.100"]
        }
        # INS2
        ,{
            KEY_NAME = module.AWS_REG2_KEY.KEY_PAIR_NAME
            AMI = "ami-06ebb7936bfa62864"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG2_VPC2.Z1_SN2_ID
            VPC_SG_IDS = [module.AWS_REG2_VPC2.SG_ID[1]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.4.1.100"]
        }
        # INS3
        ,{
            KEY_NAME = module.AWS_REG2_KEY.KEY_PAIR_NAME
            AMI = "ami-06ebb7936bfa62864"
            INS_TYPE = "t2.micro"
            SN_ID = module.AWS_REG2_VPC2.Z1_SN2_ID
            VPC_SG_IDS = [module.AWS_REG2_VPC2.SG_ID[2]]
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            PRI_IPV4S = ["10.4.1.200"]
        }
    ]
    AWS_REG2_VPC2_INS_DEFAULT_VOL = [
        # INS1-VOL
        {
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS2-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        # INS3-VOL
        ,{
            VOL_NAME = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
    ]
    AWS_REG2_VPC2_INS_UD = [
        # INS1-UD
        {
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            sed -i "625,627s/make_resolv_conf/# make_resolv_conf/g" /usr/sbin/dhclient-script
            yum update -y
            hostnamectl --static set-hostname Singapore-IDC-CGW
            cat <<-EOT>> /etc/sysctl.conf
            net.ipv4.ip_forward = 1
            net.ipv4.conf.eth0.rp_filter = 0
            net.ipv4.conf.eth0.accept_source_route = 0
            EOT
            sysctl -p
            yum install -y iptables
            iptables -F
            iptables -X
            iptables -t nat -F
            iptables -t nat -X
            iptables -t mangle -F
            iptables -t mangle -X
            iptables -P INPUT ACCEPT
            iptables -P FORWARD ACCEPT
            iptables -P OUTPUT ACCEPT
            iptables -t nat -A POSTROUTING -o eth0 -s 10.4.1.0/24 -j MASQUERADE
            iptables-save | tee /etc/sysconfig/iptables
            yum install -y tcpdump openswan
            cat <<-EOT> /etc/ipsec.d/aws.conf
            conn Tunnel1
                    authby=secret
                    auto=start
                    left=%defaultroute
                    leftid=${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_LEFT_IP}
                    right=${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_RIGHT_IP}
                    type=tunnel
                    ikelifetime=8h
                    keylife=1h
                    phase2alg=aes128-sha1;modp1024
                    ike=aes128-sha1;modp1024
                    keyingtries=%forever
                    keyexchange=ike
                    leftsubnets={${var.AWS.REG2_VPC2["CIDR"]}}
                    rightsubnets={10.0.0.0/8}
                    dpddelay=10
                    dpdtimeout=30
                    dpdaction=restart_by_peer
            EOT
            cat <<-EOT> /etc/ipsec.d/aws.secrets
            ${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_LEFT_IP} ${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_RIGHT_IP}: PSK "${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_PSK}"
            EOT
            systemctl start ipsec
            systemctl enable ipsec
            cat /etc/ipsec.d/aws.conf
            cat /etc/ipsec.d/aws.secrets
            cat <<-EOT> /etc/resolv.conf
            options rotate
            options timeout:1
            search idcsingapore.internal awssingapore.internal idcseoul.internal awsseoul.internal ap-northeast-2.compute.internal
            nameserver 10.4.1.200
            nameserver 10.1.0.2
            nameserver 10.3.0.2
            nameserver 10.2.1.200
            nameserver 169.254.169.253
            EOT
            service network restart
            EOF
        }       
        # INS2-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            sed -i "625,627s/make_resolv_conf/# make_resolv_conf/g" /usr/sbin/dhclient-script
            yum update -y
            hostnamectl --static set-hostname Singapore-IDC-DB
            yum install -y mariadb-server mariadb lynx
            systemctl start mariadb
            systemctl enable mariadb
            echo -e "\n\nqwe123\nqwe123\ny\ny\ny\ny\n" | /usr/bin/mysql_secure_installation
            mysql -uroot -pqwe123 -e "CREATE DATABASE sample; GRANT ALL PRIVILEGES ON *.* TO 'gasida'@'%' IDENTIFIED BY 'qwe123'; GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%' IDENTIFIED BY 'qwe123'; flush privileges;"
            mysql -uroot -pqwe123 -e "USE sample;CREATE TABLE EMPLOYEES (ID int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,NAME VARCHAR(45),ADDRESS VARCHAR(90));"
            systemctl restart mariadb
            cat <<-EOT> /etc/my.cnf
            [mysqld]
            datadir=/var/lib/mysql
            socket=/var/lib/mysql/mysql.sock
            symbolic-links=0
            log-bin=mysql-bin
            server-id=2
            read_only=1
            replicate-do-db='sample'
            [mysqld_safe]
            log-error=/var/log/mariadb/mariadb.log
            pid-file=/var/run/mariadb/mariadb.pid
            !includedir /etc/my.cnf.d
            EOT
            cat <<-EOT> /home/ec2-user/list.txt
            10.1.3.100
            websrv1.awsseoul.internal
            10.1.4.100
            websrv2.awsseoul.internal
            10.2.1.100
            dbsrv.idcseoul.internal
            10.2.1.200
            dnssrv.idcseoul.internal
            10.3.3.100
            websrv1.awssingapore.internal
            10.4.1.100
            dbsrv.idcsingapore.internal
            10.4.1.200
            dnssrv.idcsingapore.internal
            EOT
            curl -o /home/ec2-user/pingall.sh https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter6/pingall.sh
            chmod +x /home/ec2-user/pingall.sh
            cat <<-EOT> /etc/resolv.conf
            options rotate
            options timeout:1
            search idcsingapore.internal awssingapore.internal idcseoul.internal awsseoul.internal ap-northeast-2.compute.internal
            nameserver 10.4.1.200
            nameserver 10.1.0.2
            nameserver 10.3.0.2
            nameserver 10.2.1.200
            nameserver 169.254.169.253
            EOT
            service network restart    
            EOF
        }
        # INS3-UD
        ,{
            SCRIPT = <<-EOF
            #!/bin/bash
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin root
            (
            echo "qwe123"
            echo "qwe123"
            ) | passwd --stdin ec2-user                
            sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
            sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i "s/^PermitRootLogin forced-commands-only/PermitRootLogin yes/g" /etc/ssh/sshd_config
            sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ec2-user\\" rather than the user \\"root\\".'\'';echo;sleep 10" //' ~/.ssh/authorized_keys
            service sshd restart
            sed -i "625,627s/make_resolv_conf/# make_resolv_conf/g" /usr/sbin/dhclient-script
            yum update -y
            hostnamectl --static set-hostname Singapore-IDC-DNS
            yum install -y bind bind-utils bind-libs
            sed -i "s/listen-on port 53 { 127.0.0.1; };/listen-on port 53 { any; };/" /etc/named.conf
            sed -i "s/allow-query     { localhost; };/allow-query     { any; };/" /etc/named.conf
            cat <<-EOT>> /etc/named.rfc1912.zones
            zone "idcsingapore.internal" IN {
                    type master;
                    file "data/idcsingapore.internal.zone";
            };

            zone "1.4.10.in-addr.arpa" IN {
                    type master;
                    file "data/dbsrv.10.4.1";
            };
            EOT
            cat <<-EOT> /var/named/data/idcsingapore.internal.zone
            \$TTL 3H
            @       IN SOA  dnssrv.idcsingapore.internal. root.idcsingapore.internal. (
                                                    20230520       ; serial
                                                    1D      ; refresh
                                                    1H      ; retry
                                                    1W      ; expire
                                                    3H )    ; minimum
            @       IN      NS      dnssrv.idcsingapore.internal.
                    IN      A       10.4.1.200
            dnssrv  IN      A       10.4.1.200
            dbsrv   IN      A       10.4.1.100
            EOT
            cat <<-EOT> /var/named/data/dbsrv.10.4.1
            \$TTL 3H
            @       IN SOA  dnssrv.idcsingapore.internal. root.idcsingapore.internal. (
                                                    20230520       ; serial
                                                    1D      ; refresh
                                                    1H      ; retry
                                                    1W      ; expire
                                                    3H )    ; minimum
            @       IN      NS      dnssrv.idcsingapore.internal.
            200     IN      PTR     dnssrv.idcsingapore.internal.
            100     IN      PTR     dbsrv.idcsingapore.internal.
            EOT
            chown root:named /var/named/data/idcsingapore.internal.zone
            chown root:named /var/named/data/dbsrv.10.4.1
            systemctl start named
            systemctl enable named
            cat <<-EOT> /etc/resolv.conf
            options rotate
            options timeout:1
            search idcsingapore.internal awssingapore.internal idcseoul.internal awsseoul.internal ap-northeast-2.compute.internal
            nameserver 10.4.1.200
            nameserver 10.1.0.2
            nameserver 10.3.0.2
            nameserver 10.2.1.200
            nameserver 169.254.169.253
            EOT
            service network restart
            EOF
        }
    ]

########## REG2 SERVICE ##########

    AWS_REG2_IGW = [
        {
            NAME = "SINGAPORE_VPC_IGW"
            VPC_ID = module.AWS_REG2_VPC1.VPC_ID
        }
        ,{
            NAME = "SINGAPORE_IDC_IGW"
            VPC_ID = module.AWS_REG2_VPC2.VPC_ID
        }
    ]

    AWS_REG2_VGW = [
        {
            NAME = null
            AWS_ASN = null
            VPC_ID = null
            ZONE = null
        }
    ]

    AWS_REG2_CGW = [
        {
            NAME = "SINGAPORE_IDC_CGW"
            BGP_ASN = 65110
            IP = "${module.AWS_REG2_ADD.DEFAULT_EIP_IP[1]}"
            TYPE = "ipsec.1"
        }
    ]

    AWS_REG2_TGW = [
        {
            NAME = "SINGAPORE_TGW"
            AWS_ASN = 65100
            DNS_SUP = "enable"
            VPN_ECMP_SUP = "enable"
            MULTICAST_SUP = "enable"
            AUTO_CROSS_ACC_ATT = "disable"
            CIDRS = ["0.0.0.0/0"]
        }
    ]

    AWS_REG2_TGW_CON_VPC = [
        {
            NAME = "SINGAPORE_TGW_VPC1"
            TGW_ID = module.AWS_REG2_GW.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG2_GW.TGW_RTB_ID[0]
            VPC_ID = module.AWS_REG2_VPC1.VPC_ID
            SN_IDS = [module.AWS_REG2_VPC1.Z1_SN1_ID]
        }
    ]

    AWS_REG2_TGW_CON_CGW_TUNNEL1_LEFT_IP = "${module.AWS_REG2_ADD.DEFAULT_EIP_IP[1]}"
    AWS_REG2_TGW_CON_CGW_TUNNEL1_RIGHT_IP = "${module.AWS_REG2_CONNECTION.TGW_CON_CGW_TUNNEL1_OUT_IP[0]}"
    AWS_REG2_TGW_CON_CGW_TUNNEL1_PSK = "cloudneta"
    
    AWS_REG2_TGW_CON_CGW = [
        {
            NAME = "SINGAPORE_TGW_CON_IDC"
            TGW_ID = module.AWS_REG2_GW.TGW_ID[0]
            TGW_RTB_ID = module.AWS_REG2_GW.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.4.0.0/16"
            CGW_ID = module.AWS_REG2_GW.CGW_ID[0]
            TYPE = "ipsec.1"
            STATIC_ROUTE = true
            TUNNEL1_PSK = "${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_PSK}"
            TUNNEL2_PSK = null
        }
    ]

    AWS_REG2_TGW_PEER_REQUEST = [
        # {
        #     NAME = ""
        #     TGW_ID = module
        #     TGW_RTB_ID = module
        #     DESTINATION_CIDR = ""
        #     PEER_OWNER_ID = module
        #     PEER_REG_NAME = module
        #     PEER_TGW_ID = module
        #     PEER_VPC_ID = module
        # }
    ]

    AWS_REG2_TGW_PEER_ACCEPT = [
        {
            NAME = "PEER_FROM_SEOUL_TGW1"
            TGW_ATT_ID = module.AWS_REG1_CONNECTION.TGW_PEER_ATT_ID[0]
            TGW_RTB_ID = module.AWS_REG2_GW.TGW_RTB_ID[0]
            DESTINATION_CIDR = "10.1.0.0/16"
        }
    ]

    AWS_REG2_TGW_CON_DX = [
        # {
        #     NAME = "TGW_DX"
        #     TGW_ATT_ID = module.AWS_REG2_CONNECTION.TGW_ATT_ID[0]
        #     TARGET_TGW_ID = ""
        # }
    ]

    AWS_REG2_TGW_PEER_ACCEPT_ADD_ROUTE = [
        {
            DESTINATION_CIDR    = "10.2.0.0/16"
            TGW_ATT_ID          = module.AWS_REG1_CONNECTION.TGW_PEER_ATT_ID[0]
            TGW_RTB_ID          = module.AWS_REG2_GW.TGW_RTB_ID[0]
            BLACKHOLE           = false 
        }
    ]

    AWS_REG2_PEER_REQUEST = [
        # {
        #     NAME = ""
        #     VPC_ID = ""
        #     PEER_OWNER_ID = ""
        #     PEER_VPC_ID = ""
        #     PEER_REGION = ""
        #     AUTO_ACCEPT = true
        # }
    ]

    AWS_REG2_PEER_ACCEPT = [
        {
            NAME = "PEER_FROM_SEOUL_IDC"
            PEER_ID = module.AWS_REG1_CONNECTION.PEER_ID[0]
            AUTO_ACCEPT = true
        }
    ]

    AWS_REG2_VPC1_ZONE = [
        # REG2
        {  
            NAME = "SINGAPORE_AWS"
            REGION_ID = module.AWS_REG2_VPC1.REGION_NAME
            VPC_ID = module.AWS_REG2_VPC1.VPC_ID                
            DOMAIN_NAME = "awssingapore.internal"
            TYPE_PRIVATE = true
        }
    ]

    AWS_REG2_ZONE_RECORD = [
        {
            ZONE_ID = module.AWS_REG2_SERVICE.ZONE_ID[0]
            NAME = "websrv1.awssingapore.internal"               
            TYPE = "A"
            TTL = 300
            IPS = ["10.3.3.100"]
        }
    ]

    AWS_REG2_VPC1_RESOLV_EP= [
        {  
            NAME        = "AWS_SINGAPORE_EP_IN"
            DIRECTION   = "INBOUND"
            SG_IDS      = [module.AWS_REG2_VPC1.SG_ID[0]]
            IPS = [
                {
                    SN_ID = module.AWS_REG2_VPC1.Z1_SN2_ID 
                    IP = "10.3.3.150"
                }
                ,{
                    SN_ID = module.AWS_REG2_VPC1.Z3_SN2_ID
                    IP = "10.3.4.150"
                }
            ]
        }
        ,{  
            NAME        = "AWS_SINGAPORE_EP_OUT"
            DIRECTION   = "OUTBOUND" 
            SG_IDS      = [module.AWS_REG2_VPC1.SG_ID[0]]
            IPS = [
                {
                    SN_ID = module.AWS_REG2_VPC1.Z1_SN1_ID
                    IP = "10.3.1.150"
                }
                ,{
                    SN_ID = module.AWS_REG2_VPC1.Z1_SN1_ID
                    IP = "10.3.1.160"
                }
            ]
        }            
    ]

    AWS_REG2_VPC1_RESOLV_EP_RULE= [
        {  
            NAME            = "EP_OUT_IDCSINGAPORE"
            EP_ID           = module.AWS_REG2_SERVICE.EP_ID[1]
            DOMAIN_NAME     = "idcsingapore.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG2_VPC1.VPC_ID
            IPS = [
                {
                    IP = "10.4.1.200"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_AWSSEOUL"
            EP_ID           = module.AWS_REG2_SERVICE.EP_ID[1]
            DOMAIN_NAME     = "awsseoul.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG2_VPC1.VPC_ID
            IPS = [
                {
                    IP = "10.1.0.2"
                }
            ]
        }
        ,{  
            NAME            = "EP_OUT_IDCSEOUL"
            EP_ID           = module.AWS_REG2_SERVICE.EP_ID[1]
            DOMAIN_NAME     = "idcseoul.internal"
            RULE_TYPE       = "FORWARD"
            VPC_ID          = module.AWS_REG2_VPC1.VPC_ID
            IPS = [
                {
                    IP = "10.2.1.200"
                }
            ]
        }
    ]

    AWS_REG2_VPC1_RT53_HC= [
        {
            NAME                = "websrv1_health"
            DOMAIN              = "websrv1.awssingapore.internal"
            PROTOCOL            = "HTTP"
            PORT                = 80
            RESOURCE_PATH       = "/index.html"
            FAIL_THRESHOLD      = "5"
            REQ_INTERVAL        = "30"
        }
    ]

    AWS_GAC = [
        {
            NAME = "SEOUL-SINGAPORE-GAC"
            IP_TYPE = "IPV4"
            # IPS = ""
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
                    ID = module.AWS_REG2_VPC1_INS.EC2_ID[0]
                    WEIGHT = 100
                }
            ]
        }
    ]    


    # AWS_PEER
}
