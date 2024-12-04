#   Create service account to manage cloud resources
#   https://yandex.cloud/ru/docs/iam/operations/sa/create

resource "yandex_iam_service_account" "sa" {
  name        = "terraform-user"
  description = "User to create resources in Cloud"
  folder_id   = var.folder_id
}

#   Assign role the new service user
#   https://yandex.cloud/ru/docs/iam/operations/sa/assign-role-for-sa

resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

#   Create static key
#   https://yandex.cloud/ru/docs/iam/operations/sa/create-access-key

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static key"
  #pgp_key            = "keybase:keybaseusername"
}
