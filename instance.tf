resource "aws_instance" "MyFirstInstnace" {
  count         = 3
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstnce-${count.index}"
  }
}
