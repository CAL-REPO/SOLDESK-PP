# REG1
locals {
    AWS_REG1_VPC1_INSs = [
        {
            NAME = "SEOUL_INS1_NAT1"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-0d6df09d036a47c3d"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG1_VPC1.Za_SN1_ID
            SG_IDs = [module.AWS_REG1_VPC1.SG_ID[0]]
            PRI_IPV4s = ["10.1.1.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SEOUL_INS2_WEB1"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-035da6a0773842f64"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = true            
            SN_ID = module.AWS_REG1_VPC1.Za_SN2_ID
            SG_IDs = [module.AWS_REG1_VPC1.SG_ID[2]]
            PRI_IPV4s = ["10.1.3.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SEOUL_INS3_NAT2"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-0d6df09d036a47c3d"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG1_VPC1.Zc_SN1_ID
            SG_IDs = [module.AWS_REG1_VPC1.SG_ID[1]]
            PRI_IPV4s = ["10.1.2.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }        
        ,{
            NAME = "SEOUL_INS4_WEB2"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-035da6a0773842f64"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = true            
            SN_ID = module.AWS_REG1_VPC1.Zc_SN2_ID
            SG_IDs = [module.AWS_REG1_VPC1.SG_ID[2]]
            PRI_IPV4s = ["10.1.4.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
    ]

    AWS_REG1_VPC1_INS_UDs = [
        {
            USER_DATA = <<-EOF
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
        ,{
            USER_DATA = <<-EOF
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
        ,{
            USER_DATA = <<-EOF
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
            iptables -t nat -A POSTROUTING -o eth0 -s 10.1.4.0/24 -j MASQUERADE
            iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.1.4.100
            iptables-save | tee /etc/sysconfig/iptables
            EOF
        }                   
        ,{
            USER_DATA = <<-EOF
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

    AWS_REG1_VPC2_INSs = [
        {
            NAME = "SEOUL_IDC_INS1_CGW"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-035da6a0773842f64"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG1_VPC2.Za_SN1_ID
            SG_IDs = [module.AWS_REG1_VPC2.SG_ID[0]]
            PRI_IPV4s = ["10.2.0.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SEOUL_IDC_INS2_DB"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-035da6a0773842f64"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false            
            SN_ID = module.AWS_REG1_VPC2.Za_SN2_ID
            SG_IDs = [module.AWS_REG1_VPC2.SG_ID[1]]
            PRI_IPV4s = ["10.2.1.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SEOUL_IDC_INS3_DNS"
            KEY_NAME = module.AWS_REG1_KEY.KEY_NAME[0]
            AMI = "ami-035da6a0773842f64"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG1_VPC2.Za_SN2_ID
            SG_IDs = [module.AWS_REG1_VPC2.SG_ID[2]]
            PRI_IPV4s = ["10.2.1.200"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }        
    ]

    AWS_REG1_VPC2_INS_UDs = [
        {
            USER_DATA = <<-EOF
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
                    leftsubnets={${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_LEFT_SN}}
                    rightsubnets={${local.AWS_REG1_TGW_CON_CGW_TUNNEL1_RIGHT_SN}}
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
        ,{
            USER_DATA = <<-EOF
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
            systemctl restart mariadb
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
        ,{
            USER_DATA = <<-EOF
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
}

# REG2
locals {
    AWS_REG2_VPC1_INSs = [
        {
            NAME = "SINGAPORE_INS1_NAT1"
            KEY_NAME = module.AWS_REG2_KEY.KEY_NAME[0]
            AMI = "ami-036fb5fe12bc53979"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG2_VPC1.Za_SN1_ID
            SG_IDs = [module.AWS_REG2_VPC1.SG_ID[0]]
            PRI_IPV4s = ["10.3.1.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SINGAPORE_INS2_WEB1"
            KEY_NAME = module.AWS_REG2_KEY.KEY_NAME[0]
            AMI = "ami-06ebb7936bfa62864"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = true            
            SN_ID = module.AWS_REG2_VPC1.Za_SN2_ID
            SG_IDs = [module.AWS_REG2_VPC1.SG_ID[1]]
            PRI_IPV4s = ["10.3.3.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
    ]

    AWS_REG2_VPC1_INS_UDs = [
        {
            USER_DATA = <<-EOF
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
        ,{
            USER_DATA = <<-EOF
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

    AWS_REG2_VPC2_INSs = [
        {
            NAME = "SINGAPORE_IDC_INS1_CGW"
            KEY_NAME = module.AWS_REG2_KEY.KEY_NAME[0]
            AMI = "ami-06ebb7936bfa62864"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG2_VPC2.Za_SN1_ID
            SG_IDs = [module.AWS_REG2_VPC2.SG_ID[0]]
            PRI_IPV4s = ["10.4.0.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SINGAPORE_IDC_INS2_DB"
            KEY_NAME = module.AWS_REG2_KEY.KEY_NAME[0]
            AMI = "ami-06ebb7936bfa62864"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false            
            SN_ID = module.AWS_REG2_VPC2.Za_SN2_ID
            SG_IDs = [module.AWS_REG2_VPC2.SG_ID[1]]
            PRI_IPV4s = ["10.4.1.100"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }
        ,{
            NAME = "SINGAPORE_IDC_INS3_DNS"
            KEY_NAME = module.AWS_REG2_KEY.KEY_NAME[0]
            AMI = "ami-06ebb7936bfa62864"
            TYPE = "t2.micro"
            AUTO_PUBLIC_IP = false
            SRC_DEST_CHECK = false
            SN_ID = module.AWS_REG2_VPC2.Za_SN2_ID
            SG_IDs = [module.AWS_REG2_VPC2.SG_ID[2]]
            PRI_IPV4s = ["10.4.1.200"]
            VOL_DIR = "/dev/xvda"
            VOL_SIZE = 8
            VOL_TYPE = "gp2"
        }        
    ]

    AWS_REG2_VPC2_INS_UDs = [
        {
            USER_DATA = <<-EOF
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
                    leftsubnets={${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_LEFT_SN}}
                    rightsubnets={${local.AWS_REG2_TGW_CON_CGW_TUNNEL1_RIGHT_SN}}
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
        ,{
            USER_DATA = <<-EOF
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
            systemctl restart mariadb
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
            mysql -uroot -pqwe123 <<-EOT
            CHANGE MASTER TO
            MASTER_HOST = '10.2.1.100',
            MASTER_USER = 'repl_user',
            MASTER_PASSWORD = 'qwe123',
            MASTER_LOG_FILE = 'mysql-bin.000001',
            MASTER_LOG_POS = 245;
            EOT
            mysql -uroot -pqwe123 <<-EOT
            START SLAVE
            EOT
            EOF
        }
        ,{
            USER_DATA = <<-EOF
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
}