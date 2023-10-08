#!/bin/bash

# use the correct version of node
nvm use 18

# initialise frappe bench
bench init --skip-redis-config-generation frappe-bench
cd frappe-bench

# set the config
bench set-config -g db_host mariadb
bench set-config -g redis_cache redis://redis:6379  # For production redis://redis-cache:6379
bench set-config -g redis_queue redis://redis:6379  # For production redis://redis-queue:6379
bench set-config -g redis_socketio redis://redis:6379  # For production redis://redis-socketio:6379

# set the config to developer mode
bench set-config -g developer_mode true