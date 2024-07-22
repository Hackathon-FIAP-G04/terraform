prefix = "healthmed"

load_balancer_arn_doctors = ""
load_balancer_arn_appointments = ""

cognito_domain_doctors = "healthmed-doctors"
cognito_domain_patients = "healthmed-patients"

function_name = "lambda_placeholder"
handler = "iBurguer.Onboarding.Placeholder::iBurguer.Onboarding.Placeholder.Function::FunctionHandler"
runtime = "dotnet8"