#!/bin/bash

. src/system_checks.sh
. src/utils.sh
. src/io_parser.sh


custom_message "Starting a local development environment for a Drupal $CORE_VERSION project, to test a patch against $MODULE$VERSION"
run_composer "composer create-project drupal/recommended-project:^$CORE_VERSION $PROJECT_NAME"

# This folder exists.
cd $PROJECT_NAME

# Generate .lando.yml file
custom_message "Initializing Lando project."
run_lando "lando init --name=$PROJECT_NAME --recipe=$LANDO_RECIPE --source=cwd --webroot=$WEBROOT"

# instalamos contenedores de Lando.
custom_message "Installing Lando containers."
run_lando "lando start"



# Check if Drush needs to be installed
lando drush > /dev/null
DRUSH_EXISTS=$?
if [ ! "${DRUSH_EXISTS}" = "0" ] ; then
	custom_message "Installing Drush via Composer."
	run_lando "lando composer require drush/drush --no-update"
fi



custom_message "Adding $MODULE as a requirement via Composer"
run_lando "lando composer require drupal/$MODULE$VERSION  --no-update"


custom_message "Setting up patches libraries and downloading patch."

run_lando "lando composer require cweagans/composer-patches"
run_lando "lando composer require szeidler/composer-patches-cli:^1.0"
run_lando "lando composer patch-enable --file=patches.json"

run_lando "lando composer patch-add drupal/$MODULE $MODULE $PATCH;"



custom_message "Running composer install"
run_lando "lando composer install"


custom_message "Generating vainilla database"

cp ../src/install.php .
run_forced "lando php ./install.php quick-start -s -n --site-name $PROJECT_NAME --langcode=es standard" 
rm install.php

custom_message "Enableing $MODULE"
run_lando "lando drush en $MODULE"

echo -e "Done.\n"

custom_message "Use any of these URLS to access the site"
lando info --service="appserver" | grep http | sed  's/\[//g' | sed 's/ //g' | awk  -F '\047' '{printf "%s\n", $2}'

custom_message "Log in with these credentials"
run_lando "lando drush upwd admin admin"

echolor "User:        admin"
echolor "Password:    admin"