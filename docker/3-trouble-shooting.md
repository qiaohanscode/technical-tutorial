#### Connect to container by overriding the entrypoint
```
//connect to alpine linux
docker run --entrypoint /bin/sh -it <image>
```
For more information about connect to container with bash see [warp.docker-run-bash.override-entrypoint](https://www.warp.dev/terminus/docker-run-bash#override-entrypoint)