# Robots.txt
rewrite ^/robots\.txt$ /index.php?robots=1 last;
# Add trailing slash to */wp-admin requests.
rewrite /wp-admin$ $scheme://$host$uri/ permanent;
# xml sitemaps
rewrite ^/sitemap(-+([a-zA-Z0-9_-]+))?\.xml$ "/index.php?xml_sitemap=params=$2" last;
rewrite ^/sitemap(-+([a-zA-Z0-9_-]+))?\.xml\.gz$ "/index.php?xml_sitemap=params=$2;zip=true" last;
rewrite ^/sitemap(-+([a-zA-Z0-9_-]+))?\.html$ "/index.php?xml_sitemap=params=$2;html=true" last;
rewrite ^/sitemap(-+([a-zA-Z0-9_-]+))?\.html.gz$ "/index.php?xml_sitemap=params=$2;html=true;zip=true" last;
rewrite ^/sitemap_index\.xml$ /index.php?sitemap=1 last;
rewrite ^/([^/]+?)-sitemap([0-9]+)?\.xml$ /index.php?sitemap=$1&sitemap_n=$2 last;
# Request Size
client_max_body_size 20M;
# files
add_header Cache-Control "public";
add_header 'Access-Control-Allow-Origin' '*';
expires 1314000s;
location ~* \.(ttf|otf|eot|woff|html)$ {
add_header Access-Control-Allow-Origin *;
}
location ~* /(?:uploads|files)/.*\.php$ {
deny all;
}
location /db-ips.txt {
deny all;
}
