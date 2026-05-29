output "lambda_function_name" {
  value = aws_lambda_function.cost_alert_lambda.function_name
}

output "sns_topic_arn" {
  value = aws_sns_topic.cost_alert_topic.arn
}

output "important_note" {
  value = "Check your email and confirm the SNS subscription before alerts can be received."
}
