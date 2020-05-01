output "ecr_repo" {
  value = aws_ecr_repository.app.repository_url
}

output "iam_role_arn" {
  value = aws_iam_role.app.arn
}

output "iam_role_name" {
  value = aws_iam_role.app.name
}
