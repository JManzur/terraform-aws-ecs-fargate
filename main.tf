locals {
  cluster_name = length(var.name_suffix) > 0 ? "${var.name_prefix}-${var.environment}-fargate-cluster-${var.name_suffix}" : "${var.name_prefix}-${var.environment}-fargate-cluster"
}

resource "aws_kms_key" "ecs_execute_command" {
  count = var.include_execute_command_configuration ? 1 : 0

  description             = "${var.name_prefix}-${var.environment}-ecs-execute-command"
  deletion_window_in_days = 15
}

resource "aws_kms_alias" "ecs_execute_command" {
  count = var.include_execute_command_configuration ? 1 : 0

  name          = "alias/${var.name_prefix}-${var.environment}-ecs-execute-command"
  target_key_id = aws_kms_key.ecs_execute_command[0].key_id
}

resource "aws_cloudwatch_log_group" "ecs_execute_command" {
  count = var.include_execute_command_configuration ? 1 : 0

  name              = "/aws/ecs/${var.name_prefix}-${var.environment}/ecs-execute-command"
  retention_in_days = var.execute_command_log_retention
  kms_key_id        = aws_kms_key.ecs_execute_command[0].arn
  log_group_class   = "INFREQUENT_ACCESS" # One of STANDARD, INFREQUENT_ACCESS
}

resource "aws_ecs_cluster" "this" {
  name = local.cluster_name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  dynamic "configuration" {
    for_each = var.include_execute_command_configuration ? [1] : []
    content {
      execute_command_configuration {
        kms_key_id = try(aws_kms_key.ecs_execute_command[0].arn, null)
        logging    = "OVERRIDE"

        log_configuration {
          cloud_watch_encryption_enabled = true
          cloud_watch_log_group_name     = try(aws_cloudwatch_log_group.ecs_execute_command[0].name, null)
        }
      }
    }
  }

  tags = { Name = local.cluster_name }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = var.capacity_providers

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}