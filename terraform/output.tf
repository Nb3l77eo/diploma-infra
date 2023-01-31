output "external_ip_address_mgmt_node" {
  value = "${yandex_compute_instance.mgmt_node.network_interface.0.nat_ip_address}"
}