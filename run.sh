#!/usr/bin/env bash
set -e

export FORWARDERS=${FORWARDERS:-8.8.8.8,8.8.4.4}
export OVERRIDES=$(cd /var/bind/overrides; for i in *; do echo -ne "$i,"; done | sed 's/,$//')

# collect and verify override zones
cd /var/bind/overrides
for zone in *.zone; do
  domain=${zone%.zone}
  /usr/sbin/named-checkzone -m fail -q ${domain} ${zone}
done

# generate named.conf
/etc/bind/generate_config.py > /etc/bind/named.conf

# check config is valid
/usr/sbin/named-checkconf /etc/bind/named.conf

# start named
exec /usr/sbin/named -c /etc/bind/named.conf -f
