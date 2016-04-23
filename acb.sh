#!/bin/bash
shopt -s expand_aliases
#source ~/.aliases
alias acbuild='/home/save/acbuild'
alias sudo='sudo ' 
alias ae='sudo acbuild end'

apt-get update && apt-get install wget curl modprobe systemd-container -y -q

acbuild begin /home/save/alpine.aci
acbuild set-name natostanco/alpngxrkt
acbuild run -- /bin/sh -c "apk --no-cache --update upgrade && apk add --no-cache openssl nginx apr apr-util libjpeg-turbo icu pcre gnupg jq"
acbuild run -- wget `curl -s https://api.github.com/repos/natostanco/alpngxpgs/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4` -O ngx.tar.gz
acbuild run -- /bin/sh -c "tar -zxf ngx.tar.gz && rm ngx.tar.gz && mv nginx /usr/sbin/nginx && mv libpng* /usr/lib && rm -rf /etc/nginx"
acbuild run -- /bin/sh -c "apk del gnupg jq"
acbuild run -- /bin/sh -c "mkdir /etc/nginx"
acbuild mount add etc-nginx /etc/nginx

#adduser -G www-data www-data -D
acbuild run -- /bin/sh -c "adduser -G www-data www-data -D"
acbuild port add http tcp 80
acbuild port add https tcp 443
 
acbuild set-exec -- /usr/sbin/nginx
acbuild write --overwrite /home/save/alpngxrkt.aci



