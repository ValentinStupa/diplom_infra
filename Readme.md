1. Сперва выполнить код для создания s3 bucket для возможности хранения tfstate. \
   Выполнить код из папки: [terraform-s3](./terraform-s3/src/)

---

> [!NOTE]
> Ваш сервисный аккаунт для работы с кодом terraform должен иметь роли в каталоге облака: <span style="color:red">resource-manager.admin/editor/iam.serviceAccounts.admin</span> чтобы иметь возможноть выдавать роли

---

> [!IMPORTANT]
> Если при первичном запуке получили ошибку:
> Выполните повторно `terraform apply`

```
yandex_resourcemanager_folder_iam_member.admin-account-iam: Creation complete after 3s [id=b1gh8bteigivrl6bj21r/editor/serviceAccount:ajeatls95pa9341ih1ul]
╷
│ Error: error getting storage client: failed to get default storage client
│
│   with yandex_storage_bucket.s3-bucket,
│   on s3-bucket.tf line 17, in resource "yandex_storage_bucket" "s3-bucket":
│   17: resource "yandex_storage_bucket" "s3-bucket" {
```

2. Подготовить инфраструктуру. \
   Инициализировать проект в папке: [terraform-infra](./terraform-infra/src/) с использованием ключей от s3 bucket. Можно взять из tfstate прошлого шага.

```
terraform init -backend-config="access_key=YOUR_KEY" -backend-config="secret_key=YOUR_KEY"
```