# Написать скрипт, который удаляет из текстового файла пустые строки и заменяет маленькие символы на большие (воспользуйтесь tr или sed).
#
# Решил немного в лоб, возможно не все файлы пройдут проверку

# Выведем тестовый файл с разнообразием пустых строк
[vud@localhost dz]$ cat -A test
line one$
$
after empty line$
               $
after line with spaces$
$
$
$
after multi-empty line$
^I^I^I^I^I$
after tab line$

# Создаем скрипт и тестируем. Показываем содержимое скрипта
[vud@localhost dz]$ vim dz_script.sh
[vud@localhost dz]$ chmod +x dz_script.sh 
[vud@localhost dz]$ ./dz_script.sh test
LINE ONE
AFTER EMPTY LINE
AFTER LINE WITH SPACES
AFTER MULTI-EMPTY LINE
AFTER TAB LINE
[vud@localhost dz]$ cat dz_script.sh 
#!/bin/bash
sed -E '/(^\n*$|^\t*$|^ *$)/d' $1 | tr [:lower:] [:upper:]

# Создать скрипт, который создаст директории для нескольких годов (2010 — 2017), в них — поддиректории для месяцев (от 01 до 12), 
# и в каждый из них запишет несколько файлов с произвольными записями 
# (например, 001.txt, содержащий текст«Файл 001», 002.txt с текстом Файл 002) и т. д.

# Показываем пустой каталог перед выполнением скрипта
[vud@localhost dz]$ ls -l
total 20
-rwxrwxr-x. 1 vud vud  129 Mar  8 22:14 dir.sh
-rwxrwxr-x. 1 vud vud   71 Mar  8 21:26 dz_script.sh
-rw-rw-r--. 1 vud vud  123 Mar  8 21:28 test
-rw-rw-r--. 1 vud vud   18 Mar  8 21:47 test1
-rw-rw-r--. 1 vud vud    0 Mar  8 21:47 test2
-rw-rw-r--. 1 vud vud 1380 Mar  8 21:53 touch

# Выполняем скрипт, показываем каталог
[vud@localhost dz]$ ./dir.sh 
[vud@localhost dz]$ ls -l
total 20
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2010
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2011
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2012
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2013
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2014
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2015
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2016
drwxrwxr-x. 14 vud vud  126 Mar  8 22:16 2017
-rwxrwxr-x.  1 vud vud  127 Mar  8 22:16 dir.sh
-rwxrwxr-x.  1 vud vud   71 Mar  8 21:26 dz_script.sh
-rw-rw-r--.  1 vud vud  123 Mar  8 21:28 test
-rw-rw-r--.  1 vud vud   18 Mar  8 21:47 test1
-rw-rw-r--.  1 vud vud    0 Mar  8 21:47 test2
-rw-rw-r--.  1 vud vud 1380 Mar  8 21:53 touch

[vud@localhost dz]$ ls 2010/
01  02  03  04  05  06  07  08  09  10  11  12
[vud@localhost dz]$ ls 2010/01
01.txt
[vud@localhost dz]$ cat 2010/01/01.txt 
01
[vud@localhost dz]$ cat 2010/12/12.txt 
12
[vud@localhost dz]$ ls 2017/
01  02  03  04  05  06  07  08  09  10  11  12
[vud@localhost dz]$ ls 2017/11/
11.txt
[vud@localhost dz]$ cat 2017/11/11.txt 
11

[vud@localhost dz]$ cat ./dir.sh 
#!/bin/bash 
mkdir -p 201{0..7}/{01..12}
for i in {2010..2017}; do
        for j in {01..12}; do
                echo $j > $i/$j/$j.txt
        done
done

# Создать файл crontab, который ежедневно регистрирует занятое каждым пользователем дисковое пространство в его домашней директории.

# Текущая дата и каталог скрипта
[root@localhost ~]# date
Sun Mar  8 22:50:07 +10 2020
[root@localhost ~]# ls -l
total 12
-rw-------. 1 root root 1608 Mar  1 23:14 anaconda-ks.cfg
-rwxrwxr-x. 1 vud  vud   119 Mar  8 22:48 for_cron.sh
-rw-r--r--. 1 root root 1763 Mar  1 23:19 initial-setup-ks.cfg

# Листинг задач крон
[root@localhost ~]# crontab -l
51 22 * * * /root/for_cron.sh 

# Проверяем дату - скрипт должен выполнится и оставить reports.txt
[root@localhost ~]# date
Sun Mar  8 22:52:02 +10 2020
[root@localhost ~]# cat report.txt 
Sun Mar 8 22:51:01 +10 2020 16K /home/needs_tobe_root
Sun Mar 8 22:51:01 +10 2020 116M /home/vud
[root@localhost ~]# cat for_cron.sh 
#!/bin/bash
dirs=$(ls -d /home/*)
#echo $dirs
for d in $dirs; do
        echo $(date) $(du -sh "$d") >> /root/report.txt
done

# Покажем домашние директории, указав что скрипт выполнился верно
[root@localhost ~]# ls -l /home/
total 4
drwx------.  3 needs_tobe_root needs_tobe_root   99 Mar  8 18:10 needs_tobe_root
drwx---r-x. 16 vud             vud             4096 Mar  8 22:31 vud
[root@localhost ~]# du -sh /home/vud
116M    /home/vud















