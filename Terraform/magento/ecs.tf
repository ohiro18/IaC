resource "aws_instance" "first" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = ["${aws_security_group.first.name}"]
  tags = {
    Name = "webserver"
  }

#This line of code is use to change the size of created root volume.

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    #copy <your_private_key>.pem to your local instance home directory
    #restrict permission: chmod 400 <your_private_key>.pem
    private_key = file("/path/of/pem/file")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = var.magento
    destination = "/home/ubuntu/magento.tar.gz" 
  }
  
  provisioner "file" {
    source	= "magento-2.sh"
    destination = "/home/ubuntu/magento-2.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh magento-2.sh"
    ]
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.first.id
}

