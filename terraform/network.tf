
# Сеть
resource "yandex_vpc_network" "network" {
  name = "network-${terraform.workspace}"
}

# Подсети
resource "yandex_vpc_subnet" "subnet_a" {
  name = "subnet-a-${terraform.workspace}"
  v4_cidr_blocks = [local.subnet-a-cidr[terraform.workspace]]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_subnet" "subnet_b" {
  name = "subnet-b-${terraform.workspace}"
  v4_cidr_blocks = [local.subnet-b-cidr[terraform.workspace]]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_subnet" "subnet_c" {
  name = "subnet-c-${terraform.workspace}"
  v4_cidr_blocks = [local.subnet-c-cidr[terraform.workspace]]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network.id
  route_table_id = yandex_vpc_route_table.route_table.id
}


resource "yandex_vpc_subnet" "subnet_mgmt_a" {
  name = "subnet-mgmt-a-${terraform.workspace}"
  v4_cidr_blocks = [local.subnet-mgmt-a-cidr[terraform.workspace]]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  # route_table_id = yandex_vpc_gateway.nat_gateway.id
}

# Организация доступа во внешнюю сеть
resource "yandex_vpc_route_table" "route_table" {
  name        = "route-table-${terraform.workspace}"
  network_id  = yandex_vpc_network.network.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "gateway-${terraform.workspace}"
  shared_egress_gateway {}
}