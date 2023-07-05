# Terraform AWS ECS Fargate Module

Terraform module to create an ECS Fargate cluster.

## How to use this module

```bash
module "ecs" {
  source = "git::https://github.com/JManzur/terraform-aws-ecs-fargate.git?ref=vX.X.X"

  # Required variables:
  name_prefix = "si"
  environment = "dev"

  # Optional variables:
  name_suffix                           = "main"
  capacity_providers                    = ["FARGATE_SPOT", "FARGATE"]
  enable_container_insights             = true
  include_execute_command_configuration = true
  execute_command_log_retention         = 14
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ecs_execute_command](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_kms_alias.ecs_execute_command](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.ecs_execute_command](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | [OPTIONAL] List of capacity providers to use for the cluster. | `list(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | [OPTIONAL] Enable container insights for the cluster. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | [REQUIRED] Used to name and tag resources. | `string` | n/a | yes |
| <a name="input_execute_command_log_retention"></a> [execute\_command\_log\_retention](#input\_execute\_command\_log\_retention) | [OPTIONAL] The number of days to retain log events in the log group for the execute command configuration. | `number` | `7` | no |
| <a name="input_include_execute_command_configuration"></a> [include\_execute\_command\_configuration](#input\_include\_execute\_command\_configuration) | [OPTIONAL] Enable execute command configuration for the cluster. | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | [REQUIRED] Used to name and tag resources. | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | [OPTIONAL] Used to name and tag global resources. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_identifiers"></a> [ecs\_cluster\_identifiers](#output\_ecs\_cluster\_identifiers) | Attributes that identify the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
