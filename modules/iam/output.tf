output "iam_arn" {
  value = aws_iam_role.iam_role.arn
}

output "eks_cluster_policy" {
  value = aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
}

output "eks_service_policy" {
  value = aws_iam_role_policy_attachment.AmazonEKSServicePolicy
}

output "iam_instance_profile_name" {
  value = join("", aws_iam_instance_profile.iam_instance_profile.*.name)
}
