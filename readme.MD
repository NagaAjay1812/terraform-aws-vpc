
# 🌐 Terraform AWS VPC (Hands-On VPC Build)

This repository contains Terraform code to provision a **custom AWS VPC** and core networking components required for real-world environments.

The main goal of this project is to understand and implement networking fundamentals using Terraform — not just to create resources, but to clearly understand *why each component exists* (public/private subnets, route tables, IGW, NAT, etc.).

---

## 📂 Folder Structure (Actual)

```
terraform-aws-vpc/
├── .terraform/
│   └── modules/
├── data.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── peering.tf
├── readme.MD
└── variables.tf
└── variables.tf
```
## 🧠 What This Project Builds (Concept)
# VPC
VPC is lke a data center, where we can create multiple resources in an isolated environment. we have full control on it.
In vpc we have subnets, IGW, NAT gateway

## subnets:
we create partions in our network for maintenance & security, they are two types of subnets one is public and another one is private subnet.

* public subnet: the subnet have internet acess which is connected to IGW, we  host like ALB, NAT gateway, bastion host in this subnet.
* private subnet: the subnet dont have direct internet access, its not connected to IGW, we host like instances, databases here for security.

## NAT:
the resources inside the private subnet dont have internet access to update or download anything so we are using NAT gateways(NAT allows outbound internet access for private subnet resources without allowing inbound internet traffic to them) to download or update the packages for servers.

## Route table:
A Route Table is just a set of directions (If traffic wants to go somewhere, where should I send it?) traffic rules

## Route:
A Route is one instruction inside the route table.(one rule)

### Route Tables + Routes
- Route Table = set of traffic rules
- Route = one rule inside route table
- Association = attaching a subnet to a route table

## IGW:
An Internet Gateway allows your VPC to talk to the internet.


Component: Meaning
Route Table ->	Traffic rules
Route -> One traffic rule
IGW ->	Direct internet access
NAT	-> Outbound internet only
Association	-> Connect subnet to route table

# 🔧 Inputs (Variables)
* project - (required) string type, user should pass the project name
* environment - (required) string type, user should pass the environment name, values hsould be one of the dev, qa, uat, prod


## 📤 outputs
* vpc_id - ID of the VPC created  
* public_subnet_ids - List of public subnet IDs created  
* private_subnet_ids - List of private subnet IDs created  
* database_subnet_ids - List of database subnet IDs created 

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply
```

Destroy when done:

```bash
terraform destroy
```

---

## 🎯 Why This Repo Matters

This project is a strong foundation for:
- Terraform module building
- Multi-environment networking
- Security-focused subnet design
- Interview-ready VPC explanations

VPC is the base for almost everything in AWS — once this is strong, EC2/EKS/RDS setups become much easier.
