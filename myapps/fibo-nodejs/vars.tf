variable "AWS_REGION" {
	default		= "us-east-1"
}

variable "MY_VPC" {
}

variable "KEY_NAME" {
	default = "useast1_key"
}

variable "PATH_TO_PRIVATE_KEY" {
	default	= "useast1_key.pem"
}

variable "PATH_TO_PUBLIC_KEY" {
	default	= "useast1_key.pem.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "RDS_PASSWORD" {
# Supply it during terraform apply -var 'RDS_PASSWORD=whateverpassword'
}

## https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0aee8ced190c05726"
		us-east-2 = "ami-0d9ef3d936a8fa1c6"
    us-west-1 = "ami-0fc0ce1549e302a52"
    eu-west-1 = "ami-0a74b180a0c97ecd1"
  }
}

variable "MYAPP_SERVICE_ENABLE" {
  default = "0"
}

variable "MYAPP_VERSION" {
  default = "0"
}

