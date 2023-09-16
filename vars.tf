variable "AWS_REGION" {
  default = "me-south-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    me-south-1 = "ami-03925b32489532bc2"
    us-east-1  = "ami-06397100adf427136"
    ap-south-1 = "ami-08e5424edfe926b43"
  }
}

variable "PRIV_KEY_PATH" {
  default = "suheb-myapp"
}

variable "PUB_KEY_PATH" {
  default = "suheb-myapp.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "83.110.79.239/32"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "Gr33n@pple123456"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "myapp-VPC"
}

variable "Zone1" {
  default = "me-south-1a"
}

variable "Zone2" {
  default = "me-south-1b"
}

variable "Zone3" {
  default = "me-south-1c"
}

variable "VpcCIDR" {
  default = "172.21.0.0/16"
}


variable "PubSub1CIDR" {
  default = "172.21.1.0/24"
}

variable "PubSub2CIDR" {
  default = "172.21.2.0/24"
}

variable "PubSub3CIDR" {
  default = "172.21.3.0/24"
}

variable "PrivSub1CIDR" {
  default = "172.21.4.0/24"
}

variable "PrivSub2CIDR" {
  default = "172.21.5.0/24"
}

variable "PrivSub3CIDR" {
  default = "172.21.6.0/24"
}