#!/bin/bash
shopt -s expand_aliases
source /home/dev/.aliases
acbuild begin ./alpine.aci
acbuild set-name natostanco/alpngxrkt
acbuild run -- /bin/sh -c "apk add --no-cache --update openssl nginx apr apr-util libjpeg-turbo icu pcre gnupg jq"
acbuild run -- wget `curl -s https://api.github.com/repos/natostanco/ngxpgs/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4` -O ngx.tar.gz
acbuild run -- /bin/sh -c "tar -zxf ngx.tar.gz && rm ngx.tar.gz && mv nginx /usr/sbin/nginx && mv libpng* /usr/lib && rm -rf /etc/nginx"
acbuild copy nginx /etc/nginx
acbuild run -- /bin/sh -c "NGXKEY=`curl -s http://172.16.28.1:2379/v2/keys/nginxconf | jq -r '.node.value'`"
acbuild run -- /bin/sh -c "find /etc/nginx -type f -name *.gpg | xargs -n1 gpg --batch --yes --passphrase ${NGXKEY}"
acbuild run -- /bin/sh -c "find /etc/nginx -type f -name *.gpg | xargs rm -rf"
acbuild run -- /bin/sh -c "apk del gnupg jq"

adduser -G www-data www-data -D
acbuild port add http tcp 80
acbuild set-exec -- /usr/sbin/nginx -g "daemon off;"
acbuild write --overwrite alpngxrkt.aci



