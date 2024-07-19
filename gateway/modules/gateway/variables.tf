// Gateway vars
variable "gateway_name" {}
variable "gateway_stage" {}
variable "gateway_routes" {
    type = list(object({
      route = string
      method = string
      load_balancer_arn = string
    }))
}

variable "gateway_lambdas" {
  type = list(object({
    route = string
    lambda_invoke_arn = string
    function_name = string
  }))
}

variable "vpc_id" {}
variable "subnet_ids" {}
variable "private_subnet_ids" {}
variable "prefix" {}

variable "use_cognito" {
  type = bool
  default = false
}

variable "cognito_pool_client_id" {
  default = ""
}
variable "cognito_endpoint" {
  default = ""
}