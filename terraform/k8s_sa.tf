
resource "yandex_iam_service_account" "sa_k8s" {
  name        = local.sa_name[terraform.workspace]
  description = "K8S regional service account"
  folder_id = var.YC_folder_id
}


resource "yandex_resourcemanager_folder_iam_member" "sa_k8s_roles" {
  for_each = toset([
    # Сервисному аккаунту назначается роль "admin"
    "admin",
    # Сервисному аккаунту назначается роль "iam.admin".
    "iam.admin",
    # Сервисному аккаунту назначается роль "k8s.clusters.agent"
    "k8s.clusters.agent",
    # Сервисному аккаунту назначается роль "vpc.publicAdmin"
    "vpc.publicAdmin",
    # Сервисному аккаунту назначается роль "container-registry.images.puller"
    "container-registry.images.puller",
  ])  
   
  folder_id = var.YC_folder_id
  role      = each.key
  member =  "serviceAccount:${yandex_iam_service_account.sa_k8s.id}"
}


resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms_key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_k8s.id}",
  ]
}
