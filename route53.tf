
resource "aws_route53_record" "main" {
   zone_id = "Z2B24Z7GCB24ED"
   name = "blockguru.us"
   type = "A"
   ttl = "300"
   records = ["${aws_eip.blockguru-eip.public_ip}"]
}
resource "aws_route53_record" "www-record" {
   zone_id = "Z2B24Z7GCB24ED"
   name = "www.blockguru.us"
   type = "A"
   ttl = "300"
   records = ["${aws_eip.blockguru-eip.public_ip}"]
}


