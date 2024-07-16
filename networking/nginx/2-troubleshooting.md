#### Validate And Reload Nginx
```
docker exec nginx-base nginx -t
docker exec nginx-base nginx -s reload
```

### Appendix
[Nginx Configuration Example Github Repo](https://github.com/yeasy/docker-nginx/blob/master/nginx.default.conf)

[Using Nginx Docker Image](https://octopus.com/blog/using-nginx-docker-image)

[Comprehensive Guide For Configuring Nginx](https://dev.to/ritwikmath/nginx-reverse-proxy-in-localhost-and-docker-a-comprehensive-setup-guide-3d1o)

[Setup Nginx As Reverse Proxy With Docker Image](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Docker-Nginx-reverse-proxy-setup-example)
