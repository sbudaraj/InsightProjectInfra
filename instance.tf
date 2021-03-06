resource "aws_instance" "adminmaster" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "m4.large"

  # the VPC subnet
  subnet_id = "${aws_subnet.siva-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}" 

  private_ip = "10.0.1.5"

  user_data = "#!/bin/bash\nmkdir -p /persist\necho '/dev/data/volume1 /data ext4 defaults 0 0' >> /etc/fstab\nmount /persist"
}

resource "aws_eip" "blockguru-eip" {
  instance = "${aws_instance.adminmaster.id}"
  vpc = true
}

output "ip" {
	value = "${aws_instance.adminmaster.public_ip}"
}

resource "aws_ebs_volume" "siva-ebs-volume" {
    availability_zone = "us-west-2a"
    size = 20
    type = "gp2" 
    tags {
        Name = "common ebs volume"
    }
}

resource "aws_volume_attachment" "siva-ebs-volume-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.siva-ebs-volume.id}"
  instance_id = "${aws_instance.adminmaster.id}"
}

