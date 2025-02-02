
## File Breakdown

### 1. **variables.tf**
Defines all configurable parameters like region, VPC CIDR, ECS task size, and EFS throughput mode.

### 2. **data.tf**
Retrieves information about the default VPC, its subnets, and the latest Ubuntu AMI from Canonical.


Creates:
- A security group for EFS.
- An EFS file system with a lifecycle policy.
- Mount targets in all default subnets.
- An EFS access point with its root directory set to `/nginx/conf.d`.

### 5. **ec2-helper.tf**
Creates an EC2 instance (the configuration uploader) that:
- Uses an Ubuntu AMI.
- Mounts the EFS file system.
- Creates the `/nginx/conf.d` directory.
- Writes the custom NGINX configuration file (`default.conf`) to that directory.
- Unmounts the EFS after ensuring the file is written.


Defines IAM roles for ECS:
- **ECS Task Execution Role:** Grants ECS permissions to pull container images, send logs, and use ECS Exec.
- **ECS Task Role:** Grants in-container permissions (e.g., for EFS access) and attaches the AmazonElasticFileSystemClientReadWriteAccess policy.
- Also attaches an inline policy to the execution role for ECS Exec functionality.

Uses data sources to reference the default VPC and subnets. (In this example, we’re using the default VPC provided by AWS.)
Creates:
- An ECS Cluster.
- A security group for ECS tasks to allow HTTP traffic.
- An ECS Task Definition that defines a container running NGINX. The container mounts the EFS volume (via the access point) at `/etc/nginx/conf.d`, so that NGINX loads the custom configuration.
- An ECS Service that runs on Fargate in public subnets with a public IP and has ECS Exec enabled for debugging.

### 8. **outputs.tf**
Defines outputs that provide:
- The ECS cluster ID.
- The ECS service name.
- The public IP of the EC2 configuration uploader (for debugging if needed).

## How to Deploy

1. **Clone the Repository:**  
   Clone this Terraform project to your local machine and navigate into the project directory.

2. **Initialize Terraform:**  
   Run the following command in your terminal:
   ```bash
   terraform init
