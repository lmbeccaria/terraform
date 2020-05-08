resource "aws_db_subnet_group" "postgresdb-subnet" {
  name        = "postgresdb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [for s in data.aws_subnet.public-subnets : s.id]
}

resource "aws_db_instance" "postgresdb" {
  allocated_storage         = 20 # 100 GB of storage, gives us more IOPS than a lower number
  engine                    = "postgres"
  engine_version            = "11.5"
  instance_class            = "db.t2.micro"    # use micro if you want to use the free tier
  identifier                = "fibo-production"
  name                      = "fibo_production" # database name
  username                  = "postgres_admin"  # username
  password                  = var.RDS_PASSWORD  # password
  db_subnet_group_name      = aws_db_subnet_group.postgresdb-subnet.name
  multi_az                  = "false" # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids    = [aws_security_group.allow-postgresdb.id]
  storage_type              = "gp2"
  backup_retention_period   = 7       # how long you’re going to keep your backups
 # availability_zone         = [for s in data.aws_subnet.private-subnets : s.id][0].availability_zone # prefered AZ
  final_snapshot_identifier = "postgresdb-final-snapshot" # final snapshot when executing terraform destroy
  tags = {
    Name = "postgresdb-instance"
  }
}

