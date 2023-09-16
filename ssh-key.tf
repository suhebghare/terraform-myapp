resource "aws_key_pair" "suheb-myapp" {
  key_name   = "suheb-myapp"
  public_key = file(var.PUB_KEY_PATH)
}