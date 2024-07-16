### docker image build
Build an image from a Dockerfile

Usage:
```
docker image build [OPTIONS] PATH | URL | -
```
Aliases:
`docker build` `docker buildx build` `docker builder build`

### Description
The `docker build` command builds Docker images from a __Dockerfile__ and a __"context"__. A build's context is the set 
of files located in the specified `PATH` or `URL`. The build process can refer to any of the files in the context.

The `URL` parameter can refer to three kinds of resources:
- Gir reposiories
- pre-packaged tarball contexts
- plain text files

For details see [docker image build](https://docs.docker.com/reference/cli/docker/image/build/#git-repositories).

### Options
- -f, --file: Name of the Dockerfile (default is `PATH/Dockerfile`)
- -t, --tag: Named and optionally a tag in the `name:tag` format
For more available options see [docker-image-build/options](https://docs.docker.com/reference/cli/docker/image/build/#options).

### Examples
#### Build with PATH
```
docker build .
```

#### Build with URL
```
docker build github.com/creack/docker-firefox
```

#### Build with -
````
docker build - < Dockerfile
````

#### Tag an image (-t, --tag)
```
docker build -t vieux/apache:2.0 .
```

#### Specify a Dockerfile (-f --file)
```
docker build -f Dockerfile.debug .
```

#### Set build-time variables (--build-arg)
The `ARG` instruction lets Dockerfile authors define values that users can set at build-time using the `--build-arg` flag:

```
docker build --build-arg HTTP_PROXY=http://10.20.30.2:1234 --build-arg FTP_PROXY=http://40.50.60.5:4567 .
```
This flag allows you to pass the build-time variables that are accessed like regular environment variables in the `RUN`
instruction of the Dockerfile. These values don't persist in the intermediate or final images like `ENV` values do. 

For detailed information on using `ARG` and `ENV` instructions, see [Dockerfile reference](https://docs.docker.com/reference/dockerfile/).

#### Specifying target build stage (--target)
When building a Dockerfile with multiple build stages, you can use the `--target` option to specify an intermediate 
build stage by name as a final stage for the resulting image. The daemon skips commands after the target stage.
```
FROM debian AS build-env
# ...

FROM alpine AS production-env
# ...
```

```
docker build -t mybuildimage --target build-env .
```