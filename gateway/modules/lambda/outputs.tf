output "invoke_arn" {
  value = aws_lambda_function.auth_lambda.invoke_arn
}

output "function_name" {
  value = aws_lambda_function.auth_lambda.function_name
}