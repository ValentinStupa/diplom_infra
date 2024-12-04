#---------------------------------
data "yandex_compute_image" "image" {
  #family = "centos-7"
  #family = "almalinux-8"
  family = var.vpc_image
}
#---------------------------------
resource "yandex_compute_instance" "vm_1" {
  name        = "k8s-master"
  platform_id = var.vpc_platform_id
  zone        = yandex_vpc_subnet.develop-a.zone
  #zone        = "ru-central-d"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = var.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vm_2" {
  name        = "k8s-worker-1"
  platform_id = var.vpc_platform_id
  zone        = yandex_vpc_subnet.develop-b.zone
  #zone = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = var.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vm_3" {
  name        = "k8s-worker-2"
  platform_id = var.vpc_platform_id
  zone        = yandex_vpc_subnet.develop-b.zone
  #zone = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = var.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
# resource "local_file" "ansible_host" {
#   content = templatefile("${path.module}/hosts.tftpl",
#     {
#       clickhouse = yandex_compute_instance.clickhouse.*,
#       vector     = yandex_compute_instance.vector.*,
#       lighthouse = yandex_compute_instance.lighthouse.*
#   })
#   filename = "../../playbook/inventory/hosts.list"
# }
