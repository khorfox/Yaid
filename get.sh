#!/bin/bash
PUB="120727122944-034f505009f7458a809e5f4bde877a31"
PAG=48
NAM="t01-La-Magicienne-trahie"
CBZ="thorgal"
EXT=".cbz"
export http_proxy=http://user:pwd@server:8080
export https_proxy=http://user:pwd@server:8080
for X in $(seq 1 $PAG) 
do
Y=$X
while [ ${#Y} -ne 4 ]
do  
Y="0"$Y
done
PAGX="page_$X.jpg"
URL="https://image.issuu.com/$PUB/jpg/$PAGX"
wget $URL -O $NAM$Y.jpg --no-check-certificate
done
./zip $NAM$CBZ$EXT *.jpg
del *.jpg