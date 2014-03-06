#!/bin/sh

echo -n "Type PhalconEye app directory location, followed by [ENTER]: "
read LOCATION
THEME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/_theme/api/"

`sudo phpdoc -d $LOCATION/engine,$LOCATION/modules -t ./api -i Package/Structure/,Asset/Css/lessc.inc.php,Behaviour/DIBehaviour.php --template=$THEME`