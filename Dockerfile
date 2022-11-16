FROM debian:bullseye

# Puppet version data from Makefile
ARG PUPPET_VERSION_MAJOR

# 1. Install Puppetserver packages.
# 2. Create /etc/puppetlabs/puppetserver/ca-tls where we will use for a bind mount containing TLS certs.
# 3. Configure Puppet to use the CA cert/key from the location in #2.
RUN apt-get update && apt-get install wget -y && \
  wget http://apt.puppetlabs.com/puppet${PUPPET_VERSION_MAJOR}-release-bullseye.deb && \
  dpkg -i puppet${PUPPET_VERSION_MAJOR}-release-bullseye.deb && \
  apt-get update && apt-get install sudo vim curl git puppetserver -y && \
  rm puppet${PUPPET_VERSION_MAJOR}-release-bullseye.deb && \
  mkdir /etc/puppetlabs/puppetserver/ca-tls && \
  /opt/puppetlabs/puppet/bin/puppet config set --section server cacert /etc/puppetlabs/puppetserver/ca-tls/tls.crt && \
  /opt/puppetlabs/puppet/bin/puppet config set --section server cakey /etc/puppetlabs/puppetserver/ca-tls/tls.key

EXPOSE 8140

# Do we need to start a puppetserver foreground instance when running the container?
# USER puppet
# CMD ["/opt/puppetlabs/server/bin/puppetserver", "foreground"]