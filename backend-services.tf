resource "aws_db_subnet_group" "myapp-rds-subgrp" {
  name       = "myapp-rds-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "myapp-ecache-subgrp" {
  name       = "myapp-ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet group for Elastic cache"
  }
}

resource "aws_db_instance" "myapp-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.43"
  instance_class         = "db.t3.micro"
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.myapp-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.myapp-backend-sg.id]
}

resource "aws_elasticache_cluster" "myapp-cache" {
  cluster_id           = "myapp-cache"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.myapp-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.myapp-ecache-subgrp.name
}

resource "aws_mq_broker" "myapp-rmq" {
  broker_name        = "myapp-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t3.micro"
  security_groups    = [aws_security_group.myapp-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    password = var.rmqpass
    username = var.rmquser
  }
}