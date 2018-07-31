
variable "AWS_REGION" {
	default = "us-west-2"
}
variable "AMIS" {
	type = "map"
	default ={
	us-east-1 = "amiXXX"
	us-west-1 = "need to lookup"
	us-west-2 = "ami-146a0a6c"
	}
}
