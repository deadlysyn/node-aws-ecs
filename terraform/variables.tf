# variable "aws_account_id" {
#   description = "AWS Account ID used in IAM role policy creation"
#   type        = string
#   default     = ""
# }

variable "role_name" {
  description = "Name of IAM task execution role to create"
  type        = string
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. development, staging, production)"
  type        = string
}

variable "app_name" {
  description = "App/ECS task family name"
  type        = string
}

variable "container_port" {
  description = "Port exposed by app container"
  type        = number
}

variable "task_cpu" {
  description = "Number of CPU units ECS reserves for container"
  type        = number
}

variable "task_memory_limit" {
  description = "Number of CPU units ECS reserves for container"
  type        = number
}

variable "task_memory_reserve" {
  description = ""
  type        = number
}

variable "instance_count" {
  description = "Number of task instances"
  type        = number
}

variable "instance_percent_min" {
  description = "Minimum allowed task percentage (supports rolling deployments)"
  type        = number
}

variable "instance_percent_max" {
  description = "Maximum allowed task percentage (supports rolling deployments)"
  type        = number
}

variable "tags" {
  description = "Standard tags for all resources"
  type        = map
  default = {
    owner      = "mrh@devopsdreams.io"
    created-by = "terraform"
  }
}
