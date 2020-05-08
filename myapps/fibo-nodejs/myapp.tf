##### WEB task and service definitions

data "template_file" "web-task-definition-template" {
  template = file("templates/web-task.json.tpl")
  vars = {
    ECR_REPO_URL = replace(aws_ecr_repository.fibo-client.repository_url, "/fibo/client", "") 
		APP_VERSION	 = var.MYAPP_VERSION
		REDIS_HOST = aws_elasticache_cluster.redis-cluster.cache_nodes.0.address
		REDIS_PORT = aws_elasticache_cluster.redis-cluster.cache_nodes.0.port
		PGUSER		 = aws_db_instance.postgresdb.username
		PGHOST		 = aws_db_instance.postgresdb.address
		PGDATABASE = aws_db_instance.postgresdb.name
		PGPASSWORD = aws_db_instance.postgresdb.password
		PGPORT		 = aws_db_instance.postgresdb.port		
	}
}

resource "aws_ecs_task_definition" "web-task-definition" {
  family                = "fibo-web-tsk"
  container_definitions = data.template_file.web-task-definition-template.rendered
}

resource "aws_ecs_service" "web-service" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "fibo-web-srv"
  cluster         = aws_ecs_cluster.fibo-cluster.id
  task_definition = aws_ecs_task_definition.web-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach1]

  load_balancer {
    elb_name       = aws_elb.myapp-elb.name
    container_name = "nginx"
    container_port = 80
  }

	lifecycle {
    ignore_changes = [task_definition]
  }
}
