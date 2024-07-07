## NGINX
A http server, reverse proxy server and a mail proxy server.

Details found under [Beginners Guide](https://nginx.org/en/docs/beginners_guide.html).

### Configuration
Default name is `ngnix.conf` which locates `/usr/local/nginx/conf`, `/etc/nginx` 
or `/usr/local/etc/nginx`

### Serving Static Content With Reverse Proxy
Match rules:
1) the matching with longest prefix will be remembered
2) if there are multi regex, the first matching regex will be used.
3) if no regex matchs, the location with longest prefix will be used.
```
http {
    server { //server block
        location / {
            proxy_pass http://localhost:8080; //directive proxy_pass
        }
        
        location /file { //location block
            root /data/www;
        }
        
        location /images/ {
            root /data; // matched URL will be preceeded with path specified 
                        // by the directive root
        }
    }
    
    server {
        listen 8080; //directive listen
        server_name  example.org  www.example.org; // directive server_name, checked by
                                                   // Header HOST
        root /data/up1; //directive root, specified path will be used if 
                        //selected block does not specify root directive

        location / {
        }
    }
}
```

### Wildcard names
A wildcard name may contain asterisk only on the name's start or end,
and only on a dot border.
```
*.example.org
mail.*
```
The names `www.*.example.org` and `w*.example.org` are invalid. These names can be specified
using regex `~^www\..+\.example\.org$` and `~^w.*\.example\.org$`.

A special wildcard name in the form `.example.org` can be used to match both the 
exact name `example.org` and the wilcard name `*.example.org`.

### Miscellaneous names
- If a Requests without the `Host` header filed should be processed in a server block 
which is not default block, an empty name should be specified.
```
server {
    listen       80;
    server_name  example.org  www.example.org  "";
    ...
}
```

- If no server name is defined in a server block nginx uses (up version 0.8.48) the
hostnames as the server name.
- In catch-all server the name `_` can be used
```
server {
    listen       80  default_server;
    server_name  _;
    return       444;
}
```

