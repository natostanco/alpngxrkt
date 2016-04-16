set $no_cache 0;
# POST requests and urls with a query string should always go to PHP
if ($request_method = POST) {
set $no_cache 1;
}
if ($query_string != "") {
set $no_cache 1;
}
# Don't cache uris containing the following segments
if ($request_uri ~* "(/wp-admin/|/xmlrpc.php|/wp-(app|cron|login|register|mail).php|wp-.*.php|/feed/|index.php|wp-comments-popup.php|wp-links-opml.php|wp-locations.php|sitemap(_index)?.xml|[a-z0-9_-]+-sitemap([0-9]+)?.xml)") {
set $no_cache 1;
}
# Don't use the cache for logged in users or recent commenters
if ($http_cookie ~* "comment_author|wordpress_[a-f0-9]+|wp-postpass|wordpress_no_cache|wordpress_logged_in") {
set $no_cache 1;
}
# Don't cache prx script
if ($request_uri ~* "(/prx/|/mda/test.php|/wid.php)") {
set $no_cache 1;
}
# Don't cache template website
if ($http_host ~* "testnow") {
set $no_cache 1;
}
# Bypass cache if flag is set
fastcgi_no_cache $no_cache;
fastcgi_cache_bypass $no_cache;
fastcgi_cache microcache;
fastcgi_cache_valid 200 301 302 10m;
fastcgi_pass_header Set-Cookie;
fastcgi_pass_header Cookie;
fastcgi_ignore_headers Cache-Control Expires Set-Cookie;
fastcgi_keep_conn on;
try_files $uri /index.php;
fastcgi_split_path_info ^(.+?\.(?:php|phar))(/.*)$;
include /etc/nginx/fastcgi_params;
fastcgi_index index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
fastcgi_param SERVER_NAME $http_host;

fastcgi_buffer_size 128k;
fastcgi_buffers 256 16k;
fastcgi_busy_buffers_size 256k;
fastcgi_temp_file_write_size 256k;
