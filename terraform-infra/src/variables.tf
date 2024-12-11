###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "k8s"
  description = "VPC network & subnet name"
}

variable "vpc_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "CPU type-Platform ID "
}

variable "vpc_image" {
  type        = string
  default     = "almalinux-8"
  description = "OS image name"
}

variable "disk_size" {
  type        = string
  default     = "10"
  description = "Disk size"
}

variable "core_fraction" {
  type        = string
  default     = "5"
  description = "Percent of using of CPU"
}

variable "metadata" {
  type = map(any)
  default = {
    serial-port-enable = 1
    ssh-keys           = "almalinux:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
  }
}

variable "username" {
  type        = string
  default     = "almalinux"
  description = "Ssh user"
  validation {
    condition     = contains(["almalinux"], var.username)
    error_message = "Invalid username"
  }
}

variable "ssh_key_path" {
  type    = string
  default = "~/.ssh/dev_study.pub"
}
