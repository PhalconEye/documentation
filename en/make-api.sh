#!/bin/sh

# Find php doc directory and copy api theme there.
echo 'Copying API theme into phpdoc directory..'
PHPDOCLOCATION="$(pear list-files phpdoc/phpDocumentor | grep VERSION | sed -e 's/php    //g')"
PHPDOCLOCATION="$(dirname "$PHPDOCLOCATION")/data/templates"
$(sudo cp -fr ./_theme/phalconeye-api/* ${PHPDOCLOCATION}/phalconeye-api)

# Ask about PhalconEye app dir
echo -n "Type PhalconEye 'app' directory location, followed by [ENTER]: "
read LOCATION
THEME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/_theme/api/"

# Cleanup phpdoc twig cache
$(rm -rf /temp/phpdoc-twig-cache)

# Make api docs..
$(phpdoc -d ${LOCATION}/engine,${LOCATION}/modules -t ./api -i Package/Structure/,Asset/Css/lessc.inc.php,Behaviour/DIBehaviour.php --template "phalconeye-api")