# Variables
# variable "aws_access_key" {
#   type = string
# }

# variable "aws_secret_key" {
#   type = string
# }

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

# Sources (Builders)
source "amazon-ebs" "demo" {
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
  region                  = "ap-southeast-1"
  source_ami              = "ami-0df7a207adb9748c7"
  instance_type           = "t2.large"
  temporary_key_pair_type = "ed25519"
  ssh_username            = "ubuntu"
  ami_name                 = "packer-demo-ami-${local.timestamp}"
}
build {
  sources = [
    "source.amazon-ebs.demo",
  ]

  # Source AMI Filter
  source_ami_filter {
    filters = {
      name               = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
      root-device-type   = "ebs"
    }
    owners = ["099720109477"]
    most_recent = true
  }

  # Provisioners
  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx",
    ]
  }

  # Post-processors
  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
  }
}
/*
# Builds
build {
  sources = [
    "source.amazon-ebs.demo",
  ]

  # Provisioners
  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx",
    ]
  }

  # Post-processors
  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
  }
}
*/
