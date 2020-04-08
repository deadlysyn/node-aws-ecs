# Creating a service-specific task execution role

1. Create a new IAM role
2. Attach the AWS managed policy `AmazonECSTaskExecutionRolePolicy`
3. Attach a new managed policy granting access to parameters, secrets and log groups as needed
4. You can drop `kms:Decrypt` if not using custom KMS keys
5. Use these in your task definitions instead of `ecsTaskExecutionRole`
6. Profit!

```json
{
  "Version": "2012-10-17",
  "Sid": "serviceTaskExecutionRole",
  "Statement": [
    {
      "Sid": "AllowParametersAndSecrets",
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters",
        "secretsmanager:GetSecretValue",
        "kms:Decrypt"
      ],
      "Resource": [
        "arn:aws:ssm:*:${aws_account_id}:parameter/${prefix}/*",
        "arn:aws:secretsmanager:*:${aws_account_id}:secret:${prefix}/*",
        "arn:aws:kms:*:${aws_account_id}:key/${kms_key_id}"
      ]
    },
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

```json
{
  ...
  "executionRoleArn": "arn:aws:iam::012345678901:role/serviceTaskExecutionRole",
  "taskRoleArn": "arn:aws:iam::012345678901:role/serviceTaskExecutionRole",
  ...
}
```
