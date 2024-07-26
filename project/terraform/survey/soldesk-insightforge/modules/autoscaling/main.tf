provider "aws" {
  region = var.region
}

resource "aws_autoscaling_group" "VEC-PRD-VPC-NGINX-PUB-2A" {
  name = "VEC-PRD-VPC-NGINX-PUB-2A"
  
  launch_template {
    id      = var.nginx_pub_2a_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.nginx_pub_2a_subnet]
  target_group_arns   = [var.nginx_target_group_arn]
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "VEC-PRD-VPC-NGINX-PUB-2A"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]
}

resource "aws_autoscaling_policy" "nginx_pub_2a_policy" {
  name                   = "nginx-pub-2a-cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-NGINX-PUB-2A.name
}

resource "aws_autoscaling_schedule" "nginx_pub_2a_scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  start_time             = "2024-08-15T00:00:00Z"
  end_time               = "2024-09-24T00:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-NGINX-PUB-2A.name
}

resource "aws_autoscaling_schedule" "nginx_pub_2a_scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 6
  desired_capacity       = 1
  recurrence             = "0 18 * * *"
  start_time             = "2024-08-15T09:00:00Z"
  end_time               = "2024-09-24T09:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-NGINX-PUB-2A.name
}

resource "aws_autoscaling_group" "VEC-PRD-VPC-NGINX-PUB-2C" {
  name = "VEC-PRD-VPC-NGINX-PUB-2C"
  
  launch_template {
    id      = var.nginx_pub_2c_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.nginx_pub_2c_subnet]
  target_group_arns   = [var.nginx_target_group_arn]
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "VEC-PRD-VPC-NGINX-PUB-2C"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]
}

resource "aws_autoscaling_policy" "nginx_pub_2c_policy" {
  name                   = "nginx-pub-2c-cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-NGINX-PUB-2C.name
}

resource "aws_autoscaling_schedule" "nginx_pub_2c_scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  start_time             = "2024-08-15T00:00:00Z"
  end_time               = "2024-09-24T00:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-NGINX-PUB-2C.name
}

resource "aws_autoscaling_schedule" "nginx_pub_2c_scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 6
  desired_capacity       = 1
  recurrence             = "0 18 * * *"
  start_time             = "2024-08-15T09:00:00Z"
  end_time               = "2024-09-24T09:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-NGINX-PUB-2C.name
}

resource "aws_autoscaling_group" "VEC-PRD-VPC-TOMCAT-PRI-2A" {
  name = "VEC-PRD-VPC-TOMCAT-PRI-2A"
  
  launch_template {
    id      = var.tomcat_pri_2a_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.tomcat_pri_2a_subnet]
  target_group_arns   = [var.tomcat_target_group_arn]
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "VEC-PRD-VPC-TOMCAT-PRI-2A"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]
}

resource "aws_autoscaling_policy" "tomcat_pri_2a_policy" {
  name                   = "tomcat-pri-2a-cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-TOMCAT-PRI-2A.name
}

resource "aws_autoscaling_schedule" "tomcat_pri_2a_scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  start_time             = "2024-08-15T00:00:00Z"
  end_time               = "2024-09-24T00:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-TOMCAT-PRI-2A.name
}

resource "aws_autoscaling_schedule" "tomcat_pri_2a_scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 6
  desired_capacity       = 1
  recurrence             = "0 18 * * *"
  start_time             = "2024-08-15T09:00:00Z"
  end_time               = "2024-09-24T09:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-TOMCAT-PRI-2A.name
}

resource "aws_autoscaling_group" "VEC-PRD-VPC-TOMCAT-PRI-2C" {
  name = "VEC-PRD-VPC-TOMCAT-PRI-2C"
  
  launch_template {
    id      = var.tomcat_pri_2c_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.tomcat_pri_2c_subnet]
  target_group_arns   = [var.tomcat_target_group_arn]
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "VEC-PRD-VPC-TOMCAT-PRI-2C"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]
}

resource "aws_autoscaling_policy" "tomcat_pri_2c_policy" {
  name                   = "tomcat-pri-2c-cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-TOMCAT-PRI-2C.name
}

resource "aws_autoscaling_schedule" "tomcat_pri_2c_scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  start_time             = "2024-08-15T00:00:00Z"
  end_time               = "2024-09-24T00:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-TOMCAT-PRI-2C.name
}

resource "aws_autoscaling_schedule" "tomcat_pri_2c_scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 6
  desired_capacity       = 1
  recurrence             = "0 18 * * *"
  start_time             = "2024-08-15T09:00:00Z"
  end_time               = "2024-09-24T09:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-TOMCAT-PRI-2C.name
}

resource "aws_autoscaling_group" "VEC-PRD-VPC-DB-PRI-2A" {
  name = "VEC-PRD-VPC-DB-PRI-2A"
  
  launch_template {
    id      = var.db_pri_2a_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.db_pri_2a_subnet]
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "VEC-PRD-VPC-DB-PRI-2A"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]
}

resource "aws_autoscaling_policy" "db_pri_2a_policy" {
  name                   = "db-pri-2a-cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-DB-PRI-2A.name
}

resource "aws_autoscaling_schedule" "db_pri_2a_scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  start_time             = "2024-08-15T00:00:00Z"
  end_time               = "2024-09-24T00:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-DB-PRI-2A.name
}

resource "aws_autoscaling_schedule" "db_pri_2a_scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 6
  desired_capacity       = 1
  recurrence             = "0 18 * * *"
  start_time             = "2024-08-15T09:00:00Z"
  end_time               = "2024-09-24T09:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-DB-PRI-2A.name
}

resource "aws_autoscaling_group" "VEC-PRD-VPC-DB-PRI-2C" {
  name = "VEC-PRD-VPC-DB-PRI-2C"
  
  launch_template {
    id      = var.db_pri_2c_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.db_pri_2c_subnet]
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "VEC-PRD-VPC-DB-PRI-2C"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]
}

resource "aws_autoscaling_policy" "db_pri_2c_policy" {
  name                   = "db-pri-2c-cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-DB-PRI-2C.name
}

resource "aws_autoscaling_schedule" "db_pri_2c_scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  start_time             = "2024-08-15T00:00:00Z"
  end_time               = "2024-09-24T00:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-DB-PRI-2C.name
}

resource "aws_autoscaling_schedule" "db_pri_2c_scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 6
  desired_capacity       = 1
  recurrence             = "0 18 * * *"
  start_time             = "2024-08-15T09:00:00Z"
  end_time               = "2024-09-24T09:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.VEC-PRD-VPC-DB-PRI-2C.name
}
