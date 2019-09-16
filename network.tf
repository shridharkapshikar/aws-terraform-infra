resource "aws_internet_gateway" "dev-igw" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "dev-public-crt" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"         
        gateway_id = "${aws_internet_gateway.dev-igw.id}" 
    }
    
tags = {
    Name = "dev-public-crt"
  }
}

resource "aws_route_table_association" "dev-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.dev-subnet-public-1.id}"
    route_table_id = "${aws_route_table.dev-public-crt.id}"
}

resource "aws_route_table_association" "dev-subnet-private-1"{
    subnet_id = "${aws_subnet.dev-subnet-private-1.id}"
    route_table_id = "${aws_route_table.dev-public-crt.id}"
}


resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }   
   ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080   # Jenkins port
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 2222    # Ansible port
        to_port = 2222
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 2375      #docker port
        to_port = 2375
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
	
tags = {
    Name = "SSH allowed"
  }
}
