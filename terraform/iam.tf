resource "aws_iam_role" "app" {
  name                  = var.role_name
  description           = "ECS Task Execution Role for ${var.app_name}"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = local.tags
}

resource "aws_iam_policy" "parameter_store_ro" {
  name_prefix = "ParameterStoreRO"
  description = "Grants RO access to Parameter Store"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters",
                "kms:Decrypt"
            ],
            "Resource": [
                "arn:aws:ssm:*:*:parameter/*",
                "arn:aws:kms:*:*:key/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_parameter_store_policy" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.parameter_store_ro.arn
}

resource "aws_iam_role_policy_attachment" "attach_aws_managed_policy" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
