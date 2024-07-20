resource "aws_lambda_function" "auth_lambda" {
  filename      = var.output_path
  function_name = var.function_name
  handler       = var.handler
  role          = "${aws_iam_role.iam_for_lambda.arn}"

  runtime = var.runtime

  environment {
    variables = {
      "CLIENT_ID" = var.cognito_client_id
      "USER_POOL_ID" = var.cognito_user_pool_id
    }
  }
}

