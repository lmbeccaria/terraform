output "ecr-repo-URL" {
	value		= replace(aws_ecr_repository.fibo-client.repository_url, "/fibo/client", "") 
}

output "fibo-cluster-ARN" {
	value	= aws_ecs_cluster.fibo-cluster.arn
}

output "fibo-loadbalancer-DNS_NAME" {
	value = aws_elb.myapp-elb.dns_name
}

output "REDIS_HOST" {
	value = aws_elasticache_cluster.redis-cluster.cache_nodes.0.address
}

output "REDIS_PORT" {
	value = aws_elasticache_cluster.redis-cluster.cache_nodes.0.port
}

output "PGUSER" {
	value = aws_db_instance.postgresdb.username
}

output "PGHOST" {
	value = aws_db_instance.postgresdb.address
}

output "PGDATABASE" {
	value = aws_db_instance.postgresdb.name
}

output "PGPASSWORD" {
	value = aws_db_instance.postgresdb.password
}

output "PGPORT" {
	value = aws_db_instance.postgresdb.port
}

output "public-subnet-ids" {
  value = [for s in data.aws_subnet.public-subnets : s.id]
}

output "private-subnet-ids" {
  value = [for s in data.aws_subnet.private-subnets : s.id]
}
