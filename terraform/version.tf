terraform {
  required_providers {
    yandex = {
      # source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  
  # backend "s3" {
  #   endpoint   = "storage.yandexcloud.net"
  #   bucket     = "deplomanb3l77eo"
  #   region     = "ru-central1"
  #   key        = "env.tfstate"
  #   # access_key = 
	#   #Use export AWS_ACCESS_KEY_ID=...
  #   # secret_key = 
	#   #Use export AWS_SECRET_ACCESS_KEY=...

  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  # }

  cloud {
    organization = "qqwe"
      workspaces {
        name = "stage"
      }
  }
}
