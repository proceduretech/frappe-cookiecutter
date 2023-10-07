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

We need to tell bench to use the right containers instead of localhost. Run the following commands inside the container:

```shell
bench set-config -g db_host mariadb
bench set-config -g redis_cache redis://redis-cache:6379
bench set-config -g redis_queue redis://redis-queue:6379
bench set-config -g redis_socketio redis://redis-socketio:6379
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
