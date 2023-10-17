# Configure the AWS provider with your credentials and preferred region
provider "aws" {
  region = "us-east-1" # Update with your preferred region
  # Add your AWS access and secret key here, or use an IAM role
}


# Include networking configurations
module "networking" {
  source = "./networking"

  # Define variables required by the networking module
  vpc_cidr_block       = "10.0.0.0/16"
  subnet_cidr_blocks   = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  public_subnet_tags   = { Name = "Public Subnet" }
  private_subnet_tags  = { Name = "Private Subnet" }
}


# Include Aurora database configurations
module "aurora" {
  source = "./aurora"

  # Define variables required by the Aurora module
  # Example:
  db_engine             = "aurora"
  db_instance_class     = "db.r5.large"
  db_name               = "strapi"
  db_username           = "admin"
  db_password           = "your-strong-password"
  subnet_group_name     = "example-subnet-group"
}

# Include ECS configurations
module "ecs" {
  source = "./ecs"

  # Define variables required by the ECS module
  # Example:
  strapi_container_image = "your-strapi-docker-image:tag"
  strapi_port           = 1337
  ecs_instance_type     = "t2.micro"
}


module "route53" {
  source = "./route53"

  domain_name                  = "yourdomain.com"
  strapi_production_service_name = "strapi-production"
  strapi_staging_service_name    = "strapi-staging"
  strapi_production_dns_name    = module.ecs.strapi_production_dns_name
  strapi_staging_dns_name       = module.ecs.strapi_staging_dns_name
}

# Output variables for reference or integration with other tools
output "aurora_endpoint" {
  description = "Aurora database cluster endpoint"
  value       = module.aurora.aurora_endpoint
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.ecs.ecs_cluster_id
}

output "route53_zone_id" {
  description = "ID of the Route 53 hosted zone"
  value       = module.route53.route53_zone_id
}

# Additional outputs can be defined here

