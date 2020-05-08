resource "aws_ecr_repository" "fibo-client" {
	name		= "fibo/client"
}

resource "aws_ecr_repository" "fibo-server" {
	name		= "fibo/server"
}

resource "aws_ecr_repository" "fibo-worker" {
	name		= "fibo/worker"
}

resource "aws_ecr_repository" "fibo-nginx" {
	name		= "fibo/nginx"
}

