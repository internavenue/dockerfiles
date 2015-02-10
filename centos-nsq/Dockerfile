FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum -y install tar

RUN \
  mkdir -p /tmp/nsq && \
  wget https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.3.2.linux-amd64.go1.4.1.tar.gz -O - | tar -xvz --strip=1 -C /tmp/nsq && \
  mv /tmp/nsq/bin/* /usr/local/bin/ && \
  rm -rf /tmp/nsq

# We don't tar anymore.
RUN yum remove -y tar && \
  yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

# Expose ports.
EXPOSE 4150 4151 4160 4161 4171 22

# Expose our web root and log directories log.
VOLUME ["/vagrant", "/data", "/var/log", "/run"]

# Kicking in
CMD ["/scripts/start.sh"]
