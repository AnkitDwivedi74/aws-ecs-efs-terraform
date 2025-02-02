# Deploying an NGINX Application on Fargate with EFS

## Overview

This project demonstrates how to deploy an NGINX web server on AWS Fargate using ECS, with a twist: instead of storing the NGINX configuration inside the container image, the configuration is stored externally in an Amazon EFS (Elastic File System). This allows you to update the configuration without rebuilding your container image.

### Key Components

- **VPC & Subnets:**  
  We leverage the default VPC and its subnets for networking. This ensures that our resources have the necessary connectivity and that they use the existing AWS networking setup.

- **EFS File System & Access Point:**  
  An Amazon EFS file system is created to store our NGINX configuration. An EFS access point is configured with its root set to `/nginx/conf.d`, which isolates the configuration files. This directory will contain our `default.conf` file that NGINX uses to serve the website.

- **Temporary EC2 Instance (Configuration Uploader):**  
  A small, temporary EC2 instance is launched for one purpose only: to mount the EFS file system, create the required directory structure, and upload the custom NGINX configuration file. This instance is not part of the production workload; it’s only here to ensure that the EFS volume is pre-populated with the configuration the container needs.

- **ECS Cluster, Task Definition & Service:**  
  An ECS cluster is created to run our application on Fargate. 
