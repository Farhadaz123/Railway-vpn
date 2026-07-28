#!/bin/sh
# entrypoint.sh - V2Ray startup for Railway
# Uses Python to replace placeholders (more reliable than sed in Alpine)

UUID=${UUID:-$(cat /proc/sys/kernel/random/uuid)}
PORT=${PORT:-8080}

# Use Python to replace placeholders
python3 -c "
import json, sys, uuid, os

config = {
    'inbounds': [{
        'listen': '0.0.0.0',
        'port': int(os.environ.get('PORT', '8080')),
        'protocol': 'vmess',
        'settings': {
            'clients': [{
                'id': os.environ.get('UUID', str(uuid.uuid4())),
                'alterId': 0
            }]
        },
        'streamSettings': {
            'network': 'ws',
            'wsSettings': {'path': '/', 'headers': {'Host': ''}},
            'tlsSettings': {'insecure': True}
        }
    }],
    'outbounds': [{'protocol': 'freedom'}]
}

with open('/etc/v2ray/config.json', 'w') as f:
    json.dump(config, f, indent=2)

print(f'Config written for UUID={config[\"inbounds\"][0][\"settings\"][\"clients\"][0][\"id\"]} port={config[\"inbounds\"][0][\"port\"]}')
"

echo "Starting V2Ray with UUID: $UUID on port: $PORT"
exec v2ray run -config /etc/v2ray/config.json
