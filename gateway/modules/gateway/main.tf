resource "aws_apigatewayv2_api" "api-gtw" {
  name = var.gateway_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api-gtw" {
  api_id = aws_apigatewayv2_api.api-gtw.id

  name = var.gateway_stage
  auto_deploy = true
}

resource "aws_apigatewayv2_deployment" "api-gtw" {
  depends_on = [ 
    aws_apigatewayv2_integration.vpc-link-integration,
    aws_apigatewayv2_route.iburguer-route
  ]

  api_id = "${aws_apigatewayv2_api.api-gtw.id}"
}



