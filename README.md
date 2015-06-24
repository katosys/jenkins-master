# docker-jenkins
Containerized jenkins server

```
docker run -it --rm \
--env HTTPPORT=8282 \
--env AJP13PORT=-1 \
--env JENKINS_SYSTEM_MESSAGE=jenkins-qa \
--env MESOS_MASTER=zk://core-1:2181,core-3:2181,core-9:2181/mesos \
--env MESOS_FRAMEWORK_NAME=jenkins-framework \
--env MESOS_CHECKPOINT=true \
--env MESOS_ON_DEMAND_REGISTRATION=true \
--publish 8080:8282 \
h0tbird/jenkins
```
