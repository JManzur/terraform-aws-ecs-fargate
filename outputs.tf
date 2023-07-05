output "ecs_cluster_identifiers" {
  description = "Attributes that identify the cluster"
  value = {
    arn  = try(aws_ecs_cluster.this.arn, null)
    id   = try(aws_ecs_cluster.this.id, null)
    name = try(aws_ecs_cluster.this.name, null)
  }
}