data "aws_subnet_ids" "public-subnets-ids" {
	vpc_id = var.MY_VPC
	
	filter {
		name   = "tag:Name"
		values = ["*public*"]
	}
}

data "aws_subnet_ids" "private-subnets-ids" {
	vpc_id = var.MY_VPC
	
	filter {
		name   = "tag:Name"
		values = ["*private*"]
	}
}

data "aws_subnet" "public-subnets" {
  for_each = data.aws_subnet_ids.public-subnets-ids.ids
  id       = each.value
}

data "aws_subnet" "private-subnets" {
  for_each = data.aws_subnet_ids.private-subnets-ids.ids
  id       = each.value
}

