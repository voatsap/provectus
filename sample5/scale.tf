## Autscale policy
resource "aws_autoscaling_policy" "scale_in_provectus" {
        name                   = "autoscale_in_policy_provectus-${var.instance_suffix[count.index]}"
        adjustment_type        = "ChangeInCapacity"
        policy_type            = "StepScaling"
        estimated_instance_warmup = 35
        autoscaling_group_name = "${element(aws_autoscaling_group.asg-provectus.*.name, count.index)}"

        step_adjustment {
        scaling_adjustment = 0
         metric_interval_upper_bound = 1
         }

        step_adjustment {
        scaling_adjustment = 1
        metric_interval_lower_bound = 1
         }
    count = "${length(var.instance_suffix)}"
}
## Autoscale Alarm Metrics
resource "aws_cloudwatch_metric_alarm" "metric_alarm_cpu_high_provectus" {
  alarm_name          = "metric_alarm_high_cpu_provectus_${var.instance_suffix[count.index]}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "79"

  dimensions {
    AutoScalingGroupName = "${element(aws_autoscaling_group.asg-provectus.*.name, count.index)}"
  }

  alarm_description = "This metric monitors provectus group cpu utilization"
  alarm_actions     = ["${element(aws_autoscaling_policy.scale_in_provectus.*.arn, count.index)}"]

    count = "${length(var.instance_suffix)}"
}
resource "aws_autoscaling_policy" "scale_out_provectus" {
       name                   = "autoscale_out_policy_provectus-${var.instance_suffix[count.index]}"
       adjustment_type        = "ChangeInCapacity"
       policy_type            = "StepScaling"
       estimated_instance_warmup = 35
       autoscaling_group_name = "${element(aws_autoscaling_group.asg-provectus.*.name, count.index)}"

       step_adjustment {
       scaling_adjustment = -1  # remove one node
#        scaling_adjustment = 0   # disable downscale
         metric_interval_upper_bound = 1
         }

        step_adjustment {
        scaling_adjustment = 0
        metric_interval_lower_bound = 1
         }
     count = "${length(var.instance_suffix)}"
}


resource "aws_cloudwatch_metric_alarm" "metric_alarm_cpu_low_provectus" {
  alarm_name          = "metric_alarm_low_cpu_provectus_${var.instance_suffix[count.index]}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "39"

  dimensions {
    AutoScalingGroupName = "${element(aws_autoscaling_group.asg-provectus.*.name, count.index)}"
  }

  alarm_description = "This metric monitors provectus group cpu utilization"
  alarm_actions     = ["${element(aws_autoscaling_policy.scale_out_provectus.*.arn, count.index)}"]

    count = "${length(var.instance_suffix)}"

}

## Print Output

output "provectus_elb_dns_name" {
  value = "${module.m-elb-provectus.elb_dns_name}"
}

