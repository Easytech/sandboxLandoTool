#!/bin/bash

which git > /dev/null
if [ ! $? = 0 ]; then
	echo "Script is unable to find Git. Please correct this."
	exit 1
fi
which lando > /dev/null
if [ ! $? = 0 ]; then
	echo "Script is unable to find Lando. Please correct this."
	exit 1
fi
