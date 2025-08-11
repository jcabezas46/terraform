#resource "aws_instance" "public_instance" {
#  ami                     = "ami-02b3c03c6fadb6e2c"
#  instance_type           = "t2.micro"
#  subnet_id =  aws_subnet.public_subnet.id
#  key_name = data.aws_key_pair.key.key_name
#  vpc_security_group_ids = [aws_security_group.ssh.id]
#lifecycle  { 
#  replace_triggered_by = [aws_subnet.public_subnet.id]
#  }

#}


variable "instnacias" {
  description = "nombre de variables"
  type = list(string)
  default = [  ]
  
}
resource "aws_instance" "web" {
   for_each = toset(var.instnacias) 
   ami                     = "ami-02b3c03c6fadb6e2c"
   instance_type           = "t2.micro"
   subnet_id =  aws_subnet.public_subnet.id
   key_name = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]
 
tags = {
  "Name" = each.value
}

}
resource "aws_instance" "monitoreo" {
   count =  var.enable_monitoring  == 1 ? 1:0 
   ami                     = "ami-02b3c03c6fadb6e2c"
   instance_type           = "t2.micro"
   subnet_id =  aws_subnet.public_subnet.id
   key_name = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]
 
tags = {
  "Name" = "monitoreo"
}

}