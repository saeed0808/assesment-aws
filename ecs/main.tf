resource "aws_ecs_cluster" "example" {
  name = var.ecs_cluster_name
}

resource "aws_subnet" "private" {
  vpc_id                  = module.networking.vpc_id
  # other subnet configurations
}


resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  # Define container definition for Strapi
  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = var.strapi_container_image
      portMappings = [
        {
          containerPort = var.strapi_port
          hostPort      = var.strapi_port
        }
      ]
    }
  ])
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_execution_policy" {
  name        = "ecs_execution_policy"
  description = "Policy for ECS execution role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetDownloadUrlForLayer"
        ],
        Effect    = "Allow",
        Resource  = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_attachment" {
  policy_arn = aws_iam_policy.ecs_execution_policy.arn
  role       = aws_iam_role.ecs_execution_role.name
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.strapi.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id
    # Define security groups as needed
   # security_groups = [aws_security_group.example.id]
  }

  depends_on = [
    aws_ecs_task_definition.strapi,
  ]
}

# Define ECS security group rules, autoscaling, and other configurations here.

