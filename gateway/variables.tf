variable "prefix" {}

#Gateway
variable "load_balancer_arn_doctors" {} # 1 para cada serviço
variable "load_balancer_arn_appointments" {}

#Cognito
variable "cognito_domain_doctors" {} # 1 para cada user pool
variable "cognito_domain_patients" {} # 1 para cada user pool

#Lambda SignIn - 1 para cada lambda
variable "function_name" {}
variable "runtime" {}
variable "handler" {}
