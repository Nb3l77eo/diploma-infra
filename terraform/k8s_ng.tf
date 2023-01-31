resource "yandex_kubernetes_node_group" "k8s_ng_a" {
  cluster_id = yandex_kubernetes_cluster.k8s_regional.id
  name = "ng-a-${terraform.workspace}"
  instance_template {
    platform_id = "standard-v2"
    container_runtime {
      type = "containerd"
    }
    resources {
      memory = local.res_memory[terraform.workspace]
      cores = local.res_cores[terraform.workspace]
      core_fraction = local.res_cfraction[terraform.workspace]
    }
    boot_disk {
      type = "network-hdd"
      size = local.boot_disk_size[terraform.workspace]
    }
    network_interface {
      subnet_ids  = [yandex_vpc_subnet.subnet_a.id]
      nat        = false
    }
    metadata = {
      ssh-keys = "${var.username_def}:${var.ssh_key}"
    }
    scheduling_policy {
      preemptible = local.preemptible [terraform.workspace]
    }
  }
  scale_policy {
    auto_scale {
      min = local.scale_policy_min[terraform.workspace]
      max = local.scale_policy_max[terraform.workspace]
      initial = local.scale_policy_init[terraform.workspace]
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }
}

resource "yandex_kubernetes_node_group" "k8s_ng_b" {
  cluster_id = yandex_kubernetes_cluster.k8s_regional.id
  name = "ng-b-${terraform.workspace}"
  instance_template {
    platform_id = "standard-v2"
    container_runtime {
      type = "containerd"
    }
    resources {
      memory = local.res_memory[terraform.workspace]
      cores = local.res_cores[terraform.workspace]
      core_fraction = local.res_cfraction[terraform.workspace]
    }
    boot_disk {
      type = "network-hdd"
      size = local.boot_disk_size[terraform.workspace]
    }
    network_interface {
      subnet_ids  = [yandex_vpc_subnet.subnet_b.id]
      nat        = false
    }
    metadata = {
      ssh-keys = "${var.username_def}:${var.ssh_key}}"
    }
    scheduling_policy {
      preemptible = local.preemptible [terraform.workspace]
    }
  }
  scale_policy {
    auto_scale {
      min = local.scale_policy_min[terraform.workspace]
      max = local.scale_policy_max[terraform.workspace]
      initial = local.scale_policy_init[terraform.workspace]
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }
}

resource "yandex_kubernetes_node_group" "k8s_ng_c" {
  cluster_id = yandex_kubernetes_cluster.k8s_regional.id
  name = "ng-c-${terraform.workspace}"
  instance_template {
    platform_id = "standard-v2"
    container_runtime {
      type = "containerd"
    }
    resources {
      memory = local.res_memory[terraform.workspace]
      cores = local.res_cores[terraform.workspace]
      core_fraction = local.res_cfraction[terraform.workspace]
    }
    boot_disk {
      type = "network-hdd"
      size = local.boot_disk_size[terraform.workspace]
    }
    network_interface {
      subnet_ids  = [yandex_vpc_subnet.subnet_c.id]
      nat        = false
    }
    metadata = {
      ssh-keys = "${var.username_def}:${var.ssh_key}}"
    }
    scheduling_policy {
      preemptible = local.preemptible [terraform.workspace]
    }
  }
  scale_policy {
    auto_scale {
      min = local.scale_policy_min[terraform.workspace]
      max = local.scale_policy_max[terraform.workspace]
      initial = local.scale_policy_init[terraform.workspace]
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-c"
    }
  }
}