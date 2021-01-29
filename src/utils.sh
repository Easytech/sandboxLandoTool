#!/bin/bash

custom_message() {
	echo -e "\n\n\n\x1B[1;33m--------------------------------------------------------------------\n\x1B[1;0m"
	echo -e "\t$1"
	echo -e "\x1B[1;33m\n--------------------------------------------------------------------\n\x1B[1;0m"
}

echolor() {
	echo -e "\x1B[33m$1\x1B[0m"
}

# Composer with docker
composer () {
    echo -e " ✈ Composer using Docker ...."

    tty=
    tty -s && tty=--tty\
    docker run \
        $tty \
        --interactive \
        --rm \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume $(pwd):/app \
        composer "$@"
}

run_composer() {
	if [ "${VERBOSITY}" = "0" ] ; then
		cmd="$1 -q"
		echolor "# $cmd"
		$cmd
	elif [ "${VERBOSITY}" = "1" ] ; then
		cmd="$1 -v"
		echolor "# $cmd -v"
		$cmd
	elif [ "${VERBOSITY}" = "2" ] ; then
		cmd="$1 -vv"
		echolor "# $cmd -vv"
		$cmd
	elif [ "${VERBOSITY}" = "3" ] ; then
		cmd="$1 -vvv"
		echolor "# $cmd -vvv"
		$cmd
	fi

	RESULT=$?

	if [ "${RESULT}" != "0" ] ; then
		echo "Error corriendo composer!"
 		exit $RESULT
 	fi
}

run_lando() {
	if [ "${VERBOSITY}" = "0" ] ; then
		cmd="$1 "
		echolor "# $cmd"
		stty -echo
		$cmd > /dev/null
		stty echo
	elif [ "${VERBOSITY}" = "1" ] ; then
		cmd="$1 -v"
		echolor "# $cmd"
		$cmd
	elif [ "${VERBOSITY}" = "2" ] ; then
		cmd="$1 -vv"
		echolor "# $cmd"
		$cmd
	elif [ "${VERBOSITY}" = "3" ] ; then
		cmd="$1 -vvv"
		echolor "# $cmd"
		$cmd
	fi

	RESULT=$?

	if [ "${RESULT}" != "0" ] ; then
		echo "Error corriendo Lando!"
 		exit $RESULT
 	fi
}

run_forced() {
	if [ "${VERBOSITY}" = "0" ] ; then
		cmd="$1 "
		echolor "# $cmd"
		stty -echo
		$cmd > /dev/null
		stty echo
	elif [ "${VERBOSITY}" = "1" ] ; then
		cmd="$1 -v"
		echolor "# $cmd"
		$cmd
	elif [ "${VERBOSITY}" = "2" ] ; then
		cmd="$1 -vv"
		echolor "# $cmd"
		$cmd
	elif [ "${VERBOSITY}" = "3" ] ; then
		cmd="$1 -vvv"
		echolor "# $cmd"
		$cmd
	fi

	RESULT=$?

	if [ "${RESULT}" != "0" ] ; then
		echo "Something went wrong but it wont stop us!"
 	fi
}
