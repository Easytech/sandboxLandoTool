# sandboxLandoTool

## Start a local environment

### Just the Drupal Core

1) Navigate to the root folder of this project 
2) Run the `start_environment` script. The argument `--core` is optional, and can be used to indicate the major version of the Drupal core: 8 or 9.

Example:

```
bash start_environment.sh \
    --core=8
```

### Want to work on a module?

1) Navigate to the root folder of this project 
2) Run the `start_environment` script. The argument `--module` is optional, but once it is entered, the argument `--module_version` is mandatory.

Example:

```
bash start_environment.sh \
    --module=view_password \
    --module_version=5.x-dev@dev \
```

If you're planning on working in an issue you'll need to add a dev version. Check out the module and it's releases, try to find something like the example explained above.

### Want to test an existing patch?
1) Navigate to the root folder of this project 
2) Run the `start_environment` script. The arguments `--module`, `--module_version` and `--patch` are mandatory.
Be sure to use the version of the module and the Drupal Core indicated in the issue you're reviewing.

Example:

```
bash start_environment.sh \
    --module=view_password \
    --module_version=5.x-dev@dev \
    --patch="https://www.drupal.org/files/issues/2021-01-08/3191748-eye-icon-is-not-accessible-2.patch" \
    -v
```

## Destroy the unused local environment

Navigate to the root folder of this project and run the `destroy_environment` script. It will ask what folder/project it needs to remove, and destroy its contents.

```
bash destroy_environment.sh
```
