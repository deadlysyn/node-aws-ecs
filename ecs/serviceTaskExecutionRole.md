# Creating a service-specific task execution role

1. Create a new IAM role
2. Atach the AWS managed policy `AmazonECSTaskExecutionRolePolicy`
3. Attach a managed policy granting access to parameters, secrets and log groups if needed
4. You can drop `kms:Decrypt` if not using custom KMS keys

```json
{
  "Version": "2012-10-17",
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
