resource "aws_instance" "myapp-bastion" {
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.myapp-bastion-sg.id]
  count                  = var.instance_count
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = aws_key_pair.suheb-myapp.key_name
  associate_public_ip_address = true

  tags = {
    Name    = "myapp-bastion"
    PROJECT = "myapp"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.myapp-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/myapp-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/myapp-dbdeploy.sh",
      "sudo /tmp/myapp-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.myapp-rds]
}