### Configure Route53 for DNS routing to ECS services.
##resource "aws_route53_zone" "example" {
##  name = var.domain_name
##}
##
##resource "aws_route53_record" "production_strapi" {
##  count   = length(var.strapi_production_service_name)
##  zone_id = aws_route53_zone.example.zone_id
##
##  name    = var.strapi_production_dns_name # No need for [count.index]
##  type    = "CNAME"
##  ttl     = "300"
##  records = [aws_ecs_service.strapi_production.dns_name]
##}
##
##resource "aws_route53_record" "staging_strapi" {
##  count   = length(var.strapi_staging_service_name)
##  zone_id = aws_route53_zone.example.zone_id
##
##  name    = var.strapi_staging_dns_name # No need for [count.index]
##  type    = "CNAME"
##  ttl     = "300"
##  records = [aws_ecs_service.strapi_staging.dns_name]
##}
##
### Define additional DNS records or configurations as needed.
##
##variable "strapi_production_dns_name" {
##  description = "The DNS name for the production Strapi service (e.g., 'strapi.example.com')"
##  type        = string
##}
##
##variable "strapi_staging_dns_name" {
##  description = "The DNS name for the staging Strapi service (e.g., 'staging-strapi.example.com')"
##  type        = string
##}
#########################
# Configure Route53 for DNS routing to ECS services.
resource "aws_route53_zone" "example" {
  name = var.domain_name
}

resource "aws_route53_record" "production_strapi" {
  count   = length(var.strapi_production_service_name)
  zone_id = aws_route53_zone.example.zone_id

  name    = var.strapi_production_dns_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_ecs_service.strapi_production.dns_name]
}

resource "aws_route53_record" "staging_strapi" {
  count   = length(var.strapi_staging_service_name)
  zone_id = aws_route53_zone.example.zone_id

  name    = var.strapi_staging_dns_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_ecs_service.strapi_staging.dns_name]
}

# Define additional DNS records or configurations as needed.

