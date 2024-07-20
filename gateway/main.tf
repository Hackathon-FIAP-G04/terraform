module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "lambda" {
  source = "./modules/lambda"
  subnet_ids = concat(module.vpc.subnet_ids, module.vpc.private_subnet_ids)
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
  function_name = var.function_name
  runtime = var.runtime
  handler = var.handler
  cognito_client_id = module.cognito.pool_client_id
  cognito_user_pool_id = module.cognito.pool_id
}

module "gateway" {
  source = "./modules/gateway"

  gateway_name = "${var.prefix}-gateway"
  gateway_stage = "${var.prefix}"
  gateway_routes = [ 
  {
    route = "/api/"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_
  } ]

  gateway_lambdas = [ {
    route = "POST /signin"
    lambda_invoke_arn = module.lambda.invoke_arn
    function_name = module.lambda.function_name
  }]

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix

  use_cognito = true
  cognito_endpoint = module.cognito.cognito_endpoint
  cognito_pool_client_id = module.cognito.pool_client_id
}

module "cognito" {
  source = "./modules/cognito"
  prefix = "${var.prefix}-totem"
  cognito_domain = var.cognito_domain
}

output "cognito_totem_user_pool_id" {
  value = module.cognito.pool_id
}

output "cognito_totem_user_pool_client_id" {
  value = module.cognito.pool_client_id
}

output "base_url" {
  value = "${module.gateway.base_url}"
}

