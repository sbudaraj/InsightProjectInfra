resource "aws_instance" "adminmaster" {
	ami 	="${lookup(var.AMIS, var.AWS_REGION)}"
	instance_type = "m4.large"
}