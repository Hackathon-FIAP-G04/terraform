module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}
/*
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
*/
module "gateway-doctor" {
  source = "./modules/gateway"

  gateway_name = "${var.prefix}-doctors-gateway"
  gateway_stage = "${var.prefix}-doctors"
  gateway_routes = [ 
  {
    route = "/doctors"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_doctors
  },
  {
    route = "/doctors"
    method = "PUT"
    load_balancer_arn = var.load_balancer_arn_doctors
  },
  {
    route = "/doctors"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_doctors
  },
  {
    route = "/servicePeriods"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_appointments
  },
  {
    route = "/appointments"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_appointments
  },
  {
    route = "/appointments/accept"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_appointments
  },
  {
    route = "/appointments/refuse"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_appointments
  } ]

  gateway_lambdas = []

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix

  use_cognito = true
  cognito_endpoint = module.cognito-doctors.cognito_endpoint
  cognito_pool_client_id = module.cognito-doctors.cognito_pool_client_id
}

module "gateway-patients" {
  source = "./modules/patients"

  gateway_name = "${var.prefix}-patients-gateway"
  gateway_stage = "${var.prefix}-patients"
  gateway_routes = [ 
  {
    route = "/doctors"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_doctors
  },
  {
    route = "/appointments/available"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_appointments
  },
  {
    route = "/appointments"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_appointments
  },
  {
    route = "/appointments/schedule"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_appointments
  },
  {
    route = "/appointments/cancel"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_appointments
  } ]

  gateway_lambdas = []

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix

  use_cognito = true
  cognito_endpoint = module.cognito-patients.cognito_endpoint
  cognito_pool_client_id = module.cognito-patients.cognito_pool_client_id
}

module "cognito-doctors" {
  source = "./modules/cognito-doctors"
  prefix = "${var.prefix}-totem"
  cognito_domain = var.cognito_domain_doctors
}

module "cognito-patients" {
  source = "./modules/cognito-patients"
  prefix = "${var.prefix}-totem"
  cognito_domain = var.cognito_domain_patients
}

output "base_url" {
  value = "${module.gateway.base_url}"
}

