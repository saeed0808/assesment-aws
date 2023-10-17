output "aurora_endpoint" {
  description = "Aurora database cluster endpoint"
  value       = aws_db_instance.example.endpoint
}

# Add more outputs as needed.

