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


# 3) Создать группу developer и несколько пользователей, входящих в нее.
# Создать директорию для совместной работы.
# Сделать так, чтобы созданные одними пользователями файлы могли изменять другие пользователи этой группы.

[vud@localhost dz]$ groupadd developer
[vud@localhost dz]$ mkdir for_devs
[vud@localhost dz]$ ls -l
total 0
drwxrwxr-x. 2 vud vud 6 Mar  6 21:40 for_devs

[vud@localhost dz]$ sudo usermod -aG developer vud 
[vud@localhost dz]$ sudo usermod -aG developer needs_tobe_root
[vud@localhost dz]$ chmod g+rws for_devs/
[vud@localhost dz]$ sudo chown :developer for_devs/
[vud@localhost dz]$ ls -l
total 0
drwxrwsr-x. 2 vud developer 6 Mar  6 21:40 for_devs 
# Теперь файлы, созданные в директории будут наследовать группу developer, т.к. задан sguid
[vud@localhost dz]$ cd for_devs/
[vud@localhost for_devs]$ touch test_file_vud
[vud@localhost for_devs]$ su - needs_tobe_root
Password: 
[needs_tobe_root@localhost for_devs]$ touch test_file_needs
[needs_tobe_root@localhost for_devs]$ ls -l
total 0
-rw-rw-r--. 1 needs_tobe_root developer 0 Mar  6 21:48 test_file_needs
-rw-rw-r--. 1 vud             developer 0 Mar  6 21:46 test_file_vud
# Пользователь needs_tobe_root сможет записать файл test_file_needs
[needs_tobe_root@localhost for_devs]$ echo Файл другого пользователя записан > test_file_vud 
[needs_tobe_root@localhost for_devs]$ cat test_file_vud 
Файл другого пользователя записан


# 4) Создать в директории для совместной работы поддиректорию для обмена файлами, но чтобы удалять файлы могли только их создатели.

 # Надо задать sticky bit для директории
 [needs_tobe_root@localhost for_devs]$ mkdir share
[needs_tobe_root@localhost for_devs]$ ls -l
total 4
drwxrwsr-x. 2 needs_tobe_root developer  6 Mar  6 21:52 share
 
[needs_tobe_root@localhost for_devs]$ chmod +t share/
[needs_tobe_root@localhost for_devs]$ touch share/vud_wont_delete
[needs_tobe_root@localhost for_devs]$ 
[root@localhost ~]# su - vud
[vud@localhost ~]$ rm dz/for_devs/share/vud_wont_delete 
rm: cannot remove 'dz/for_devs/share/vud_wont_delete': Operation not permitted
 
# Уберем стики бит для проверки удаления
[vud@localhost ~]$ chmod -t dz/for_devs/share/
chmod: changing permissions of 'dz/for_devs/share/': Operation not permitted # Кстати, chmod +t задался без sudo, а убрать только с sudo?
[vud@localhost ~]$ sudo chmod -t dz/for_devs/share/
[vud@localhost ~]$ rm dz/for_devs/share/vud_wont_delete 
[vud@localhost ~]$ ls -l dz/for_devs/share/
total 0


# 5) Создать директорию, в которой есть несколько файлов.
# Сделать так, чтобы открыть файлы можно было, только зная имя файла, а через ls список файлов посмотреть было нельзя.

[vud@localhost dz]$ mkdir close_directory
[vud@localhost dz]$ ls -l
total 0
drwxrwxr-x. 2 vud vud        6 Mar  6 21:59 close_directory

[vud@localhost dz]$ echo Файл открыт! > close_directory/hidden_file
[vud@localhost dz]$ cat close_directory/hidden_file 
Файл открыт!
[vud@localhost dz]$ ls -l close_directory/
total 4
-rw-rw-r--. 1 vud vud 23 Mar  6 22:00 hidden_file

# Директория читается, файл открывается. Изменим права директории. 

d-wx-wx--x. 2 vud vud       25 Mar  6 22:00 close_directory
drwxrwsr-x. 3 vud developer 63 Mar  6 21:52 for_devs
[vud@localhost dz]$ ls -l close_directory/
ls: cannot open directory 'close_directory/': Permission denied
[vud@localhost dz]$ cat close_directory/hidden_file
Файл открыт!

# Занятно, что в этом случае на имя файла не работает tab




