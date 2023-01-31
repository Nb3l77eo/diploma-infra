locals {

  # Описание подсетей для различных workspace
  subnet-a-cidr = {
    stage = "10.1.0.0/16"
    prod = "10.2.0.0/16"
  }

  subnet-b-cidr = {
    stage = "10.3.0.0/16"
    prod = "10.4.0.0/16"
  }

  subnet-c-cidr = {
    stage = "10.5.0.0/16"
    prod = "10.6.0.0/16"
  }

  subnet-mgmt-a-cidr = {
    stage = "10.253.0.0/16"
    prod = "10.254.0.0/16"
  }

# Шаблон для ControlPlane K8S


# K8S locals
  k8s_version = "1.22"
  
  sa_name = {
    stage = "sastage"
    prod = "saprod"
  }

# Парамеры для yandex_kubernetes_node_group
  scheduling_policy = {
    stage = true
    prod = true
  }

  res_cores = {
    stage = 2
    prod = 2
  }

  res_memory = {
    stage = 6
    prod = 6
  }

  res_cfraction = {
    # Core fraction
    stage = 20
    prod = 100
  }

  boot_disk_size = {
    # 
    stage = 40
    prod = 40
  }

  scale_policy_min = {
    # 
    stage = 1
    prod = 1
  }

  scale_policy_max = {
    # 
    stage = 3
    prod = 3
  }

  scale_policy_init = {
    # 
    stage = 1
    prod = 1
  }

  preemptible = {
    # 
    stage = true
    prod = false
  }

}