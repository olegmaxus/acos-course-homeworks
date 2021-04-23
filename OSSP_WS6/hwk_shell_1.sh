#!/bin/bash

echo -n "Enter your name: "
if read -t 15 name ; then
	echo "Hello, $name!"
else
	echo -e "\nHello, $(whoami)?"
fi
