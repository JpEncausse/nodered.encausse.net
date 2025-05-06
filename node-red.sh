#!/bin/bash

PORT=1880
HOST=http://nodered.encausse.net
NODE_ENV=dev
APP="NodeRED"
NAME="--name $APP"

PROJECT_ROOT="`pwd`"
NODE_RED="$PROJECT_ROOT"/node_modules/node-red/red.js
NODE_RED_CONFIG="$PROJECT_ROOT"/node-red-conf/settings.js
LOG_PATH="-o $PROJECT_ROOT/node-red-data/logs/$APP.out.log -e $PROJECT_ROOT/node-red-data/logs/$APP.err.log"

export PROJECT_ROOT

# RUNNING PM2
NODE_ENV=$NODE_ENV \
NODE_TLS_REJECT_UNAUTHORIZED=1 \
HOST="$HOST" \
PORT=$PORT \
pm2 start "$NODE_RED" $LOG_PATH $NAME --node-args="--max-old-space-size=4096" -- -s "$NODE_RED_CONFIG"

# RUNNING NODEJS DIRECTLY
#NODE_ENV=$NODE_ENV \
#NODE_TLS_REJECT_UNAUTHORIZED=1 \
#HOST="$HOST" \
#PORT=$PORT \
#node "$NODE_RED" -s "$NODE_RED_CONFIG"
