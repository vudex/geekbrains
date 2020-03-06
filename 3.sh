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


2) Создать два произвольных файла.
Первому присвоить права на чтение, запись для владельца и группы, только на чтение — для всех.
Второму присвоить права на чтение, запись — только для владельца. Сделать это в численном и символьном виде.
Создать пользователя, обладающего возможностью выполнять действия от имени суперпользователя.
