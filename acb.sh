#!/bin/bash
shopt -s expand_aliases
#source ~/.aliases
alias acbuild='./acbuild'
alias sudo='sudo ' 
alias ae='sudo acbuild end'

acbuild --debug begin ./alpine.aci
acbuild --debug set-name natostanco/alpngxrkt
acbuild --debug run -- /bin/sh -c "apk --no-cache --update upgrade && apk add --no-cache openssl nginx apr apr-util libjpeg-turbo icu pcre gnupg jq"
acbuild --debug run -- wget `curl -s https://api.github.com/repos/natostanco/alpngxpgs/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4` -O ngx.tar.gz
acbuild --debug run -- /bin/sh -c "tar -zxf ngx.tar.gz && rm ngx.tar.gz && mv nginx /usr/sbin/nginx && mv libpng* /usr/lib && rm -rf /etc/nginx"
acbuild --debug run -- /bin/sh -c "apk del gnupg jq"
acbuild --debug run -- /bin/sh -c "mkdir /etc/nginx"
acbuild --debug mount add etc-nginx /etc/nginx

#adduser -G www-data www-data -D
acbuild --debug run -- /bin/sh -c "adduser -G www-data www-data -D"
acbuild --debug port add http tcp 80
acbuild --debug port add https tcp 443
 
acbuild --debug set-exec -- /usr/sbin/nginx
acbuild --debug write --overwrite alpngxrkt.aci



