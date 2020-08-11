#!/bin/bash
echo starting tests
while true
do
   # TEST 1.1
   echo TEST 1.1 Linux to Linux DNS
   NGINX_IP=$(dig +short nginx.default.svc.cluster.local)
   if [ -z "$NGINX_IP" ]; then RESULT="FAIL"; else RESULT="SUCCESS"; fi
   echo '{"test": {"id": "1.1", "name": "Linux to Linux DNS", "result":  "'$RESULT'"}}' | jq .
   
   # TEST 1.2
   echo TEST 1.2 Linux to Linux VIP and Overlay
   NGINX_HTTP=$(curl -sI nginx.default.svc.cluster.local | grep HTTP)
   if [ -z "$NGINX_HTTP" ]; then RESULT="FAIL"; else RESULT="SUCCESS"; fi
   echo '{"test": {"id": "1.2", "name": "Linux to Linux VIP and Overlay", "result":  "'$RESULT'"}}' | jq .

   # TEST 2.1
   echo TEST 2.1 Linux to Windows DNS
   IIS_IP=$(dig +short iis.default.svc.cluster.local)
   if [ -z "$IIS_IP" ]; then RESULT="FAIL"; else RESULT="SUCCESS"; fi
   echo '{"test": {"id": "2.1", "name": "Linux to Windows DNS", "result":  "'$RESULT'"}}' | jq .

   # TEST 2.2
   echo TEST 2.2 Linux to Windows VIP and Overlay
   IIS_HTTP=$(curl -sI iis.default.svc.cluster.local | grep HTTP)
   if [ -z "$IIS_HTTP" ]; then RESULT="FAIL"; else RESULT="SUCCESS"; fi
   echo '{"test": {"id": "2.2", "name": "Linux to Windows VIP and Overlay", "result":  "'$RESULT'"}}' | jq .

   sleep 30
done
EOF

