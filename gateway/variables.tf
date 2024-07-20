variable "prefix" {}

#Gateway
variable "load_balancer_arn_" {} # 1 para cada serviço

#Cognito
variable "cognito_domain" {} # 1 para cada user pool

#Lambda SignIn - 1 para cada lambda
variable "function_name" {}
variable "runtime" {}
variable "handler" {}
