# nat gw
resource "aws_eip" "nat" {
  vpc      = true
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.siva-public-1.id}"
  depends_on = ["aws_internet_gateway.siva-gw"]
}

# VPC setup for NAT
resource "aws_route_table" "siva-private" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }

    tags {
        Name = "siva-private-1"
    }
}
# route associations private
resource "aws_route_table_association" "siva-private-1-a" {
    subnet_id = "${aws_subnet.siva-private-1.id}"
    route_table_id = "${aws_route_table.siva-private.id}"
}
resource "aws_route_table_association" "siva-private-2-a" {
    subnet_id = "${aws_subnet.siva-private-2.id}"
    route_table_id = "${aws_route_table.siva-private.id}"
}
resource "aws_route_table_association" "siva-private-3-a" {
    subnet_id = "${aws_subnet.siva-private-3.id}"
    route_table_id = "${aws_route_table.siva-private.id}"
}
