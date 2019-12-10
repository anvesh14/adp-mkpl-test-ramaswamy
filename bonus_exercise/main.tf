provider "aws" {
	access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}


###################################################################
# Data sources to get VPC, subnet, security group and AMI details #
###################################################################


resource "aws_vpc" "vpc_adp-mkpl-test-ramaswamy" {
  cidr_block       = "${var.cidr_block}"
  instance_tenancy = "${var.instance_type}"

  tags = {
    Name = "adp-mkpl-test-ramaswamy"
  }
}

resource "aws_subnet" "subnet_adp-mkpl-test-ramaswamy" {
  vpc_id     = "${aws_vpc.vpc_adp-mkpl-test-ramaswamy.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "adp-mkpl-test-ramaswamy"
  }
}

resource "aws_ebs_volume" "volume_adp-mkpl-test-ramaswamy" {
  availability_zone = "eu-west-1"
  size              = 40

  tags = {
    Name = "ADPbonus"
  }
}

resource "aws_ebs_snapshot" "snapshot_adp-mkpl-test-ramaswamy" {
  volume_id = "${aws_ebs_volume.volume_adp-mkpl-test-ramaswamy.id}"

  tags = {
    Name = "ADPbonus_snap"
  }
}
  
resource "aws_ami" "ami_adp-mkpl-test-ramaswamy" {
  name                = "terraform-example"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"

  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = "${aws_ebs_snapshot.snapshot_adp-mkpl-test-ramaswamy.id}"
    volume_size = 8
  }
}

resource "aws_instance" "instance_adp-mkpl-test-ramaswamy"{
	ami = "${aws_ami.ami_adp-mkpl-test-ramaswamy.id}"
	instance_type = "t2.nano"
	tags {
    Name = "test-instance"
  }
  
  	connection {
    type        = "ssh"
    user        = "${var.aws_user}"
    private_key = "${file(var.aws_privatekey)}"
   }
   
  
  provisioner "file" {
	source = "ansible_exercise"
	destination = "/tmp/ansible_exercise"
  }
  
  provisioner "remote-exec" {
     inline = [ "yum install ansible -y" , "cd /tmp" , "git clone https://github.com/anvesh14/adp-mkpl-test-adp-mkpl-test-ramaswamy.git" , "ansible-playbook /tmp/adp-mkpl-test-adp-mkpl-test-ramaswamy/ansible_exercise/nodejs_npm_install.yml -i localhost" ] 
     
  }

}
resource "aws_s3_bucket" "bucket" {
    bucket = "${var.aws_bucket}"
    region = "${var.aws_region}"
    acl    = "${var.acl}"
}


data "github_repository" "adp-mkpl-test-adp-mkpl-test-ramaswamy" {

git_clone_url = "https://github.com/anvesh14/adp-mkpl-test-adp-mkpl-test-ramaswamy.git"

}


