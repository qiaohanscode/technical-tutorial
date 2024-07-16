### docker container run
create and run a new container from an image

Usage:
```
docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

Aliases:
```
docker run
```

Description:
The command `docker run` runs a command in a new container, pulling the image if needed and starting the container. 

Use `docker start` can restart a stopped container with all ins previous changes Use `docker ps -a` to view a list of 
all containers, including those are stopped.

Options:
- --entrypoint: overrides the default __ENTRYPOINT__ of the image