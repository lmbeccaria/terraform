# cluster
resource "aws_ecs_cluster" "fibo-cluster" {
  name = "fibo-cluster"
}

resource "aws_launch_configuration" "fibo-ecs-launchconfig" {
  name_prefix          = "fibo-ecs-launchconfig"
  image_id             = var.ECS_AMIS[var.AWS_REGION]
  instance_type        = var.ECS_INSTANCE_TYPE
  key_name             = var.KEY_NAME
  iam_instance_profile = aws_iam_instance_profile.ecs-ec2-role.id
  security_groups      = [aws_security_group.ecs-securitygroup.id]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=fibo-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "fibo-ecs-autoscaling" {
  name                 = "fibo-ecs-autoscaling"
  vpc_zone_identifier  = [for s in data.aws_subnet.public-subnets : s.id]
  launch_configuration = aws_launch_configuration.fibo-ecs-launchconfig.name
  min_size             = 1
  max_size             = 1
  tag {
    key                 = "Name"
    value               = "ecs-ec2-container"
    propagate_at_launch = true
  }
}

