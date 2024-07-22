output "pool_client_id" {
    value = aws_cognito_user_pool_client.cognito.id
}

output "pool_id" {
    value = aws_cognito_user_pool_client.cognito.user_pool_id
}

output "cognito_endpoint" {
  value = aws_cognito_user_pool.cognito.endpoint
}