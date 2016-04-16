# BEGIN Better WP Security
    location ~ /\.ht { deny all; }
    location ~ wp-config.php { deny all; }
    location ~ readme.html { deny all; }
    location ~ readme.txt { deny all; }
    location ~ /install.php { deny all; }
    set $susquery 0;
    set $rule_2 0;
    set $rule_3 0;
    rewrite ^wp-includes/(.*).php /not_found last;
    rewrite ^/wp-admin/includes(.*)$ /not_found last;
    if ($request_method ~* "^(TRACE|DELETE|TRACK)"){ return 403; }
    location /wp-comments-post.php {
        valid_referers jetpack.wordpress.com/jetpack-comment/ *.unto.re;
        set $rule_0 0;
        if ($request_method ~ "POST"){ set $rule_0 1$rule_0; }
        if ($invalid_referer) { set $rule_0 2$rule_0; }
        if ($http_user_agent ~ "^$"){ set $rule_0 3$rule_0; }
        if ($rule_0 = "3210") { return 403; }
    }    if ($args ~* "\.\./") { set $susquery 1; }
    if ($args ~* ".(bash|git|hg|log|svn|swp|cvs)") { set $susquery 1; }
    if ($args ~* "etc/passwd") { set $susquery 1; }
    if ($args ~* "boot.ini") { set $susquery 1; }
    if ($args ~* "ftp:") { set $susquery 1; }
    if ($args ~* "http:") { set $susquery 1; }
    if ($args ~* "(<|%3C).*script.*(>|%3E)") { set $susquery 1; }
    if ($args ~* "mosConfig_[a-zA-Z_]{1,21}(=|%3D)") { set $susquery 1; }
    if ($args ~* "base64_encode") { set $susquery 1; }
    if ($args ~* "(%24&x)") { set $susquery 1; }
    if ($args ~* "(\[|\]|\(|\)|<|>|ê|\"|;|\?|\*|=$)"){ set $susquery 1; }
    if ($args ~* "(&#x22;|&#x27;|&#x3C;|&#x3E;|&#x5C;|&#x7B;|&#x7C;|%24&x)"){ set $susquery 1; }
    if ($args ~* "(127.0)") { set $susquery 1; }
    if ($args ~* "(%0|%A|%B|%C|%D|%E|%F)") { set $susquery 1; }
    if ($args ~* "(globals|encode|localhost|loopback)") { set $susquery 1; }
    if ($args ~* "(request|select|insert|concat|union|declare)") { set $susquery 1; }
    if ($http_cookie !~* "wordpress_logged_in_" ) {
        set $susquery 2$susquery;
        set $rule_2 1;
        set $rule_3 1;
    }
    if ($args !~ "^loggedout=true") { set $susquery 3$susquery; }
    if ($susquery = 4321) { return 403; }
    rewrite ^/login/?$ /wp-login.php?zchjd4xu2daooi1mhshd5 redirect;
    if ($rule_2 = 1) { rewrite ^/admin/?$ /wp-login.php?zchjd4xu2daooi1mhshd5&redirect_to=/wp-admin/ redirect; }
    if ($rule_2 = 0) { rewrite ^/admin/?$ /wp-admin/?zchjd4xu2daooi1mhshd5 redirect; }
    rewrite ^/register/?$ /wp-login.php?zchjd4xu2daooi1mhshd5&action=register redirect;
    if ($uri !~ "^(.*)admin-ajax.php") { set $rule_3 2$rule_3; }
    if ($http_referer !~* wp-admin ) { set $rule_3 3$rule_3; }
    if ($http_referer !~* wp-login.php ) { set $rule_3 4$rule_3; }
    if ($http_referer !~* login ) { set $rule_3 5$rule_3; }
    if ($http_referer !~* admin ) { set $rule_3 6$rule_3; }
    if ($http_referer !~* register ) { set $rule_3 7$rule_3; }
    if ($args !~ "^action=logout") { set $rule_3 8$rule_3; }
    if ($args !~ "^zchjd4xu2daooi1mhshd5") { set $rule_3 9$rule_3; }
    if ($args !~ "^action=rp") { set $rule_3 0$rule_3; }
    if ($args !~ "^action=register") { set $rule_3 a$rule_3; }
    if ($args !~ "^action=postpass") { set $rule_3 b$rule_3; }
    if ($rule_3 = ba0987654321) {
        rewrite ^(.*/)?wp-login.php /not_found redirect;
        rewrite ^/wp-admin(.*)$ /not_found redirect;
    }
# END Better WP Security
