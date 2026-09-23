
resource "aws_key_pair" "my_keys" {
	key_name = "teraa-new-test-new"
	public_key = file("/Users/ysoni/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "my_security_group2" {
	name = "ssh-port-open-new"
        description = "ssh and apache port open"

	ingress {
		from_port = 22
  		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

data "aws_ami" "myamazon-linux" {
	owners = ["amazon"]
	most_recent = true
	filter {
		name = "name"
		values = ["amzn2-ami-hvm-*-x86_64-gp2"]
	}
}



resource "aws_instance" "web1" {
	count=3
	ami = data.aws_ami.myamazon-linux.id
      	instance_type = "t3.micro"
	vpc_security_group_ids = [aws_security_group.my_security_group2.id ]
	key_name = aws_key_pair.my_keys.key_name

	tags = {
		Name = "webserver"
	}
}

output "ssh-ips-0" {
	value = "ssh ec2-user@${aws_instance.web1[0].public_ip}"
}
output "ssh-ips-1" {
	value = "ssh ec2-user@${aws_instance.web1[1].public_ip}"
}

output "ssh-ips-2" {
	value = "ssh ec2-user@${aws_instance.web1[2].public_ip}"
}




