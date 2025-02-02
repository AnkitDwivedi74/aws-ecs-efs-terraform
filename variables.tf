variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
}
variable "ecs_cpu" {
  description = "The CPU units for the ECS Task (e.g., 256)"
  default     = "256"
}

variable "ecs_memory" {
  description = "The memory (in MB) for the ECS Task (e.g., 512)"
  default     = "512"
}

# variable "key_name" {
#   description = "Name of the SSH key to use for the EC2 instance."
#   type        = string
# }

variable "efs_throughput_mode" {
  description = "EFS throughput mode: bursting or provisioned"
  default     = "bursting"
}