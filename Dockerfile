FROM debian:bullseye

# Puppet version data from Makefile
ARG PUPPET_VERSION_MAJOR

RUN groupadd puppet -g 1001 && \
  useradd -r --comment "puppetserver" --home-dir /opt/puppetlabs/server/data/puppetserver --shell /usr/bin/nologin -u 1001 -g 1001 puppet

# 1. Install Puppetserver packages.
# 2. Create /etc/puppetlabs/puppetserver/ca-tls where we will use for a bind mount containing TLS certs.
# 3. Configure Puppet to use the CA cert/key from the location in #2.

RUN apt update && apt install -y curl
RUN curl -Lo puppetrelease.deb http://apt.puppetlabs.com/puppet${PUPPET_VERSION_MAJOR}-release-bullseye.deb
RUN dpkg -i puppetrelease.deb && rm puppetrelease.deb
RUN apt update && apt -y install puppetserver

RUN mkdir -p /etc/puppetlabs/puppetserver/ca-tls && \
  chown 1001:1001 /etc/puppetlabs/puppetserver/ca-tls && \
  mkdir -p /opt/puppetlabs/server/data/puppetserver/dropsonde && \
  chown -R 1001:1001 /opt/puppetlabs/server/data && \
  /opt/puppetlabs/puppet/bin/puppet config set --section server cacert /etc/puppetlabs/puppetserver/ca-tls/tls.crt && \
  /opt/puppetlabs/puppet/bin/puppet config set --section server cakey /etc/puppetlabs/puppetserver/ca-tls/tls.key

USER 1001:1001
EXPOSE 8140

CMD ["/opt/puppetlabs/server/bin/puppetserver", "foreground"]
