#!/bin/bash

. src/utils.sh

for f in * ; do
	if [ -d "$f" ] && [ ! "${f}" = "src" ]; then
		array+=($f);
	fi
done

echolor "Select the project to remove (database, files, code)"

select PROJECT_NAME in ${array[*]}; do
	cd $PROJECT_NAME
	echo "Destroy Lando containers for $PROJECT_NAME"
	lando destroy -y

	cd ..
	echo "Delete all files in directory $PROJECT_NAME"
	sudo rm -rf $PROJECT_NAME

	echo "All done!"
	exit
done

echo "No project folder found in this directory."
