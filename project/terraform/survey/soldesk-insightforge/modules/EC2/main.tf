resource "aws_instance" "my_web_server" {
  ami           = "ami-0b10f98758e41769a"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install epel -y
    sudo yum install -y ansible
    sudo yum install pip -y
    sudo pip3 install boto3 botocore
    sudo pip install boto3 botocore
  EOF

  iam_instance_profile = var.mywebserver_iam_instance_profile_name

  tags = {
    Name = var.instance_name
  }
}