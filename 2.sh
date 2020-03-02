1) Просмотр директорий /etc

vud@SERVER-RDP-COUS:~$ cat /etc/resolv.conf
# This file is managed by man:systemd-resolved(8). Do not edit.
#
# This is a dynamic resolv.conf file for connecting local clients directly to
# all known uplink DNS servers. This file lists all configured search domains.
#
# Third party programs must not access this file directly, but only through the
# symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a different way,
# replace this symlink by a static file or a different symlink.
#
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

# No DNS servers known.
nameserver 188.72.74.3
nameserver 188.72.75.23
vud@SERVER-RDP-COUS:~$ 
vud@SERVER-RDP-COUS:~$ 
vud@SERVER-RDP-COUS:~$ ls -l /etc/realmd.conf 
-rw-r--r-- 1 root root 280 мар 30  2019 /etc/realmd.conf
vud@SERVER-RDP-COUS:~$ cat /etc/realmd.conf 
[users]
default-home = /home/%D/%U
default-shell = /bin/bash

[active-directory]
default-client = sssd
os-name = Ubuntu
os-version = 18.10

[service]
automatic-install = no

[dvrc.ru]
fully-qualified-names = yes
automatic-id-mapping = no
user-principal = yes
manage-system = yes
