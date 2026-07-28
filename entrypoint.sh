#!/bin/sh
UUID=${UUID:-$(cat /proc/sys/kernel/random/uuid)}
PORT=${PORT:-8080}
sed -i "s/UUID_PLACEHOLDER/$UUID/g" /etc/v2ray/config.json.template
sed -i "s/PORT_PLACEHOLDER/$PORT/g" /etc/vray/config.json.template
cp /etc/v2ray/config.json.template /etc/v2ray/config.json
echo "Starting V2Ray with UUID: $UUID on port: $PORT"
exec v2ray run -config /etc/v2ray/config.json
