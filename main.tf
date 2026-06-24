resource "aws_instance" "georgeapp" {
  ami             = "ami-0521cb2d60cfbb1a6"
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.georgeapp.name]

  tags = {
    Name = "george-app"
  }
  
  user_data = file("userdata.sh")
}

resource "aws_key_pair" "deployer" {
  # Change only this line below to fix the duplicate error:
  key_name   = "kubuskey-new"
  public_key = file("${path.module}/kubuskey.pub")
}
