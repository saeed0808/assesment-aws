##variable "domain_name" {
##  description = "The base domain name (e.g., 'example.com')"
##  type        = string
##}
##
##variable "strapi_production_service_name" {
##  description = "The name of the ECS service for production Strapi"
##  type        = string
##}
##
##variable "strapi_staging_service_name" {
##  description = "The name of the ECS service for staging Strapi"
##  type        = string
##}
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
##
variable "domain_name" {
  description = "The base domain name (e.g., 'example.com')"
  type        = string
}

variable "strapi_production_service_name" {
  description = "The name of the ECS service for production Strapi"
  type        = string
}

variable "strapi_staging_service_name" {
  description = "The name of the ECS service for staging Strapi"
  type        = string
}

variable "strapi_production_dns_name" {
  description = "The DNS name for the production Strapi service (e.g., 'strapi.example.com')"
  type        = string
}

variable "strapi_staging_dns_name" {
  description = "The DNS name for the staging Strapi service (e.g., 'staging-strapi.example.com')"
  type        = string
}

