

resource "yandex_kubernetes_cluster" "k8s_regional" {
  name = "k8s-${terraform.workspace}"
  network_id = yandex_vpc_network.network.id
  master {
    version = local.k8s_version

    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.subnet_a.zone
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }
      location {
        zone      = yandex_vpc_subnet.subnet_b.zone
        subnet_id = yandex_vpc_subnet.subnet_b.id
      }
      location {
        zone      = yandex_vpc_subnet.subnet_c.zone
        subnet_id = yandex_vpc_subnet.subnet_c.id
      }
    }
    security_group_ids = [yandex_vpc_security_group.k8s_main_sg.id]
  }
  service_account_id      = yandex_iam_service_account.sa_k8s.id
  node_service_account_id = yandex_iam_service_account.sa_k8s.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.sa_k8s_roles
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms_key.id
  }

  timeouts {
    create = "1h30m" # Полтора часа
    update = "2h"    # 2 часа
    delete = "30m"   # 30 минут
  }
}


resource "yandex_kms_symmetric_key" "kms_key" {
  # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = "kms-key-${terraform.workspace}"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

resource "yandex_vpc_security_group" "k8s_main_sg" {
  name        = "k8s-main-sg-${terraform.workspace}"
  description = "Правила группы обеспечивают базовую работоспособность кластера. Примените ее к кластеру и группам узлов."
  network_id  = yandex_vpc_network.network.id
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера и сервисов."
    v4_cidr_blocks    = concat(yandex_vpc_subnet.subnet_a.v4_cidr_blocks, yandex_vpc_subnet.subnet_b.v4_cidr_blocks, yandex_vpc_subnet.subnet_c.v4_cidr_blocks, yandex_vpc_subnet.subnet_mgmt_a.v4_cidr_blocks)
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ICMP"
    description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
    v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 30000
    to_port           = 32767
  }
  egress {
    protocol          = "ANY"
    description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}