#### Building

1. Start the project in a dev container

### Use the correct version of node

Run the following commands in the terminal inside the container. You might need to create a new terminal in VSCode. We need to tell the container to use node version 18.
`nvm use 18`

### Initialise the bench

Run the following commands in the terminal inside the container. You might need to create a new terminal in VSCode.

```shell
bench init --skip-redis-config-generation frappe-bench
cd frappe-bench
```

### Set the configs

We need to tell bench to use the right containers instead of localhost. Run the following commands inside the container (Using the same redis instance for cache, queue and socketio in development mode):

```shell
bench set-config -g db_host mariadb
bench set-config -g redis_cache redis://redis:6379
bench set-config -g redis_queue redis://redis:6379
bench set-config -g redis_socketio redis://redis:6379
```

### Enable developer mode

Before we can make any changes like create DocType, etc, we need to enable developer mode

```shell
bench set-config -g developer_mode true
bench start
```

### Create a new site with bench

You can create a new site with the following command:

```shell
bench new-site sitename --no-mariadb-socket
```

sitename MUST end with .localhost for trying deployments locally.

for example:

```shell
bench new-site development.localhost --no-mariadb-socket
```

The same command can be run non-interactively as well:

```shell
bench new-site development.localhost --mariadb-root-password 123 --admin-password admin --no-mariadb-socket
```

For more info go through the [Frappe Tutorial](https://frappeframework.com/docs/user/en/tutorial)

### Set bench developer mode on the new site

To develop a new app, the last step will be setting the site into developer mode. Documentation is available at [this link](https://frappe.io/docs/user/en/guides/app-development/how-enable-developer-mode-in-frappe).

```shell
bench --site development.localhost set-config developer_mode 1
bench --site development.localhost clear-cache
```

### Install an app

To install an app we need to fetch it from the appropriate git repo, then install in on the appropriate site:

You can check [VSCode container remote extension documentation](https://code.visualstudio.com/docs/remote/containers#_sharing-git-credentials-with-your-container) regarding git credential sharing.

To install custom app

```shell
# --branch is optional, use it to point to branch on custom app repository
bench get-app --branch version-12 https://github.com/myusername/myapp
bench --site development.localhost install-app myapp
```

At the time of this writing, the Payments app has been factored out of the Version 14 ERPNext app and is now a separate app. ERPNext will not install it.

```shell
bench get-app --branch version-14 --resolve-deps erpnext
bench --site development.localhost install-app erpnext
```

To install ERPNext (from the version-13 branch):

```shell
bench get-app --branch version-13 erpnext
bench --site development.localhost install-app erpnext
```

Note: Both frappe and erpnext must be on branch with same name. e.g. version-14
