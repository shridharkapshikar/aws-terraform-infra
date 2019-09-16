resource "aws_instance" "infra" {

    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    # VPC
    subnet_id = "${aws_subnet.dev-subnet-public-1.id}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.dev-region-key-pair.id}"

    provisioner "file" {
        source = "conf/setup.sh"
        destination = "/tmp/setup.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/setup.sh",
             "sudo sh /tmp/setup.sh"
        ]
    }

    connection {
        type = "ssh"
        host = "${element(aws_instance.infra.*.public_ip, 0)}"
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
    depends_on = [aws_instance.web] 
tags = {
    Name = "ec2-infra"
  }
}

resource "aws_instance" "web" {

    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    # VPC
    subnet_id = "${aws_subnet.dev-subnet-private-1.id}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.dev-region-key-pair.id}"

    provisioner "file" {
        source = "conf/tomcat.sh"
        destination = "/tmp/tomcat.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/tomcat.sh",
             "sudo sh /tmp/tomcat.sh"
        ]
    }
    connection {
        type = "ssh"
        host = "${element(aws_instance.web.*.public_ip, 0)}"
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
tags = {
    Name = "ec2-web"
  }

#    depends_on = [aws_instance.infra]
}

resource "aws_key_pair" "dev-region-key-pair" {
    key_name = "dev-region-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}
