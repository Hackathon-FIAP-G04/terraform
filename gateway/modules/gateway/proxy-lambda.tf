resource "aws_apigatewayv2_route" "proxy-signin" {
  count = length(var.gateway_lambdas)
  api_id = "${aws_apigatewayv2_api.api-gtw.id}"
  route_key = var.gateway_lambdas[count.index].route
  target = "integrations/${aws_apigatewayv2_integration.lambda-integration.*.id[count.index]}"
}
resource "aws_apigatewayv2_integration" "lambda-integration" {
    count = length(var.gateway_lambdas)
    api_id = "${aws_apigatewayv2_api.api-gtw.id}"

    integration_method = "POST"
    integration_type = "AWS_PROXY"
    integration_uri = "${var.gateway_lambdas[count.index].lambda_invoke_arn}"
}

resource "aws_lambda_permission" "apigw-signin" {
  count = length(var.gateway_lambdas)

  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.gateway_lambdas[count.index].function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api-gtw.execution_arn}/*/*"
}