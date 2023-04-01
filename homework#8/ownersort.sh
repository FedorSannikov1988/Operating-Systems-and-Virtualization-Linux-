#!/bin/bash

pathFolder=$1

#валидация введенной строки (первый уровень проверки):

if [ -z $pathFolder ]
  then
    flagone=0
    echo "Ошибка ! -> Количество символов в введенной строке равно нулю"
  else
    flagone=1
    echo "Введенная строка -> Ок !"
fi

#валидация наличия дирректории (второй уровень проверки) :

if (( flagone=1 ))
  then

if [ -d $pathFolder ]
  then
    flagtwo=1
    echo "Каталог -> Ок !"
  else
    flagtwo=0
    echo "Ошибка ! -> Каталога: " $pathFolder "не существует"

fi
fi

#процесс копирования при условии что пройдена двухступенчатая валидация

if (( flagtwo=1 ))
  then

for files_inside_folder in $pathFolder/*
do

file_name=$(basename $files_inside_folder)
file_owner=$(stat -c%U $files_inside_folder)

#echo "абсолютный путь к файлу:"
#echo $files_inside_folder
#echo "владелец файла:"
#echo $file_owner
#echo "имя файла:"
#echo $file_name

if [ -d $pathFolder/$file_owner ]
  then
    cp $files_inside_folder $pathFolder/$file_owner
  else
    mkdir -p $pathFolder/$file_owner
    cp $files_inside_folder $pathFolder/$file_owner
fi

chown $file_owner $pathFolder/$file_owner/$file_name

done
fi

#P.S.: можно и покороче но я вроде как за этим не гонюсь