#! /bin/bash
CA_DIR="${CA_DIR:=/etc/puppetlabs/puppetserver/ca-tls}"
CA_KEY:="${CA_KEY:=$CA_DIR/tls.key}"

# If the CA private key exists, Puppetserver won't start without a
# CRL/inventory/serial file. Initialize them here.
if [[ -f $CA_KEY ]]; then
  touch "${CA_DIR}/ca_crl.pem"
  touch "${CA_DIR}/inventory.txt"
  echo $(( $RANDOM * 50000 )) > "${CA_DIR}/serial"
fi

# Start up a Puppetserver foreground instance
/opt/puppetlabs/server/bin/puppetserver foreground
