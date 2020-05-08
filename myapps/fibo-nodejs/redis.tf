resource "aws_elasticache_subnet_group" "redis-subnets" {
  name        = "redis-subnets"
  description = "REDIS subnet group"
  subnet_ids  = [for s in data.aws_subnet.public-subnets : s.id]
}

resource "aws_elasticache_cluster" "redis-cluster" {
  cluster_id           = "fibo-production"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis2.8"
  engine_version       = "2.8.6"
  port                 = 6379
	subnet_group_name		 = aws_elasticache_subnet_group.redis-subnets.name
	security_group_ids	 = [aws_security_group.allow-redis.id]
}
