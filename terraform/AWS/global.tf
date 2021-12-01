
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "ze-key" {
  key_name   = "ze-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6QXtyGR805Q3617yBX30fx//uKPwqU9oYeuhUvYkctMbdYrpS4LJs1jusLL+viXt+xlfKVed+elX3vTbK9PnMN4fCz2PGWgoYsplQ5UmDuP1uXEUHMUhtkz8qt69msJkOivrLfdEsnoFgL8yIHKN90+ehf0rdk3QyORnH/BEmE3az1jl0hK5qAF7GZQdzXyQhBbZC2LSwCQnix1OFmbK+CrCSJV0i100Dygg4JeIsCDwCuZ+23p43xyTZkT9LqXC3DYSy9mSp6JgB3dMVfU3VJkWDg+gRcTwOf25TcOHQNCzJB+gVc3hNsjccCapYgyyKXbNYVtxLup3OMBkYt0nQIhsv/M/O8iaqDLxL1VAJ++q7GowM/9gngajD4zIg8kyd6wh5SNSnRFAwOrKaGLUc6EB+RqNjmox6hPoEdAO0kgEaRiFSEsVT10RNkGdRA+WWHfy4aezXjZjIsjF+VJN4eJesgXXV4XibPd0OW8gDhpDQLrRSXffiQTrPIn7mFm6hfQY/Q5bX0CJnuzhyqc/uaGNbRAnlR04nPZBXv+Z442740ToGqAGMPd4xR06rAN7NSnenmmt894M7I1tjrZXvw77xXXCd4ZS6wfLXDoEnsJm/X/pKwnCGAb7urT0fezHud5/Y3SEja4YOUCXWJ/0gh4Dl+g9p3Kthy5sDMWLhmQ== zenildo@sti.ufpb.br"
}


output "DNS_Publico_WEB" {
  value = aws_instance.web.public_dns
}


resource "aws_instance" "web" {
    ami = "ami-083654bd07b5da81d"
    instance_type = "t2.micro"
    key_name = "ze-key"
    subnet_id = element(aws_subnet.Public_subnet.*.id, 0)
#    network_interface {
#        network_interface_id = aws_network_interface.interface_local.id
#        device_index         = 0
#    }
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sg_teste.id]
   tags = {
     Name = "Teste_terraform_01"
   }

}



