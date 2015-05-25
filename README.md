# docker-jenkins
Containerized jenkins server

```
docker run -it --rm \
--env HTTPPORT=8282 \
--env AJP13PORT=-1 \
--publish 8080:8282 \
h0tbird/jenkins
```
