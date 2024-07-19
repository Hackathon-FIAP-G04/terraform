data "archive_file" "lambda" {
  type        = "zip"
  source_dir = var.path_to_lambda
  output_path = var.output_path
}

resource "aws_lambda_function" "auth_lambda" {
  filename      = var.output_path
  function_name = var.function_name
  handler       = var.handler
  role          = "${aws_iam_role.iam_for_lambda.arn}"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.runtime

  environment {
    variables = {
      "CLIENT_ID" = var.cognito_client_id
      "USER_POOL_ID" = var.cognito_user_pool_id
    }
  }
}

