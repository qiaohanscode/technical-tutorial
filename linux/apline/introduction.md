## Alpine
A minimal Docker image based on Alpine Linux with a complete package index and only 5 MB in size.

For details see [dockehub.alpine](https://hub.docker.com/_/alpine)

### test apline linux with docker
```
docker run --entrypoint /bin/sh -it alpine:latest
```

### update the repository
```
apk update
```

### search jdk
```
apk search openjdk21
```

