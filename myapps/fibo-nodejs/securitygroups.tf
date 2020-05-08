resource "aws_security_group" "ecs-securitygroup" {
  vpc_id      = var.MY_VPC
  name        = "ecs"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
   # cidr_blocks			= ["0.0.0.0/0"]
   security_groups = [aws_security_group.myapp-elb-securitygroup.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ecs"
  }
}

resource "aws_security_group" "myapp-elb-securitygroup" {
  vpc_id      = var.MY_VPC
  name        = "fibo-elb"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fibo-elb"
  }
}

resource "aws_security_group" "allow-postgresdb" {
  vpc_id      = var.MY_VPC
  name        = "allow-postgresdb"
  description = "allow-postgresdb"
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
   # cidr_blocks			= ["0.0.0.0/0"]
    security_groups = [aws_security_group.ecs-securitygroup.id] # allow only access from our example instance
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "allow-postgresdb"
  }
}

resource "aws_security_group" "allow-redis" {
  vpc_id      = var.MY_VPC
  name        = "allow-redis"
  description = "allow-redis"
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
   # cidr_blocks			= ["0.0.0.0/0"]
    security_groups = [aws_security_group.ecs-securitygroup.id] # allow only access from docker instance
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "allow-redis"
  }
}
