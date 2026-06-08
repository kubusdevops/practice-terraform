resource "aws_security_group" "george_sg" {
    name = "george-sg"
    description = "Security group for George application"
    vpc_id = "vpc-0f8ffa69427e755ff" 

    }    # Replace with your VPC ID

   resource "aws_security_group_rule" "allow_ssh" {
       type             = "ingress"
       from_port        = 22
       to_port          = 22
       protocol         = "tcp"
       cidr_blocks      = ["0.0.0.0/0"]
       security_group_id= aws_security_group.george_sg.id
    }

    resource "aws_security_group_rule" "allow_http" {
       type             = "ingress"
       from_port        = 80
       to_port          = 80
       protocol         = "tcp"
       cidr_blocks      = ["0.0.0.0/0"]
       security_group_id= aws_security_group.george_sg.id
    }

    resource "aws_security_group_rule" "allow_outbound" {
       type             = "egress"
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
       security_group_id= aws_security_group.george_sg.id
    }