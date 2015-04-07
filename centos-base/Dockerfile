FROM centos:centos7
MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Create and configure Vagrant user
RUN useradd --create-home -G wheel -s/bin/bash vagrant
WORKDIR /home/vagrant

# Install EPEL repo.
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
# Install Puppet repo.
RUN yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

RUN yum -y upgrade

# Install base stuff.
RUN yum -y install \
  bash-completion \
  curl \
  pwgen \
  mc \
  openssh-clients \
  openssh-server \
  puppet \
  vim-enhanced \
  tmux \
  screen \
  sudo \
  syslog-ng \
  syslog-ng-libdbi \
  yum-plugin-fastestmirror 

# Clean up YUM when done.
RUN yum -í upgrade

# Clean up YUM when done.
RUN yum clean all

# Configure SSH access for Vagrant
RUN mkdir -p /home/vagrant/.ssh && \
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
  chown -R vagrant: /home/vagrant/.ssh && \
  chmod 600 /home/vagrant/.ssh/authorized_keys && \
  echo -n 'vagrant:vagrant' | chpasswd

# Enable passwordless sudo for users under the "sudo" group
#RUN sed -i.bkp -e \
#  's/%wheel\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%wheel ALL=NOPASSWD:ALL/g' \
#  /etc/sudoers

EXPOSE 22

RUN mkdir /vagrant
ADD etc/sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run
RUN echo "UseDNS no" >> /etc/ssh/sshd_config
RUN sed -i 's/UsePrivilegeSeparation sandbox/UsePrivilegeSeparation no/' /etc/ssh/sshd_config

# Change the root password. The password should be changed and/or managed via Puppet.
RUN echo 'root:Ch4ng3M3' | chpasswd

# Expose our web root and log directories log.
VOLUME ["/vagrant", "/var/log", "/run"]

# Kicking in
CMD ["/scripts/start.sh"]
