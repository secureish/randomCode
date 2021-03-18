#!/bin/bash

if [ ! -f "$1" ]; then
    echo "The file \"$1\" does not exist!"
    exit 1
fi

if [ ! $(basename "$1") == "http_proxy.go" ]; then
    echo "You should be pointing me at http_proxy.go"
    echo "... not $1"
    exit 1
fi

# if no input arguments supplied, display usage
if [ $# -ne 1 ]
then
   echo "Usage: $0 <path to http_proxy.go>"
   echo
   echo "This will patch some lines in http_proxy.go to"
   echo "stop it from sending the 'X-Evilginx' http header."
   echo "The original file will be backed up to /tmp/"
   echo "Tested on Evilginx v2.4.2"
   exit 1
fi

echo "Ttested on Evilginx v2.4.2"
echo "backing up original file to /tmp/ ... just in case!"
cp $1 /tmp/
echo

echo "The following lines will be commented out:"
sed -n -e 183p -e 350p -e 377,379p -e 381p -e 407p -e 562,566p -e 580p -e 1450,1456p
echo

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sed -i '183 s/^/\/\//' $1
   sed -i '350 s/^/\/\//' $1
   sed -i '377,379 s/^/\/\//' $1
   sed -i '381 s/^/\/\//' $1
   sed -i '407 s/^/\/\//' $1
   sed -i '562,566 s/^/\/\//' $1
   sed -i '580 s/^/\/\//' $1
   sed -i '1450,1456 s/^/\/\//' $1

   echo "Ok, the file now looks like:"
   sed -n -e 183p -e 350p -e 377,379p -e 381p -e 407p -e 562,566p -e 580p -e 1450,1456p
else
   echo "Ok, cancelled, bye!"
fi
