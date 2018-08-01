resource "aws_instance" "adminmaster" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "m4.large"

  # the VPC subnet
  subnet_id = "${aws_subnet.siva-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}" 
}

output "ip" {
	value = "${aws_instance.adminmaster.public_ip}"
}