terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>6"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "superserver" {
    ami = "ami-034a8236c75419857"
    availability_zone = "ap-south-1a"
    key_name = "your-server"
    instance_type = "c7i-flex.large"
    vpc_security_group_ids = [ aws_security_group.superserver_ansible_sec_grp.id ]

    tags = {
      Name = "SuperServer"
    }
}

resource "aws_security_group" "superserver_ansible_sec_grp" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SuperServer_sec-grp"
  }

}

output "superserver_public_ip" {
    value = aws_instance.superserver.public_ip
}
