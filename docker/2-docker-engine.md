### Docker Engine
`Docker Engine` is an open source containerization technology for building and containerizing your applications. 
`Docker Engine` acts as a client-server application with:
- A server with a long-running daemon process `dockerd`
- APIs which specify interfaces that programs can use to talk to and instruct the Docker daemon
- A command line interface (CLI) client `docker`.

Details can be found [Dokcer Engine Overview](https://docs.docker.com/engine/).

### Uninstall old versions
1. Uninstall Docker Engine, CLI, containerd, and Docker Compose packages:
```
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```
2. Images, containers, volumes or custom configuration fes on your host aren't authomatically removed. To delete all 
images, containers and volumes:
```
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

### Install using apt repository
1. Set up Docker's `apt` repository.
```
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
```

2. Install Docker packages with latest version
```
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
3. verify the installation is sucessful by running the `hello-world` image:
```
sudo docker run hello-world
```

