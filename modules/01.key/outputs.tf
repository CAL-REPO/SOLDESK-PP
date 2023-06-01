output "KEY_PAIR_NAME" {
  value = aws_key_pair.AWS_KEY.key_name
}

output "REGION_ID" {
    value = data.aws_region.current.id
}

output "REGION_NAME" {
    value = data.aws_region.current.name
}

output "OWNER_ID" {
    value = data.aws_caller_identity.current.account_id
}

output "USER_ID" {
    value = data.aws_caller_identity.current.user_id
}