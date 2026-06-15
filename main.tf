resource "aws_instance" "georgeapp" {
    ami           = "ami-0521cb2d60cfbb1a6"
    instance_type = "t3.micro"
    key_name      = "kubuskey"
    security_groups = [aws_security_group.georgeapp.name]


    tags = {
        Name = "george-app"
    }
    user_data = file("userdata.sh")

}