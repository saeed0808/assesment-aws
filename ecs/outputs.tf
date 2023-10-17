output "strapi_production_dns_name" {
  description = "DNS name for the production Strapi service"
  value       = aws_ecs_service.strapi_production.dns_name
}

output "strapi_staging_dns_name" {
  description = "DNS name for the staging Strapi service"
  value       = aws_ecs_service.strapi_staging.dns_name
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.example.id
}

