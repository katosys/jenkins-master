#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM centos:7
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Update the base image:
#------------------------------------------------------------------------------

RUN rpm --import http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7 && \
    yum update -y && yum clean all

#------------------------------------------------------------------------------
# Install libmesos:
#------------------------------------------------------------------------------

RUN yum install -y http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm \
    yum-utils subversion-libs apr-util && mkdir /tmp/mesos && cd /tmp/mesos && yumdownloader mesos && \
    rpm2cpio mesos*.rpm | cpio -idm && cp usr/lib/libmesos-*.so /usr/lib/ && \
    cd /usr/lib && ln -s libmesos-*.so libmesos.so && rm -rf /tmp/mesos && yum clean all

#------------------------------------------------------------------------------
# Install jenkins:
#------------------------------------------------------------------------------

RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key && \
    yum install -y java-1.7.0-openjdk-headless java-1.7.0-openjdk-devel wget && \
    wget -q -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && \
    yum install -y jenkins && yum clean all

#------------------------------------------------------------------------------
# Install plugins:
#------------------------------------------------------------------------------

RUN mkdir -p /var/lib/jenkins/plugins && cd /var/lib/jenkins/plugins && \
    wget -q http://updates.jenkins-ci.org/latest/mesos.hpi

#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Expose ports and entrypoint:
#------------------------------------------------------------------------------

ENTRYPOINT ["/init", "/usr/bin/java", "-DJENKINS_HOME=/var/lib/jenkins", "-jar /usr/lib/jenkins/jenkins.war"]
