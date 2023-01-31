
variable "infra_repo_url" {
  description = "Repo URL this project"
  type = string
  default = "https://github.com/Nb3l77eo/diploma-infra.git"
}


variable "ssh_key" {
  description = "pub ssh-key access to mgmt node"
  type = string
}


variable "YC_zone" {
  description = "YC zone name"
  type = string
}

variable "username_def" {
  description = "default user name"
  type = string
  default = "vagrant"
}


variable "YC_folder_id" {
  description = "YC folder id"
  type = string
}

variable "YC_cloud_id" {
  description = "YC cloud id"
  type = string
}

