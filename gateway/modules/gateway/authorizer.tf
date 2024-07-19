resource "aws_apigatewayv2_authorizer" "cognito-authorizer" {
  count = var.use_cognito ? 1 : 0
  name = "${var.prefix}-cognito-authorizer"

  api_id = aws_apigatewayv2_api.api-gtw.id
  authorizer_type = "JWT"
  identity_sources = [ "$request.header.Authorization" ]

  jwt_configuration {
    audience = [ var.cognito_pool_client_id ]
    issuer = "https://${var.cognito_endpoint}"
  }
}