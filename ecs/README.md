# AWS ECS Fargate Task Definition

[task-definition.json](https://gitlab.com/deadlysyn/node-aws-ecs/-/raw/master/ecs/task-definition.json) provides a good starting point for AWS ECS Fargate tasks, including shipping logs via CloudWatch, using ECR, container health checking and injecting secrets.. Consult [the docs](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html) to modify as needed.

# Service-specific task execution role

To use the task definition template above, you'll need to add permission to create CloudWatch log groups, and access either Secrets Manager or Parameter Store (you likely don't need both).

1. Create a new IAM role called `${serviceName}TaskExecutionRole`
2. Attach the AWS managed policy `AmazonECSTaskExecutionRolePolicy` (don't reinvent this wheel)
3. Attach new managed policy granting access to parameters or secrets
4. Attach new managed policy to allow creating log groups
5. You can drop `kms:Decrypt` and the `kms` resource if not using custom KMS keys
6. Use these in your task definitions instead of `ecsTaskExecutionRole`
7. Profit!

## Secrets Policy

Think carefully about how you grant access to secrets. You don't want a single compromised service to facilitate side channel access to other secrets.

If using Parameter Store:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowParameterStoreRO",
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters",
        "kms:Decrypt"
      ],
      "Resource": [
        "arn:aws:ssm:*:${aws_account_id}:parameter/${prefix}/*",
        "arn:aws:kms:*:${aws_account_id}:key/${kms_key_id}"
      ]
    }
  ]
}
```

If using Secrets Manager:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSecretsManagerRO",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "kms:Decrypt"
      ],
      "Resource": [
        "arn:aws:secretsmanager:*:${aws_account_id}:secret:${prefix}/*",
        "arn:aws:kms:*:${aws_account_id}:key/${kms_key_id}"
      ]
    }
  ]
}
```

## Logs Policy

The AWS managed policy `AmazonECSTaskExecutionRolePolicy` allows creating log streams within an existing group, but if you try to create a task with a role which can not create groups your instances will fail to start...you either need to manually create the log groups, or grant permission to your task execution role.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCreateLogGroup",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
```

# Usage

Refer to your custom role in your task definitions:

```json
{
  ...
  "executionRoleArn": "arn:aws:iam::012345678901:role/serviceTaskExecutionRole",
  "taskRoleArn": "arn:aws:iam::012345678901:role/serviceTaskExecutionRole",
  ...
}
```

