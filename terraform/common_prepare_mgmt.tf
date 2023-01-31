
data "template_file" "mgmt_meta" {
  template = file("metadata/_mgmt_meta.tpl")

  vars = {
    YC_cloud_id = var.YC_cloud_id
    YC_folder_id = var.YC_folder_id
    k8s-id = yandex_kubernetes_cluster.k8s_regional.id
    username_def = var.username_def
    ssh_key_def = var.ssh_key
    infra_repo_url = var.infra_repo_url
  }
  depends_on = [
    yandex_kubernetes_cluster.k8s_regional
  ]
}
