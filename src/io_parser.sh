#!/bin/bash

## defaults
CORE_VERSION=9
VERBOSITY=0
MODULE=0
PATCH=0
VERSION=0
ISSUE_QUEUE=0
LANDO_RECIPE="drupal9"
WEBROOT="web"

for i in "$@"
do
case $i in
    -c=*|--core=*)
    CORE_VERSION="${i#*=}"
    shift # past argument=value
    regex='^[8-9]+$'
	if ! [[ $CORE_VERSION =~ $regex ]] ; then
	   echo "Para correr este script, la version del core debe ser 8 o 9" >&2; exit 1
	fi

	LANDO_RECIPE="drupal${CORE_VERSION}"

    ;;
    -m=*|--module=*)
    MODULE="${i#*=}"
    shift # past argument=value
    ;;
    -mv=*|--module_version=*|--module-version=*)
	MV="${i#*=}"
    VERSION=":${i#*=}"
    shift # past argument=value
    ;;

    -p=*|--patch=*)
    PATCH="${i#*=}"
    shift # past argument=value
    ;;

    -vvv)
    VERBOSITY=3
    shift # past argument=value
    ;;
    -vv)
    VERBOSITY=2
    shift # past argument=value
    ;;
    -v)
    VERBOSITY=1
    shift # past argument=value
    ;;

    *)
        echo -e "Options are: \n
        \t-c/--core\tIndicates the major version of the core of Drupal we'll be using. Must be 8 or 9.\n
        \t-m/--module\tThe machine name of the module you're going to review.\n
        \t-mv/--module_version\tThe version that needs to be installed according to the issue that's being reviewed.\n
        \t-p/--patch\tThe URL of the patch file that needs to be applied\n
        \t-v/-vv/-vvv\tThe level of verbosity of this script. \n"
    ;;
esac
done



PROJECT_NAME="sandbox_$MODULE"
ROOTPWD=$PWD


echo "Core version             = ${CORE_VERSION}"
echo "Module you're installing = ${MODULE}"

echo "Module version           = ${MV}" # using $VERSION later
echo "Patch                    = ${PATCH}"
echo "Project name (folder)    = ${PROJECT_NAME}"

if [ "${VERBOSITY}" -ge "1" ] ; then
	echo "Lando recipe             = ${LANDO_RECIPE}"
fi


#echo "Verbosity               = ${VERBOSITY}"




#if [ "${PATCH}" = "0" ] && [ "${ISSUE_QUEUE}" = "0" ]; then
#	echolor "\nThe script need the information of the issue to be able to run. Either enter a patch file URL or the fork."
#	exit 1
#fi


if [ ! "${MODULE}" = "0" ] && [ "${VERSION}" = "0" ]; then
	echolor "\nIf a module is provided, the script needs its VERSION to install it. Please enter it like this:\n\n\t--module_version=1.x-dev@dev\n"
	exit 1
fi
