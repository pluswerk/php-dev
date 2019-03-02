# Nginx Reverse Proxy

This project relies on [pluswerk/docker-global](https://github.com/pluswerk/docker-global).

Below is a clarification of the VIRTUAL_* variable.

## VIRTUAL_HOST: Virtual host (your domain)

Through the VIRTUAL_HOST variable the nginx reverse proxy knows which domain belongs to which Docker container.

##### Variant A

You can specify this domain directly without regular expressions. See variant A.

##### Regular expression information

We do recommend the use of regular expressions.

The regular expression starts with a ~ and ends with a $$. So do not wonder why it's two dollars.

If you have a DNS in between, you have the option to use multiple domains.
For example, domain.vm & domain.vmd with different IP addresses.
One goes to the local host, the other into a virtual machine. The possibilities are endless.

##### Variant B

For example, if you have a TYPO3 website, you could use variant B.
With this you can use all subdomains if you have several websites in the project.

##### Variant C + D

But what if you have two Docker containers with the same domain?

For example, you have a Symfony website domain.vm, but also a phpbb forum on forum.domain.vm.
This means you create two directories with a docker-compose.yml for each project.

You use variant C for the Symfony website, because domain.vm and www.domain.vm should be used.

For the forum you use variant D, so you have forum.domain.vm.

Finally, I can say that variant C or D is the better choice in most cases.
But since every system is different, you can of course do what suits you.

File docker-compose.yml:

```yaml
services:
  web:
    environment:
      # A: domain.vm
      - VIRTUAL_HOST=domain.vm

      # B: domain.vm, *.domain.vm, domain.vmd, *.domain.vmd
      - VIRTUAL_HOST=~^(.+\.)?domain\.(vm|vmd)$$

      # C: domain.vm, www.domain.vm, domain.vmd, www.domain.vmd
      #- VIRTUAL_HOST=~^(www\.)?domain\.(vm|vmd)$$

      # D: subdomain.domain.vm, subdomain.domain.vmd
      #- VIRTUAL_HOST=~^subdomain\.domain\.(vm|vmd)$$
```

## VIRTUAL_PROTO & VIRTUAL_PORT: SSL

Virtual protocol (VIRTUAL_PROTO) and virtual port (VIRTUAL_PORT) are only there to regulate the communication between nginx-reverse-proxy and the website.

Not for communication between web browser and nginx reverse proxy!

### HTTP: default communication

Web-browser <-(http/https)-> nginx-reverse-proxy (docker-global) <-(http)-> Website (php-dev)

The communication between the nginx-reverse-proxy usually runs completely through http.
Although it looks from the outside, as if you have SSL configured.
But behind it the communication runs over http.

You do not have to configure anything for that.

### HTTPS: SSL between nginx-reverse-proxy & website

Web-browser <-(http/https)-> nginx-reverse-proxy (docker-global) <-(https)-> Website (php-dev)

If a website requires https, it can happen that endless redirects are made.

That's why you have to set the virtual protocol to https and change the virtual port to 443.

The communication between nginx-reverse-proxy and the website is now always via https.
No matter if you surf from the web browser via http or https.


File docker-compose.yml:

```yaml
services:
  web:
    environment:
      - VIRTUAL_PROTO=https
      - VIRTUAL_PORT=443
```
