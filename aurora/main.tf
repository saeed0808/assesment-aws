# Include a reference to the networking module to obtain subnet IDs
module "networking" {
  source = "../networking"  # Adjust the source path as needed
}

resource "aws_db_subnet_group" "example" {
  name       = var.subnet_group_name
  subnet_ids = module.networking.private_subnet_ids  # Use the private subnet IDs from the networking module
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = var.db_engine
  engine_version       = "5.7.mysql_aurora.2.03.2" # Modify for your Aurora version
  instance_class       = var.db_instance_class
#  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  port                 = 3306 # Specify the desired port here
  db_subnet_group_name = aws_db_subnet_group.example.name
}

# Define Aurora cluster, security group rules, and other configurations here.

