# Q & A

### What is the difference between high availability and fault tolerance? Which is best to strive for?

- The difference between high avalabilty(HA) and fault tolerance(FT) lies within how they operate in the case of disruption to service. High avalibilty ensures redunandcy across multiple avalability zones allowing the architecture to capatalize on the uptime/downtime ratio in turn proving to be the more cost effective option. Although there is downtime within a HA infrastructure it is minimized. If the system were to fail, it would take a few seconds to a few minutes in order for the infrastruture to recover. FT on the other hand does not allow for any downtime and has what one could call a doppleganger set up in another region. In this case there would be absolutley no disruption whatsoever to the function of the service provided by the infrastucture; however a duplicate running in another region is far more costly. FT may be worth the cost and even vital in the case of a service that cannot afford to suffer disruption to their services.

### Explain the difference between autoscaling and elasticity. What is vertical and horizontal autoscaling? Is one better? Are they feasible on prem?

- Autoscaling is the ability of the infrastructure to increase or decrease the necessary virtual machines(VM's) in a manner that is adjusted to the demand of the workload stressing the infrastrucure. Elasticiy on the other hand is the ability of the infrastructure to adjust and automate the provisioning of resources in general based on the immediate changes to the demand placed on the infrasturcture. Vertical autoscaling is the buffing up of a resource which can handle more load as a single unit. Horizontally autoscaling is more about breadth and not intensity. With horizontal autoscaling infrastructure redunancy, availability and fault tolerance is not a problem since instead of souping up a particular instance you autoscale horizontally(in numbers) in order to distibute the load or responsibilty across multiple instances. I would say in most cases horizontal autoscaling is more advantageous. These features would be virtually impossible and if possible would be exorbitantly costly.

### Explain what the difference between managed and unmanaged instance groups is.

- With unmanaged instance groups, you as the user are responsible for the overhead of managing the distribution, scaling, redundant deployment, healing, and updating the instance group. With managed instance groups(MIG) those aspects are automated and taken care of for you. 

### Explain the different use cases for health checks used by applications (in instance groups) and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same?

- Health checks used by applications check to see if the application itself is functioning in the correct manner, and checks/decides whether that instance should be repaired or replaced. load balanceer health checks on the other hand detect wether or not a vm is responsive and if not directs traffic away from that particular vm. They can be the same but would make it difficult to tell whether your vm was simply unresponsive or failed in totality, which in trun may cause a delayed return to service and efficient recovery.

### Explain in a few sentences what the 3 tier architecture is and how it relates to what you are learning.

- The 3 tier architecture is an infrastructure that consist of three tiers interlinked as a chain-of-command of some sort. The three tiers  consist of a web, application, and database tier. Each tier has their set of backend instance groups as well at least one type of load balancer. The web tier which is the web facing tier often dealing with client activity has a front end that is served by an external application load balancer that interacts with its own instance group backends. The sequence of action typically flows as so: Users ---> Web Tier HTTP/S Load Balancer ---> Web Tier Managed Instance Group ---> Internal Load Balancer ---> Application Tier Managed Instance Group ---> Database tier.




