# DNS and SSL/TLS

## Explain what the 'traceroute' and 'dig' commands do. Compare and contrast.
[More on traceroute](https://www.youtube.com/watch?v=up3bcBLZS74&list=PL7zRJGi6nMRzg0LdsR7F3olyLGoBcIvvg&index=30)
[More on dig](https://www.digitalocean.com/community/tutorials/how-to-retrieve-dns-information-using-dig?utm_source=chatgpt.com)
`traceroute` is a command used in the command line that is used to show the route that is taken by data/packets as they travel across the internet to their destination. Running this command will tell you which servers were contacted and the number of hops it took to get to the destination. You can use this tool to track bottlenecks and figure why or where a server might be lagging.
`dig` is a command used in the command line that is used to query DNS servers and retrieve DNS information for a domain. Running this command will tell you things such as the IP address associated with a domain, the mail servers responsible for email delivery, and the name servers that manage the domain. You can use this tool to troubleshoot DNS issues, verify DNS records, and determine how a domain is being resolved by DNS.
Ultimately both `traceroute` and `dig` are network troubleshooting tools but they focus on different aspects of the communication process. `dig` helps determine how a domain is resolved(the translation of a domain name into a ip address) while `traceroute` is more ocncerned with how the packets/traffic travel across the network.

## [What are the 3 or 4 most common DNS records and what are their use cases?](https://support.dnsimple.com/articles/common-dns-records/) 
A Record -This is the most common DNS record. It resolves a domain name to an IPv4 address.
AAAA Record -Does the same as the A record however it resolves a domain name to an IPv6 address.
CNAME Record -This type of record resolves a domain/subdomain to another domain. Essentially an alias for another domain name.
MX Record - This record also known as "mail exchanger record" is used for email. It points tto the server where emails should be delivered for that doamin.


## [Give an overview of the steps in a TLS handshake.](https://www.youtube.com/watch?v=ZkL10eoG1PY)
#### Client Hello
The client initiates the connection by sending a list of supported TLS versions, cipher suites (encryption methods), and other connection information to the server.
#### Server Hello
The server responds by selecting the TLS version and cipher suite that will be used for the session.
#### Server Certificate
The server sends its SSL/TLS certificate to the client. The client uses this certificate to verify the server's identity and obtain the server's public key.
#### Key Exchange
The client and server exchange information that allows them to independently generate the same session keys without transmitting those keys directly over the network.
#### Session Key Generation
Both the client and server use the exchanged information to create matching symmetric session keys that will be used to encrypt and decrypt data during the session.
#### Handshake Verification
The client and server exchange "Finished" messages to confirm that they both generated the same session keys and that the handshake was not altered in transit.
#### Secure Communication Begins
Once the handshake is complete, the client and server can securely exchange encrypted application data using the session keys that were established during the handshake.

## [How does an SSL/TLS cert know what domain it belongs to?](https://www.youtube.com/watch?v=ZkL10eoG1PY)
The server sends its SSL/TLS certificate during the TLS handshake. The client then validates the certificate to ensure it is legitimate and uses the public key contained within the certificate. The certificate contains identifying information about the server, which allows the client to verify that it is connecting to the intended website.

## [What is a certificate authority?](https://www.youtube.com/watch?v=AB0VMbvEz7g)
A Certificate Authority (CA) is a trusted organization that issues SSL/TLS certificates. Browsers trust certificates issued by recognized CAs, which helps verify that a website is legitimate and allows secure HTTPS connections
---

# Load Balancers

## [How do application load balancers in GCP offload (decrypt) SSL? What part of the load balancer does this?](https://docs.cloud.google.com/load-balancing/docs/target-proxies)
In GCP, SSL/TLS offloading is performed by the Target HTTPS Proxy within the Application Load Balancer. This component is responsible for handling the TLS handshake with the client, using the configured SSL certificate and private key to decrypt incoming HTTPS traffic. Once the traffic has been decrypted, the load balancer can inspect the request and use URL map rules to route it to the appropriate backend service.

## [Are there use cases to have in-flight encryption from the backend service to the backend itself?](https://docs.cloud.google.com/load-balancing/docs/ssl-certificates/encryption-to-the-backends)
Yes. While the Application Load Balancer can terminate TLS and decrypt incoming HTTPS traffic, there are scenarios where keeping traffic encrypted all the way to the backend is useful and at times necessary. This is usually in the case where you need to meet compliance requirements, support end-to-end encryption, or provide additional protection for sensitive data while it is in transit.
---

# Cloud Domain/DNS

## [Can multiple domains end up pointing to the same LB?](https://docs.cloud.google.com/load-balancing/docs/url-map-concepts)
Yes, it is possible for multiple domains to point to the same Application Load Balancer. In this scenario, each domain resolves to the load balancer's IP address, and the load balancer uses host rules in the URL map to route requests to the appropriate backend service based on the domain that was requested.

## [In the context of Cloud DNS, what are zones?](https://docs.cloud.google.com/dns/docs/overview)
A zone is a container that stores the DNS records for a domain. The zone defines the portion of the DNS namespace that you manage and contains records such as A, AAAA, CNAME, and MX records that map domain names to resources and services.