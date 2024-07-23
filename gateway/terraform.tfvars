prefix = "healthmed"

load_balancer_arn_doctors = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-healthme-healthme-1bf39c275f/591664a5c759fd5e/23df2587462911af"
load_balancer_arn_appointments = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-healthme-healthme-da2d1b6c38/d3c9df01dd932f2e/1de4ae64030ec1ab"

cognito_domain_doctors = "healthmed-doctors"
cognito_domain_patients = "healthmed-patients"

function_name = "lambda_placeholder"
handler = "iBurguer.Onboarding.Placeholder::iBurguer.Onboarding.Placeholder.Function::FunctionHandler"
runtime = "dotnet8"