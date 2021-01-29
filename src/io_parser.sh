#!/bin/bash

## defaults
CORE_VERSION=9
VERBOSITY=0
MODULE="core"
PATCH=0
VERSION=0
ISSUE_FORK=0
LANDO_RECIPE="drupal9"
WEBROOT="web"

for i in "$@"
do
case $i in
    -c=*|--core=*)
        CORE_VERSION="${i#*=}"
        shift 
        regex='^[8-9]+$'
        if ! [[ $CORE_VERSION =~ $regex ]] ; then
        echo "Para correr este script, la version del core debe ser 8 o 9" >&2; exit 1
        fi

        LANDO_RECIPE="drupal${CORE_VERSION}"
        ;;
    -m=*|--module=*)
        MODULE="${i#*=}"
        shift 
        ;;
    -mv=*|--module_version=*|--module-version=*)
        MV="${i#*=}"
        VERSION=":${i#*=}"
        shift 
        ;;

    -p=*|--patch=*)
        PATCH="${i#*=}"
        shift 
        ;;
    -if=*|--issue-fork=*)
        ISSUE_FORK="${i#*=}"
        shift 
        ;;
    -vvv)
        VERBOSITY=3
        shift 
        ;;
    -vv)
        VERBOSITY=2
        shift 
        ;;
    -v)
        VERBOSITY=1
        shift 
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
echo "Issue Fork               = ${ISSUE_FORK}"
echo "Project name (folder)    = ${PROJECT_NAME}"

if [ "${VERBOSITY}" -ge "1" ] ; then
    echo "Lando recipe             = ${LANDO_RECIPE}"
fi


#echo "Verbosity               = ${VERBOSITY}"




if [ "${PATCH}" = "0" ] && [ "${ISSUE_FORK}" = "0" ]; then
    echolor "\nThe script need the information of the issue to be able to run. Either enter a patch file URL or the fork."
    exit 1
fi

if [ "${ISSUE_fork}" = "0" ]; then
    PATCH_WORKFLOW=true
fi


## si tiene modulo tiene que tener version?