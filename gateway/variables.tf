variable "prefix" {}

#Gateway
variable "vpc_cidr_block" {}
variable "load_balancer_arn_" {} # 1 para cada serviço

#Cognito
variable "cognito_domain" {} # 1 para cada user pool

#Lambda SignIn - 1 para cada lambda
variable "path_to_lambda" {}
variable "output_path" {}
variable "function_name" {}
variable "runtime" {}
variable "handler" {}
