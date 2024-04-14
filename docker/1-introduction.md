### Docker architecutre
Docker uses a client-server architecture. The `Docker client` talks to the `Docker daemon`, which does the heavy lifting
of building, running and distributing your Docker containers. The `Docker client` and `daemon` can run on the same 
system, or you can connect a `Docker client` to a remote `Docker daemon`. The `Docker client`and `daemon` communicate 
using a __REST API__, over __UNIX sockets__ or a network interface.  

Details about Docker can be found [Docker Overview](https://docs.docker.com/get-started/overview/).

![docker-architecture.jpg](images%2Fdocker-architecture.jpg)

### Docker daemon
The `Docker daemon` (`dockerd`) listens for __Docker API requests__ and manages __Docker objects__ such as images, 
containers, networks and volumes. A daemon can also communicate with other daemons to manage Docker Services.

### The Docker client
The Docker client (`docker`) is the primary way that many Docker users interact with Docker. When you use commands such 
as `docker run`, the client sends these commands to `dockerd`, shich carries them out.

### Docker Desktop
Docker Desktop is an easy-to-install application for Mac, Windows or Linux, which includes the `Docker daemon`, 
`Docker client`, `Docker Compose`, `Docker Content Trust`, `Kubernetes` and `Credential Helper`.

### Docker registries
A __Docker registry__ stores Docker images. __Docker Hub__ is a public registry that every one can use. Docker looks 
for images on __Docker Hub__ by default.

When you use `docker pull`, `docker run` or `docker push` commands, Docker pulls the required images from your configured
registry or pushes your image to your configured registry.
