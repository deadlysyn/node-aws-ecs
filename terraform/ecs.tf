resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.app_name}-${var.environment}"
  retention_in_days = 7
  tags              = local.tags
}

resource "aws_ecs_cluster" "app" {
  name = "${var.app_name}-${var.environment}"

  tags = local.tags

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "app" {
  family = "${var.app_name}-${var.environment}"
  container_definitions = templatefile("container-definition.json", {
    name           = "${var.app_name}-${var.environment}"
    environment    = var.environment
    image          = "${aws_ecr_repository.app.repository_url}:latest"
    region         = var.region
    port           = var.container_port
    cpu            = var.task_cpu
    memory_limit   = var.task_memory_limit
    memory_reserve = var.task_memory_reserve
  })
  task_role_arn      = aws_iam_role.app.arn
  execution_role_arn = aws_iam_role.app.arn
  network_mode       = "awsvpc"
  cpu                = var.task_cpu
  memory             = var.task_memory_limit

  depends_on = [aws_cloudwatch_log_group.app]

  tags = local.tags
}

resource "aws_ecs_service" "app" {
  name                    = "${var.app_name}-${var.environment}"
  cluster                 = aws_ecs_cluster.app.arn
  task_definition         = aws_ecs_task_definition.app.arn
  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"
  launch_type             = "FARGATE"
  scheduling_strategy     = "REPLICA"

  desired_count                      = var.instance_count
  deployment_maximum_percent         = var.instance_percent_max
  deployment_minimum_healthy_percent = var.instance_percent_min

  network_configuration {
    subnets          = local.private_subnets
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [aws_iam_role.app]

  tags = local.tags
}
