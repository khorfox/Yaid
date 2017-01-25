#!/bin/bash
function estraiStringa {
   	stringa=$1
   	inizio=$2
	 	fine=$3
   	local estratto=${stringa#*$inizio}
		estratto=${estratto%%$fine*}
		echo $estratto
}
function carica {
URL=$1
wget $URL -O temp.html --no-check-certificate
titoloDao=$(grep '<title>' temp.html)
codiceDao=$(grep 'image.isu.pub/' temp.html)
pageDao=$(grep 'pageCount' temp.html)
echo $pageDao
libro=$(estraiStringa "$titoloDao" "<title>" "</title>")
PUB=$(estraiStringa "$codiceDao" "https://image.isu.pub/" "/jpg/page")
PAG=$(estraiStringa "$pageDao" '"pageCount":' ",")
echo $libro
echo $PUB
echo $PAG
del *.html
$NAM="pagina"
CBZ="temp"
EXT=".cbz"
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
./zip $CBZ$EXT *.jpg
mv $CBZ$EXT "$libro"$EXT
del *.jpg
}
echo inizializzo
export http_proxy=http://user:pwd@server:8080
export https_proxy=http://user:pwd@server:8080
carica "https://issuu.com/grobigou/docs/thorgal---29---le-sacrifice"
carica "https://issuu.com/grobigou/docs/thorgal---27---le-barbare"
echo fine