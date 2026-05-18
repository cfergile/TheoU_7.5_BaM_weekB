# Q & A

## Load Balancers

### [How does load balancing contribute to Fault tolerance? What about high availability?](https://docs.cloud.google.com/load-balancing/docs/load-balancing-overview)
- Load balancers when configured effectively will have health checks that can monitor the health of vms and redirect traffic to a healthy vm in the case of the load balancer detecting a failed one. This aspect is crucial for fault tolerance insuring that no one vm's capacity is overloaded. Load balancers are excellent at distributing traffic across multiple instances, proving itself as a vital component of a high availability infrastructure.

### [Do global load balancers decrease latency for end users? Why or why not?](https://docs.cloud.google.com/load-balancing/docs/load-balancing-overview)
- Global load blancers can decrease latency for end users due to the ability to optimize the trafficing to the best geographical location in attempt to decrease the number of hops to as few as possible. Simply put becuase the balancer can distribute across a number of regions it can place the content most near the end user.

### [What are LB health checks for? Do we always need them? Is a LB different from a reverse proxy?](https://docs.cloud.google.com/load-balancing/docs/health-check-concepts)
- Load Balancer health checks determine whether or not backend servers are healthy enough to receive traffic. Health checks are not a mandatory implementation and in some cases may not be necessary. If infrastructure is simple, temporary, and non-critical, a health check may not be needed. In most cases however, health checks are vital and I would say it is best practice to implement one in your infrastructure. n a sense, health checks provide load balancers with some of the sophistication and granularity that reverse proxies use when monitoring backend traffic and server availability.

- A load balancer and a reverse proxy are different, however they have a lot of overlap. A reverse proxy sits in front of backend VMs handling incoming traffic forwarding them to the appropriate server. keeping the ip addresses of the servers hidden ensuring they are not revealed to the clients. A reverse proxy also acts as a middleman routing traffic based on content and applying security rules. Its also provides caching which helps in terms of latency. So although a reverse proxy is not a load balancer itself, load balancing is one of the mnay features that a reverse proxy can perform.

### [What are LB routing rules and URL maps for? Give an example or two of them in use.](https://docs.cloud.google.com/load-balancing/docs/url-map-concepts)
- LB routing rules and URL maps essentially seperate and delegate the incoming traffic and guide to their best destination. Otherwise all traffic would be sent to the same backend server without the load balancer first inspecting URL paths, hostnames, headers, and protocols.

- For example you may have a backend several backend services for speacialized or specific type of content/traffic: (ex. Authentication service, Payment service, Image service). In this case the URL path (/auth/* , /payments/* , /image/*) will determine the destination of the traffic.

### [Explain what an anycast IP address is used for in the context of a global load balancer.](https://docs.cloud.google.com/load-balancing/docs/https)
- An anycast IP address serves as the frontend for all your backend instances in regions all over the world. This allows for cross-region load-balancing and also allow for multi-region failover ensuring that your availabilty is robust. Because of this feature, content can be made readily available in edge loactions, reducing latency since these multiple edge loacations share the same IP address.

## Cloud Armor

### [What does cloud armor offer?](https://docs.cloud.google.com/armor/docs/cloud-armor-overview) 
 - Cloud Armor is a security service primarily used in tandem with GCP load balancers. This service helps defends from malicious traffic and unwanted/spam request.

### [Why is it used in the first place?](https://docs.cloud.google.com/armor/docs/cloud-armor-overview)
- It provides DDoS protection, WAF capabilites, threat mitigation, and protects internet-facing applications.

### [What layer in the OSI model does it operate at? Why is this important and how is this firewall different from VPC firewall rules?](https://docs.cloud.google.com/armor/docs/cloud-armor-overview)
- Cloud Armor Operates at Layer 7/application layer.


### [What are rate based rules for?](https://docs.cloud.google.com/armor/docs/rate-limiting-overview)
- Rate based rules protect your applications from (typically malicious)large volume request that would otherwise flood your instances and block access for legitiamte client request.

### [What is reCAPTCHA and how does it relate to this service?](https://docs.cloud.google.com/recaptcha/docs/overview)
- reCAPTCHA is part of Google Cloud Fraud Defense and contributes by determining whether a request is coming from a human or from an automated bot. Cloud Armor can integrate with reCAPTCHA in order to idetify and block mailicious trafic, bot activity, or any other form of suspicous behavior before it reaches the backend services.

## Cloud CDN

### [What are POPs used for?](https://docs.cloud.google.com/cdn/docs/overview)
POPs (Points of Presence) are edge locations used to cache content closer to the client improving latency and reducing the hops necessary to retreieve the content from the original server.

### [What kind of files are served with Cloud CDN?](https://docs.cloud.google.com/cdn/docs/caching)
The type of file that are typically served with Cloud CDN are static or cacheable content such as videos, images, CSS, and javascript files. Cloud CDN does not determine cacheable content based only on file extensions. It looks at the content's MIME(Multipurpose Internet Mail Extension) type and HTTP cache headers. Content such as HTML and JSON can be served through CDN but are not cached by default unless explicitily configured in the cahce-control header.

### [What services can be used with cloud CDN for the source of content(the origin)?](https://docs.cloud.google.com/cdn/docs/setting-up-cdn-with-mig) 
Services that can be used with Cloud CDN are backend instances, managed instance groups, and backend buckets.

### [Does Cloud CDN help protect against any types of malicious actors or cyberattacks? Explain.](https://docs.cloud.google.com/cdn/docs/overview) 
Cloud CDN has Cloud Armor integration with Edge security policies, and backended security policies.

### [Should an enterprise always use cloud CDN? Why or why not?](https://docs.cloud.google.com/cdn/docs/best-practices) 
No not necessarily. While it may sound like an advantageous feature and in most cases it is, cloud cdn can be either unnecessary or to the architectures functional detriment. Applications that have a lot of cahcable content and a necessity for global distribution would greatly benefit from CDN. On the contrary applications that have a lot of dynamic or are prone to cache issues, would probably find it best to avoid CDN.

### [What is TTL and how does it control content “freshness”?](https://docs.cloud.google.com/cdn/docs/caching)
TTL (Time To Live) determines how long the cached content at the edge location is allowed to remain there before checking back with the main server to update the content. While a short TTL would ensure that users are recieving the most updated form of content, a longer TTL reduces load on the backend instances and also improves performance.




