FROM internavenue/centos-base

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN curl -o /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

RUN yum -y install \
  java-1.7.0-openjdk \
  jenkins

# Clean up YUM when done.
RUN yum clean all

ENV JENKINS_HOME="/var/lib/jenkins"
WORKDIR $JENKINS_HOME/plugins

RUN curl -o git.hpi https://updates.jenkins-ci.org/latest/git.hpi
RUN curl -o git-client.hpi https://updates.jenkins-ci.org/latest/git-client.hpi
RUN curl -o workflow-support.hpi https://updates.jenkins-ci.org/latest/workflow-support.hpi
RUN curl -o workflow-step-api.hpi https://updates.jenkins-ci.org/latest/workflow-step-api.hpi
RUN curl -o workflow-scm-step.hpi https://updates.jenkins-ci.org/latest/workflow-scm-step.hpi
RUN curl -o workflow-job.hpi https://updates.jenkins-ci.org/latest/workflow-job.hpi
RUN curl -o workflow-durable-task-step.hpi https://updates.jenkins-ci.org/latest/workflow-durable-task-step.hpi
RUN curl -o workflow-cps.hpi https://updates.jenkins-ci.org/latest/workflow-cps.hpi
RUN curl -o workflow-cps-global-lib.hpi https://updates.jenkins-ci.org/latest/workflow-cps-global-lib.hpi
RUN curl -o workflow-basic-steps.hpi https://updates.jenkins-ci.org/latest/workflow-basic-steps.hpi
RUN curl -o workflow-api.hpi https://updates.jenkins-ci.org/latest/workflow-api.hpi
RUN curl -o workflow-aggregator.hpi https://updates.jenkins-ci.org/latest/workflow-aggregator.hpi


EXPOSE 8080 22

# Expose our web root and log directories log.
VOLUME ["/var/lib/jenkins", "/var/log"]

# Kicking in
CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]

