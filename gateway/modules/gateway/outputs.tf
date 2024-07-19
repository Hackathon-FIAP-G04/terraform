output "base_url" {
  value = "${aws_apigatewayv2_stage.api-gtw.invoke_url}"
}