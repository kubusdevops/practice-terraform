resource "aws_instance" "georgeapp" {
    ami = "ami-0152204c1a187337c"
    instance_type = "t3.micro"
    key_name = "kubuskey"
    security_groups = [aws_security_group.georgeapp-sg.name]

    tags = {
        Name = "georgeapp"
    }

}