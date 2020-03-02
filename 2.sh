1) Просмотр директорий

vud@zharkov:~$ ls -l /etc/ /proc/ /home/

2) Просмотр файлов 

vud@zharkov:~$ cat /etc/ucf.conf

# Если файл большой - лучше запайпить через less
vud@zharkov:~$ cat /etc/ucf.conf | less 

# Можно сразу через любой редактор (vim, nano)
vud@zharkov:~$ vim /etc/ucf.conf

3) Прочитать про команду cat
vud@zharkov:~$ man cat
CAT(1)                                                         User Commands                                                        CAT(1)

NAME
       cat - concatenate files and print on the standard output

4) Создать два файла при помощи cat и объеденить их в третий файл. Просмотреть содержимое файла, переименовать его.

vud@zharkov:~$ cat > test1.txt
Тестовый файл созданный cat
Вторая строка файла    
^C
vud@zharkov:~$ cat > test2.txt
Второй тестовый файл
Вторая тестовая строка второго файла
^C
vud@zharkov:~$ cat test1.txt test2.txt > output.txt
vud@zharkov:~$ cat output.txt 
Тестовый файл созданный cat
Вторая строка файла
Второй тестовый файл
Вторая тестовая строка второго файла
vud@zharkov:~$ 
vud@zharkov:~$ mv output.txt rename_output.txt
vud@zharkov:~$ cat rename_output.txt 
Тестовый файл созданный cat
Вторая строка файла
Второй тестовый файл
Вторая тестовая строка второго файла
vud@zharkov:~$ 
vud@zharkov:~$ cat output.txt
cat: output.txt: No such file or directory

5) Подсчитать скрытые файлы в домашнем каталоге 
# Можно сделать вот так, но также подсчитает и скрытые директории. Первое число это кол-во строк, т.е. кол-во "файлов".
vud@zharkov:~$ ls -a | grep "^\." | wc  
     45      45     491
# Другой способ, чтобы наверняка подсчитать только файлы - использовать find
vud@zharkov:~$ find ~/ -maxdepth 1 -type f | grep "/\." | wc 
     22      22     539

6) Попробовать вывести с помощью cat все файлы в директории /etc. Направить ошибки в отдельный файл в вашей 
домашней директории. Сколько файлов, которые не удалось посмотреть, оказалось в списке?
# Использовал команду из предыдущего пункта, обёрнутую в Command Substitution. На месте $(CMD) останется OUTPUT выполненной 
# команды. Если делать с sudo, то ошибок нет
sudo cat $(find /etc -maxdepth 1 -type f) >> ~/etc-output.txt

# Выполним без sudo и направим ошибки в файл etc-erorrs.txt

vud@zharkov:~$ cat $(find /etc -maxdepth 1 -type f) >> ~/etc-output.txt 2> etc-errors.txt

vud@zharkov:~$ cat etc-errors.txt 
cat: /etc/sudoers: Permission denied
cat: /etc/gshadow-: Permission denied
cat: /etc/krb5.keytab: Permission denied
cat: /etc/.pwd.lock: Permission denied
cat: /etc/gshadow: Permission denied
cat: /etc/shadow-: Permission denied
cat: /etc/shadow: Permission denied
vud@zharkov:~$ cat etc-errors.txt | wc
      7      28     265



