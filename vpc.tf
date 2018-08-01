# Internet VPC
resource "aws_vpc" "siva_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "siva_vpc"
    }
}


# Subnets
resource "aws_subnet" "siva-public-1" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2a"

    tags {
        Name = "siva-public-1"
    }
}
resource "aws_subnet" "siva-public-2" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2b"

    tags {
        Name = "siva-public-2"
    }
}
resource "aws_subnet" "siva-public-3" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2c"

    tags {
        Name = "siva-public-3"
    }
}
resource "aws_subnet" "siva-private-1" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2a"

    tags {
        Name = "siva-private-1"
    }
}
resource "aws_subnet" "siva-private-2" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2b"

    tags {
        Name = "siva-private-2"
    }
}
resource "aws_subnet" "siva-private-3" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2c"

    tags {
        Name = "siva-private-3"
    }
}

# Internet GW
resource "aws_internet_gateway" "siva-gw" {
    vpc_id = "${aws_vpc.siva_vpc.id}"

    tags {
        Name = "siva-gw"
    }
}

# route tables
resource "aws_route_table" "siva-public" {
    vpc_id = "${aws_vpc.siva_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.siva-gw.id}"
    }

    tags {
        Name = "siva-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "siva-public-1-a" {
    subnet_id = "${aws_subnet.siva-public-1.id}"
    route_table_id = "${aws_route_table.siva-public.id}"
}
resource "aws_route_table_association" "siva-public-2-a" {
    subnet_id = "${aws_subnet.siva-public-2.id}"
    route_table_id = "${aws_route_table.siva-public.id}"
}
resource "aws_route_table_association" "siva-public-3-a" {
    subnet_id = "${aws_subnet.siva-public-3.id}"
    route_table_id = "${aws_route_table.siva-public.id}"
}
