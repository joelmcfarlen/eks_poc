# EKS Cluster with NGINX + ALB + HTTPS

This project deploys a secure **Amazon EKS cluster** running an **NGINX webserver** exposed through an **Application Load Balancer (ALB)** with **HTTPS**, all managed with **Terraform**.  
The design follows AWS best practices by hosting the **EKS nodes in private subnets** and the **ALB in public subnets** for secure, controlled ingress traffic.

---

## Prerequisites

Before deploying, ensure you have the following tools installed and configured:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- AWS credentials configured via: aws configure


### AWS Infrastructure Prerequisites

You must have:

- An existing **VPC**
- At least **2 public subnets** and **2 private subnets**
- A **NAT Gateway** for private subnet egress access
- **VPC Endpoints** for:
  - `com.amazonaws.<region>.ssm`
  - `com.amazonaws.<region>.ssmmessages`
  - `com.amazonaws.<region>.ec2messages`
  - `com.amazonaws.<region>.logs` (optional but recommended)
- An **ACM Certificate ARN** in the same region (self-signed or AWS-issued)
- IAM permissions to create:
  - EKS clusters and node groups
  - IAM roles and policies
  - Load balancers, target groups, and related networking components

---

## Basic Infrastructure Created

Terraform provisions the following:

- **EKS Cluster** (control plane in private subnets)
- **Node Group** (EC2 worker nodes in private subnets)
- **AWS Load Balancer Controller** (deployed via Helm)
- **NGINX Deployment** (1 replica)
- **Kubernetes Service** (ClusterIP)
- **Ingress** (creates internet-facing ALB in public subnets with HTTPS listener)

This setup ensures workloads remain private while allowing controlled inbound access via the ALB.

---

## Configuration

Edit the `terraform.tfvars` file and update with your own values. NOTE: All variables are configured in the root files to assist in centralized configuration/administration.

```hcl
environment         = ""
aws_region          = ""

vpc                 = ""
subnet_pub_1        = ""
subnet_pub_2        = ""
subnet_pub_3        = ""
subnet_pv_1         = ""
subnet_pv_2         = ""
subnet_pv_3         = ""

alb_certificate_arn = ""

node_group_instance_type = [""]
node_group_desired_size  = 0
node_group_min_size      = 0
node_group_max_size      = 0

tags = {
  Project     = ""
  Environment = ""
  Owner       = ""
}
```

---

## Deployment

Run the following commands in order:

# Initialize Terraform providers and modules
terraform init

# Validate syntax and configuration
terraform validate

# Preview changes
terraform plan

# Deploy the infrastructure
terraform apply
```

After successful deployment, configure `kubectl` to connect to your EKS cluster:


aws eks update-kubeconfig --region <region> --name <cluster-name>


Then verify that everything is running:

kubectl get nodes
kubectl get pods -A
kubectl get ingress
```

---

## Testing the Deployment

Retrieve the ALB DNS name created by the Ingress:

```bash
kubectl get ingress <ingress-name> -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

Open the following in your browser:

```
https://<ALB-DNS-NAME>
```

If you’re using a self-signed certificate, your browser may display a warning — this is expected.

Alternatively, from PowerShell:

```powershell
curl.exe -Ik https://<ALB-DNS-NAME> --insecure
```

Expected output:

```
HTTP/1.1 200 OK
Server: nginx
```

---

## Cleanup

To remove all AWS resources created by this project:

terraform destroy

---

## Notes & Gotchas

- The **EKS nodes** are deployed in **private subnets**; outbound internet traffic requires a **NAT Gateway**.
- The **ALB** is deployed in **public subnets** for inbound HTTPS access.
- The **AWS Load Balancer Controller** must be healthy:
    kubectl -n kube-system get pods | grep alb
  ```
- ACM certificates must:
  - Use a **fully qualified domain name** (e.g., demo.cogspace.local)
  - Have **RSA 2048/4096-bit keys** and **SHA-256+** signature algorithms
- Ensure your Kubernetes **Service** type is `ClusterIP` (not `NodePort`) when using an ALB.
- If you see “Too many pods” or scheduling failures, increase your node group’s `desired_size` and `max_size`.

---

Result:  
You get a **private EKS cluster** accessible via a **public HTTPS ALB endpoint**, following AWS networking and security best practices.

---

**Author:** Joel McFarlen  

