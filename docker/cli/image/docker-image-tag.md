### docker image tag
create a tag __TARGET_IMAGE__ that refers to __SOURCE_IMAGE__

Usage: 
```
docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

Aliases:
```
docker tag
```

### Description
A full image name has the following format and components:

`[HOST[:PORT_NUMBER]/]PATH`
- `HOST`: the optional registry hostname dpecifies where the image is located. If not specified, the command uses 
Docker's public registry at `registry-1.docker.io` by default. Note that `docker.io` is the canonical reference for 
Docker's public registry.
- `PORT_NUMBER`: if a hostname is present, it may optionally be followed by a registry port number.
- `PATH`: the path consists of slash-separated components. Each component may contain lowercase letters, digits and 
separators. A separator is defined as a period, one or two underscores, or one or more hyphens. While some registers may 
support path with more than two slash-separated components, most registries only support two slash-separated components. 
For Docker's public, the path format is as follows:
  - `[NAMESPACE/]REPOSITORY`: the first, optional component is typically a user's or an organization's namespace. The 
  second, mandatory component is the repository name. When the namespace is not present, Docker uses `library` as the 
  default namespace.

`TAG`: after the image name, the optional `TAG` is a custom, human-readable manifest identifier that's typically a 
specific version or variant of an image. The tag must be valid ASCII and can contain lowercase and uppercase letters, 
digits, underscores, periods and hyphens (-). It can't start with a period or hyphen and must be no longer than 128 
characters. If not specified, the command uses `latest` by default.

### Examples
#### Tag an image referenced by ID
```
docker tag 0e5574283393 fedora/httpd:version1.0
```

#### Tag an image referenced by Name
```
docker tag httpd fedora/httpd:version1.0
```

#### Tag an image referenced by Name and Tag
```
docker tag httpd:test fedora/httpd:version1.0.test
```

#### Tag an image for aprivate registry
```
docker tag 0e5574283393 myregistryhost:5000/fedora/httpd:version1.0
```
  
