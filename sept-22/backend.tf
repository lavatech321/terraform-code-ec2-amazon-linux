terraform {
  backend "s3" {
    bucket       = "myterra-tfstate-original-bucket-1"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

