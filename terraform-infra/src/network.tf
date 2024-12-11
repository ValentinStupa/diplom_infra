resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop-a" {
  name           = "${var.vpc_name}-a"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = "${var.vpc_name}-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

#   Just create but not using because of the error: "platform "standard-v1" is unavailable in zone "ru-central1-d""
# resource "yandex_vpc_subnet" "develop-d" {
#   name           = "${var.vpc_name}-d"
#   zone           = "ru-central1-d"
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = ["10.0.3.0/24"]
# }
