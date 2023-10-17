variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "example-cluster"
}

variable "strapi_container_image" {
  description = "Docker image for the Strapi application"
  type        = string
}

variable "strapi_port" {
  description = "Port on which Strapi application listens"
  type        = number
  default     = 1337
}

variable "ecs_instance_type" {
  description = "ECS instance type"
  type        = string
  default     = "t2.micro" # Modify as needed
}

