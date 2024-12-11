data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username = var.username
    ssh_pub  = file("~/.ssh/dev_study.pub")
    #packages = jsonencode(var.package)
  }
}
#---------------------------------
data "yandex_compute_image" "image" {
  family = var.vpc_image
}
#---------------------------------
resource "yandex_compute_instance" "vm_1" {
  name        = "k8s-master"
  platform_id = var.vpc_platform_id
  zone        = yandex_vpc_subnet.develop-a.zone
  #zone        = "ru-central-d"
  resources {
    cores         = 4
    memory        = 4
    core_fraction = 20
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
  #metadata                  = var.metadata
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "almalinux:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
    user-data          = "#cloud-config\nusers:\n  - name: ${var.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}\npackages:\n  - vim\n  - git\n  - python3.11-pip\n  - python3.11"
  }
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
    nat       = true # Позволяет не получать внешний публичный IP if false
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
