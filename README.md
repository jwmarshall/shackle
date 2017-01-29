# Shackle

Shackle is a Bind DNS server configured to overlay custom DNS results using [response policy zones](https://dnsrpz.info/). Simply put, you can serve custom DNS records for any domain, overriding only those hostnames you specify while still resolving all other hosts from the configured forwarders.

## Use Cases

- Blacklisting hosts, or even full domains using wildcards.
- An alternative to managing `/etc/hosts` across a large number of machines.
- Possibly facilitate MITM style attacks against unsuspecting users.

## Usage

Run the shackle docker image.

`docker run -d -p 53:53/udp --name shackle shackle`

Use shackle with custom forwarders.

`docker run -d -p 53:53/udp -e FORWARDERS=192.168.1.1,192.168.2.1,192.168.3.1 --name shackle shackle`

Of course you probably want to add your own custom domains to the server.

`docker run -d -p 53:53/udp -v /your/overrides:/var/bind/overrides:ro --name shackle shackle`

Alternatively, build your own Docker image with the zones in the `overrides` directory in this repo.

`docker build -t shackle .`
