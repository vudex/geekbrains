# Настроить сетевой интерфейс на Ubuntu через netplan
# Рабочая машина, которую как раз накануне настраивал через netplan

admin@sormbd:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:50:56:9f:65:d9 brd ff:ff:ff:ff:ff:ff
    inet 10.100.0.207/24 brd 10.100.0.255 scope global ens160
       valid_lft forever preferred_lft forever
    inet6 fe80::250:56ff:fe9f:65d9/64 scope link 
       valid_lft forever preferred_lft forever
       
admin@sormbd:~$ cat /etc/netplan/50-cloud-init.yaml 
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets: 
        ens160:
                addresses: [10.100.0.207/24]
                gateway4: 10.100.0.254
                routes:
                        - to: 192.168.54.2/32
                          via: 10.100.0.18
                nameservers:
                        addresses: [8.8.8.8, 1.1.1.1]
                dhcp4: no
    version: 2


# 1) Настроить удаленную виртуальную машину
# 2) Настроить установить apache2 и nginx
# 3) Apache2 заставим слушать порт 4040, nginx 80
# 4) Сделать в iptables перенаправление с порта 8080 на 80 (доступ к nginx)
# 5) Настроить доступ по ssh только с указанного ip адреса (iptables)
# ----------------------------------------------------------
# 1) Создать домен на freedom.com
# 2) Передать управление NS-записями на cloudflare.com

# Регистрируемся на сервисе Яндекс.Облако и делаем виртуальную машину с "белым" ip.
# https://imgur.com/30c4Q0D - скриншот
# При создании необходимо указать публичный ssh ключ, для удаленного подключения. Подключаемся по белому адресу.

# Устанавливаем apache2 и nginx
vudex@yandexvm:~$ sudo apt install nginx-full
vudex@yandexvm:~$ sudo apt install apache2

# Настраиваем порты, которые будут слушать данные сервисы
# https://imgur.com/a/o6XeYB5 - apache порт 4040
# https://imgur.com/a/0rz6CPr - nginx  порт 80

# Сделаем iptables, чтобы зайти можно было только на порт 80 и ssh22. Порт 8080 должен редиректить на 80. 
# Чтобы что-то увидеть - перенаправим запросы с 8080 на 80 порт (на nginx)
# Также сделаем возможность принимать запросы только с ip адреса 159.253.170.217 (сегодня мой глобальный адрес такой) и на веб и на ssh.
vudex@yandexvm:/var/www/nginx$ sudo iptables -L -n
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination  

# Сделаем политику DROP на цепочке INPUT, но чтобы не потерять управление VM, сначала пропишем разрешаюшие правила в цепочку
vudex@yandexvm:/var/www/nginx$ sudo iptables -A INPUT -p tcp -s 159.253.170.217 --dport 22 -j ACCEPT 
vudex@yandexvm:/var/www/nginx$ sudo iptables -A INPUT -p tcp -s 159.253.170.217 --dport 8080 -j ACCEPT 
vudex@yandexvm:/var/www/nginx$ sudo iptables -A INPUT -p tcp -s 159.253.170.217 --dport 80 -j ACCEPT
vudex@yandexvm:/var/www/nginx$ sudo iptables -P INPUT DROP
vudex@yandexvm:/var/www/nginx$ sudo iptables -L -n
Chain INPUT (policy DROP)
target     prot opt source               destination         
ACCEPT     tcp  --  159.253.170.217      0.0.0.0/0            tcp dpt:22
ACCEPT     tcp  --  159.253.170.217      0.0.0.0/0            tcp dpt:8080
ACCEPT     tcp  --  159.253.170.217      0.0.0.0/0            tcp dpt:80

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination 

# Редирект 8080 -> 80
vudex@yandexvm:~$ sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 8080 -j REDIRECT --to-ports 80
vudex@yandexvm:~$ sudo iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         
REDIRECT   tcp  --  anywhere             anywhere             tcp dpt:http-alt redir ports 80

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Chain POSTROUTING (policy ACCEPT)
target     prot opt source 


