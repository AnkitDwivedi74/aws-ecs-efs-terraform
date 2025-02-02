output "ecs_cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = aws_ecs_cluster.nginx_cluster.id
}

output "ecs_service_name" {
  description = "The name of the ECS Service"
  value       = aws_ecs_service.nginx_service.name
}

output "ec2_instance_public_ip" {
  description = "Public IP address of the EC2 instance that uploaded the config"
  value       = aws_instance.conf_uploader.public_ip
}