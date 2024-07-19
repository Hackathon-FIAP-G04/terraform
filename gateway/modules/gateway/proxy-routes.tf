resource "aws_apigatewayv2_integration" "vpc-link-integration" {
  count = length(var.gateway_routes)
  api_id = aws_apigatewayv2_api.api-gtw.id

  request_parameters = {
    "overwrite:path"           = "$request.path"
  }

  integration_uri =  var.gateway_routes[count.index].load_balancer_arn
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type = "VPC_LINK"
  connection_id = aws_apigatewayv2_vpc_link.vpc-link-eks.id
}

resource "aws_apigatewayv2_route" "iburguer-route" {
  count = length(var.gateway_routes)
  api_id = aws_apigatewayv2_api.api-gtw.id

  authorizer_id = var.use_cognito ? aws_apigatewayv2_authorizer.cognito-authorizer.0.id : null
  authorization_type = var.use_cognito ? "JWT" : null
  
  route_key = "${var.gateway_routes[count.index].method} ${var.gateway_routes[count.index].route}"
  target = "integrations/${aws_apigatewayv2_integration.vpc-link-integration.*.id[count.index]}"
}