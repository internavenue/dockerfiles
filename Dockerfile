FROM tianon/centos:6.5
MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install EPEL repo.
RUN yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# Install Puppet repo.
RUN yum -y install http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm

# Install base stuff.
RUN yum -y install \
  bash-completion \
  curl \
  pwgen \
  mc \
  openssh-client \
  openssh-server \
  puppet \
  vim-enhanced \
  tmux \
  screen \
  syslog-ng \
  syslog-ng-libdbi \
  wget \
  yum-plugin-fastestmirror 

# Clean up YUM when done.
RUN yum clean all

EXPOSE 22

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

# Change the root password. The password should be changed and/or managed via Puppet.
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:Ch4ng3M3' | chpasswd

# Expose our web root and log directories log.
VOLUME ["/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

