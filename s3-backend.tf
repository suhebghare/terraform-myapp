terraform {
  backend "s3" {
    bucket = "suhana2507"
    key    = "terraform/backend"
    region = "me-south-1"
  }
}