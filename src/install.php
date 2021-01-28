#!/usr/bin/env php
<?php

/**
 * @file
 * Provides CLI commands for Drupal.
 */

use Drupal\Core\Command\QuickStartCommand;
use Drupal\Core\Command\InstallCommand;
use Drupal\Core\Command\ServerCommand;
use Symfony\Component\Console\Application;

if (PHP_SAPI !== 'cli') {
  return;
}

$classloader = require_once __DIR__ . '/web/autoload.php';

$application = new Application('drupal', \Drupal::VERSION);

$application->add(new QuickStartCommand());
$application->add(new InstallCommand($classloader));
//$application->add(new ServerCommand());

// we don't want to start a dev server since we're using Lando.
// This must be improved,
// didn't have time to research on how to install Drupal without setting up a server..

$application->run();


