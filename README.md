# docker-jenkins
Containerized jenkins server

This will run an eager Jenkins master.
It will provision slaves in a Mesos cluster.
The Mesos cluster is discovered using a Zookeeper cluster.
Jenkins will register as a Mesos framework if the job queue is not empty.

```
docker run -it --rm \
--env JENKINS_HTTPPORT=8282 \
--env JENKINS_AJP13PORT=-1 \
--env JENKINS_SYSTEM_MESSAGE=jenkins-qa \
--env JENKINS_NODE_PROVISIONER_MARGIN=50 \
--env JENKINS_NODE_PROVISIONER_MARGIN0=0.85 \
--env MESOS_MASTER=zk://core-1:2181,core-3:2181,core-9:2181/mesos \
--env MESOS_FRAMEWORK_NAME=jenkins-framework \
--env MESOS_CHECKPOINT=true \
--env MESOS_ON_DEMAND_REGISTRATION=true \
--publish 8080:8282 \
h0tbird/jenkins
```
