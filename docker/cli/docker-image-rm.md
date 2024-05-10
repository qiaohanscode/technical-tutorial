### docker image rm
remove one or more images

Usage:
```
docker image rm [OPTIONS] IMAGE [IMAGE...]
```

Aliases:
`docker image remove` `docker rmi`

### Description
removes (and un-tags) one or more images from the host node. If an image has multiple tags, using this command with the 
tag as parameter only removes the tag. If the tag is the only one for the image, both the image and the tag are removed.

### Options
- -f, --force: force removal of the image