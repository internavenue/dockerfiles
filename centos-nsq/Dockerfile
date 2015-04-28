FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum -y install tar

ADD https://github.com/bitly/nsq/releases/download/v0.3.5/nsq-0.3.5.linux-amd64.go1.4.2.tar.gz /var/tmp/
RUN \
  mkdir -p /var/tmp/nsq && \
  tar -xzf /var/tmp/nsq-0.3.5.linux-amd64.go1.4.2.tar.gz --strip=1 -C /var/tmp/nsq/ && \
  mv /var/tmp/nsq/bin/* /usr/local/sbin && \
  rm -rf /var/tmp/nsq*

RUN yum -y remove tar && yum clean all

COPY scripts /scripts
RUN chmod +x /scripts/start.sh

# Expose ports.
EXPOSE 4150 4151 4160 4161 4171 22

VOLUME ["/vagrant", "/data", "/var/log", "/run", "/etc/ssl/certs"]

# Kicking in
CMD ["/scripts/start.sh"]
