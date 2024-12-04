# // Создание статического ключа доступа
# resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
#   service_account_id = var.cloud_id
#   description        = "static access key for object storage"
# }

# resource "yandex_kms_symmetric_key" "key-a" {
#   name              = "example-symetric-key"
#   description       = "description for key"
#   default_algorithm = "AES_128"
#   rotation_period   = "8760h" // equal to 1 year
#   folder_id         = var.folder_id

# }
// Создание публичного bucket и его шифрование(опционально)
#   https://yandex.cloud/en/docs/storage/operations/buckets/create
resource "yandex_storage_bucket" "s3-bucket" {
  bucket    = "s3--tfstate"
  folder_id = var.folder_id
  #   access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  #   secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  default_storage_class = "STANDARD"
  max_size              = 1048576 # ~1Gb
  force_destroy         = true    # Allows to delete bucket if it's not empty

  anonymous_access_flags {
    read        = false
    list        = false
    config_read = false
  }
  #   server_side_encryption_configuration {
  #     rule {
  #       apply_server_side_encryption_by_default {
  #         kms_master_key_id = yandex_kms_symmetric_key.key-a.id
  #         sse_algorithm     = "aws:kms"
  #       }
  #     }
  #   }
}
