# Terraform AWS VPC
the module creates following resources

# VPC
VPC is lke a data center, where we can create multiple resources in an isolated environment. we have full control on it.
In vpc we have subnets, IGW, NAT gateway

## subnets:
we create partions in our network for maintenance & security, they are two types of subnets one is public and another one is private subnet.

* public subnet: the subnet have internet acess which is connected to IGW, we  host like ALB, NAT gateway, bastion host in this subnet.
* private subnet: the subnet dont have direct internet access, its not connected to IGW, we host like instances, databases here for security.

## NAT:
the resources inside the private subnet dont have internt access to update or download anything so we are using NAT gateways to download or update the packages for servers.

## Route table:
A Route Table is just a set of directions (If traffic wants to go somewhere, where should I send it?) traffic rules

## Route:
A Route is one instruction inside the route table.(one rule)

## IGW:
An Internet Gateway allows your VPC to talk to the internet.


Component: Meaning
Route Table ->	Traffic rules
Route -> One traffic rule
IGW ->	Direct internet access
NAT	-> Outbound internet only
Association	-> Connect subnet to route table

# Inputs
* project - (required) string type, user should pass the project name
* environment - (required) string type, user should pass the environment name, values hsould be one of the dev, qa, uat, prod


## 📤 outputs
