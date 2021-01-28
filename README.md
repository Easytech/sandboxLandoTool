# sandboxLandoTool

## Start a local environment

Navigate to the root folder of this project and run the `start_environment` script. Some arguments are necessary.

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
