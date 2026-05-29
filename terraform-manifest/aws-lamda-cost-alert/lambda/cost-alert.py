import boto3
import os
from datetime import date, timedelta

ce = boto3.client("ce", region_name="ca-central-1")
sns = boto3.client("sns")


def lambda_handler(event, context):
    threshold = float(os.environ["MONTHLY_COST_THRESHOLD"])
    sns_topic_arn = os.environ["SNS_TOPIC_ARN"]

    today = date.today()
    start_date = today.replace(day=1).isoformat()
    end_date = (today + timedelta(days=1)).isoformat()

    response = ce.get_cost_and_usage(
        TimePeriod={
            "Start": start_date,
            "End": end_date
        },
        Granularity="MONTHLY",
        Metrics=["UnblendedCost"]
    )

    amount = float(
        response["ResultsByTime"][0]["Total"]["UnblendedCost"]["Amount"]
    )

    currency = response["ResultsByTime"][0]["Total"]["UnblendedCost"]["Unit"]

    if amount >= threshold:
        message = f"""
AWS Billing Alert

Your current AWS monthly cost is {currency} {amount:.2f}.
Your alert threshold is {currency} {threshold:.2f}.

Please review AWS Cost Explorer and check services like:
- EKS
- NAT Gateway
- Load Balancer
- EBS Volumes
- CloudWatch Logs
- WAF
- Route 53
"""

        sns.publish(
            TopicArn=sns_topic_arn,
            Subject="AWS Cost Alert: Threshold Reached",
            Message=message
        )

        return {
            "status": "ALERT_SENT",
            "current_cost": amount,
            "threshold": threshold
        }

    return {
        "status": "OK",
        "current_cost": amount,
        "threshold": threshold
    }
