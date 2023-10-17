variable "db_engine" {
  description = "Aurora database engine (e.g., 'aurora', 'aurora-mysql', 'aurora-postgresql')"
  type        = string
  default     = "aurora"
}

variable "db_instance_class" {
  description = "Aurora DB instance class"
  type        = string
  default     = "db.r5.large"
}

variable "db_name" {
  description = "Name of the initial database to be created"
  type        = string
  default     = "strapi"
}

variable "db_username" {
  description = "Username for the Aurora DB instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the Aurora DB instance"
  type        = string
}

variable "subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
  default     = "example-subnet-group"
}

