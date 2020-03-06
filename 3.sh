# 1) Создать файл file1 и наполнить его произвольным содержимым.
# Скопировать его в file2.
# Создать символическую ссылку file3 на file1.
# Создать жесткую ссылку file4 на file1.
# Посмотреть, какие айноды у файлов. Удалить file1. Что стало с остальными созданными файлами? Попробовать вывести их на экран.
# Дать созданным файлам другие, произвольные имена.
# Создать новую символическую ссылку.
# Переместить ссылки в другую директорию.

[vud@localhost dz]$ echo Случайное содержимое > file1
[vud@localhost dz]$ cat file1 
Случайное содержимое

[vud@localhost dz]$ cp file1 file2
[vud@localhost dz]$ cat file2
Случайное содержимое
[vud@localhost dz]$ 

[vud@localhost dz]$ ln -s /home/vud/dz/file1 /home/vud/dz/file3
[vud@localhost dz]$ 
[vud@localhost dz]$ ls -l
total 12
-rw-rw-r--. 2 vud vud 40 Mar  6 21:13 file1
-rw-rw-r--. 1 vud vud 40 Mar  6 21:16 file2
lrwxrwxrwx. 1 vud vud 18 Mar  6 21:17 file3 -> /home/vud/dz/file1

[vud@localhost dz]$ ln file1 file4
[vud@localhost dz]$ ls -li
total 8
537461858 -rw-rw-r--. 2 vud vud 40 Mar  6 21:13 file1
537461858 -rw-rw-r--. 2 vud vud 40 Mar  6 21:13 file4

[vud@localhost dz]$ rm file1
[vud@localhost dz]$ cat file4
Случайное содержимое

[vud@localhost dz]$ cat file3
cat: file3: No such file or directory

[vud@localhost dz]$ mv file2 fi2
[vud@localhost dz]$ mv file4 fi4
[vud@localhost dz]$ mv file3 fi3
[vud@localhost dz]$ ln -s /home/vud/dz/fi4 /home/vud/dz/new_link
[vud@localhost dz]$ mv new_link /home/vud/
[vud@localhost dz]$ cat ../new_link 
Случайное содержимое


# 2) Создать два произвольных файла.
# Первому присвоить права на чтение, запись для владельца и группы, только на чтение — для всех.
# Второму присвоить права на чтение, запись — только для владельца. Сделать это в численном и символьном виде.
# Создать пользователя, обладающего возможностью выполнять действия от имени суперпользователя.

[vud@localhost dz]$ touch new1 new2
[vud@localhost dz]$ ls -l
total 0
-rw-rw-r--. 1 vud vud 0 Mar  6 21:25 new1 # Права уже присвоились по заданию. Сделаю два второго файла
-rw-rw-r--. 1 vud vud 0 Mar  6 21:25 new2

[vud@localhost dz]$ chmod go-rw new2 
[vud@localhost dz]$ ls -l
total 0
-rw-rw-r--. 1 vud vud 0 Mar  6 21:25 new1
-rw-------. 1 vud vud 0 Mar  6 21:25 new2

[vud@localhost dz]$ rm new2 ; touch new2
[vud@localhost dz]$ ls -l
total 0
-rw-rw-r--. 1 vud vud 0 Mar  6 21:25 new1
-rw-rw-r--. 1 vud vud 0 Mar  6 21:28 new2

[vud@localhost dz]$ chmod 0600 new2 
[vud@localhost dz]$ ls -l
total 0
-rw-rw-r--. 1 vud vud 0 Mar  6 21:25 new1
-rw-------. 1 vud vud 0 Mar  6 21:28 new2

[vud@localhost dz]$ sudo useradd needs_tobe_root
[vud@localhost dz]$ sudo passwd needs_tobe_root
Changing password for user needs_tobe_root.
New password: 
BAD PASSWORD: The password fails the dictionary check - it is based on a dictionary word
Retype new password: 
passwd: all authentication tokens updated successfully.
[vud@localhost dz]$ su - needs_tobe_root
Password: 
[needs_tobe_root@localhost ~]$ sudo cat /etc/shadow

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for needs_tobe_root: 
needs_tobe_root is not in the sudoers file.  This incident will be reported.

[needs_tobe_root@localhost ~]$ su - vud
Password: 
[vud@localhost ~]$ sudo usermod -aG wheel needs_tobe_root
[vud@localhost ~]$ su - needs_tobe_root
Password: 
[needs_tobe_root@localhost ~]$ sudo cat /etc/shadow | tail -1
needs_tobe_root:$6$xQIxcinzoN.3qS8d$IgFjqbPQLfsegL.P6j35e4xwTHomc2Rqzr8O.rxNsWC23hGKIRoA84PN6MASmCi67rizlDMwfYvIurtgJJe30.:18327:0:99999:7:::

