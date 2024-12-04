1. Сперва выполнить код для создания s3 bucket для возможности хранения tfstate. \
    Выполнить код из папки: [terraform-s3](./terraform-s3/src/)
---
> [!IMPORTANT]
> Ваш сервисный аккаунт для работы с кодом terraform должен иметь роли в каталоге облака: <span style="color:red">resource-manager.admin/editor/iam.serviceAccounts.admin</span> чтобы иметь возможноть выдавать роли
---

2. Подготовить инфраструктуру. \
    Инициализировать проект в папке: [terraform-infra](./terraform-infra/src/) с использованием ключей от s3 bucket. Можно взять из tfstate прошлого шага.
```
terraform init -backend-config="access_key=YOUR_KEY" -backend-config="secret_key=YOUR_KEY"
```
