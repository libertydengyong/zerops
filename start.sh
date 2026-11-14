#!/bin/sh
[ -n "$HY_PASSWORD" ] || { echo "HY_PASSWORD not set"; exit 1; }
cd /tmp
openssl req -x509 -nodes -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -keyout key.pem -out cert.pem -subj "/CN=bing.com" -days 3650
cat > config.yaml <<EOF
listen: :20443
tls:
  cert: /tmp/cert.pem
  key: /tmp/key.pem
auth:
  type: password
  password: ${HY_PASSWORD}
EOF
exec hysteria server -c config.yaml
