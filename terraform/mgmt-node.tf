resource "yandex_iam_service_account" "mgmt_sa" {
  name        = "mgmt-sa-${terraform.workspace}"
  description = "k8s admin SA mgmt"
}

resource "yandex_resourcemanager_folder_iam_member" "mgmt_sa_editor" {
  for_each = toset([
    # Сервисному аккаунту назначается роль "editor"
    "editor",
  ])  
   
  folder_id = var.YC_folder_id
  role      = each.key
  member =  "serviceAccount:${yandex_iam_service_account.mgmt_sa.id}"
}


resource "yandex_compute_instance" "mgmt_node" {
  name                      = "mgmt-node-${terraform.workspace}"
  zone                      = var.YC_zone
  hostname                  = "mgmt-node-${terraform.workspace}.netology.yc"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  service_account_id = yandex_iam_service_account.mgmt_sa.id

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8hqa9gq1d59afqonsf" #https://cloud.yandex.ru/marketplace/products/yc/centos-7
      name        = "mgmt-node-${terraform.workspace}"
      #type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet_mgmt_a.id
    nat        = true
    # ip_address = "192.168.101.5"
  }

  metadata = {
    user-data = data.template_file.mgmt_meta.rendered
  }

  scheduling_policy {
    preemptible = true
  }

  depends_on = [
    data.template_file.mgmt_meta
  ]
}



