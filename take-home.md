# DevOps Engineer Take-Home Assignment

## Overview

Deploy a Kubernetes cluster on AWS and troubleshoot a provided manifest to demonstrate your DevOps and debugging skills.

## Prerequisites

- AWS account with free-tier access
- Basic familiarity with Kubernetes, AWS EKS, and kubectl
- Git for version control

## Assignment Tasks

### Part 1: Infrastructure Setup

1. **Create AWS EKS Cluster**
   - Use AWS free-tier eligible resources
   - Set up a single-node cluster using t3.micro instances
   - Configure kubectl to connect to your cluster
   - Document your setup process

2. **Deploy the Provided Manifest**
   - Use the `webserver.yaml` file provided with this assignment
   - Apply the manifest to your cluster
   - Troubleshoot any issues that prevent the deployment from working correctly

### Part 2: Debugging and Validation

3. **Fix Deployment Issues**
   - The provided manifest contains intentional errors
   - Identify and resolve all issues preventing proper functionality
   - Document each problem found and your solution

4. **Demonstrate Working Service**
   - Use kubectl port-forwarding to access the nginx webserver locally
   - Provide screenshots or video showing:
     - Successful pod deployment
     - Service connectivity via port-forward
     - Nginx default page accessible in browser

### Part 3: Public Access (Bonus)

Use Terraform to build out and deliver on the following:

5. **Expose Service Publicly**
   - Configure an AWS Application Load Balancer (ALB) or Network Load Balancer (NLB)
   - Set up proper security groups and networking
   - Ensure the webserver is accessible via public internet

6. **SSL Certificate Setup**
   - Obtain and configure a valid SSL certificate
   - Options: AWS Certificate Manager, Let's Encrypt, or self-signed
   - Demonstrate HTTPS access to your webserver

## Demo Discussion Points

Be prepared to discuss:
- Debugging approach and methodology
- AWS service choices and alternatives
- Security considerations
- Cost optimization strategies
- Scaling and production readiness
- Walk through and discuss steps taken for the project
- Bonus: public URL with valid certificate

## Time Expectations

- Estimated completion time: 2 hours
- Submission deadline: 48 hours from assignment receipt
- Interview presentation: 15-20 minutes

---

**Note**: Remember to clean up AWS resources after the interview to avoid unexpected charges.