[
  {
    "name": "client",
    "image": "${ECR_REPO_URL}/fibo/client:${APP_VERSION}",
    "hostname": "client",
    "essential": false,
    "memory": 128,
		"cpu": 256
  },
  {
    "name": "server",
    "image": "${ECR_REPO_URL}/fibo/server:${APP_VERSION}",
    "hostname": "api",
    "essential": false,
    "memory": 128,
		"cpu": 256,
		"environment": [
			{
				"name": "REDIS_HOST",
        "value": "${REDIS_HOST}"
			},
			{
				"name": "REDIS_PORT",
        "value": "${REDIS_PORT}"
			},
			{
				"name": "PGUSER",
        "value": "${PGUSER}"
			},
			{
				"name": "PGHOST",
        "value": "${PGHOST}"
			},
			{
				"name": "PGDATABASE",
        "value": "${PGDATABASE}"
			},
			{
				"name": "PGPASSWORD",
        "value": "${PGPASSWORD}"
			},
			{
				"name": "PGPORT",
        "value": "${PGPORT}"
			}
		]
  },
  {
    "name": "worker",
    "image": "${ECR_REPO_URL}/fibo/worker:${APP_VERSION}",
    "hostname": "worker",
    "essential": true,
    "memory": 128,
		"cpu": 256,
		"environment": [
			{
				"name": "REDIS_HOST",
        "value": "${REDIS_HOST}"
			},
			{
				"name": "REDIS_PORT",
        "value": "${REDIS_PORT}"
			}
		]
  },
  {
    "name": "nginx",
    "image": "${ECR_REPO_URL}/fibo/nginx:${APP_VERSION}",
    "hostname": "nginx",
    "essential": true,
    "memory": 128,
		"cpu": 256,
		"links": ["client", "server"],
		"portMappings": [
			{
				"hostPort": 80,
				"containerPort": 80
			}
		]
  }
]

