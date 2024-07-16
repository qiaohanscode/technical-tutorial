### docker container cp
Copy files/folders between a container and local file system

Usage: 
```
docker container cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH
```

Alias:
```
docker cp
```

Example:
```
docker cp ekl-frontend-dev:/etc/nginx/conf.d/default.conf ~/temp/1/default.conf
```
