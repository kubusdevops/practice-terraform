resource "aws_instance" "george_app" {
  ami             = "ami-00e801948462f718a"
  instance_type   = "t3.micro"
  key_name        = "kubuskey"
  security_groups = [aws_security_group.george_sg.name]

  tags = {
    Name = "george-app"
  }

}