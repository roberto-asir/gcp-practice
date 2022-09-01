terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.30.0"
    }
  }
}

provider "google" {
  credentials = file("cred.json")

  project = "practica-gcp-roberto"

  region = "europe-west1"

  zone = "europe-west1-d"
}

variable "vpc_network_name" {
  description = "Nombre de la red"
  default = "red-practica-terraform"
}

variable "ip_estatica_name" {
  description = "IP estática para la red"
  default = "mi-ip"
}

variable "mi_bucket_location" {
  description = "Localización para el bucket de la MV"
  default = "EUROPE-WEST3"
}

variable "mi_mv_name" {
  description = "Nombre de la máquina virtual"
  default = "mi-mv"
}

variable "mi_mv_type" {
  description = "Tipo de MV"
  default = "e2-medium"
}

variable "mi_mv_tags" {
  description = "Tags para la MV"
  type = list(string)
  default = ["web", "dev"]
}

variable "mi_mv_hostanme" {
  description = "Nombre local de máquina"
  default = "practica-gcp.mv"
}

variable "mi_mv_disk_name" {
  description = "Nombre del disco en GC"
  default = "mi_disco"
}

variable "mi_mv_type_disk" {
  description = "Tipo de disco para la MV"
  default = "pd-ssd"
}


resource "random_string" "texto" {
  length = 9
  special = false
  upper = false
}

resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
}

resource "google_compute_address" "ip_estatica" {
  name = var.ip_estatica_name
  address_type = "EXTERNAL"
}



resource "google_storage_bucket" "mi_bucket" {
  name = "mi_bucket-${random_string.texto.result}"  
  location = var.mi_bucket_location
}


resource "google_compute_instance" "mi_maquina" {
  depends_on = [google_compute_network.vpc_network, google_compute_address.ip_estatica]
  name = var.mi_mv_name
  machine_type = var.mi_mv_type
  hostname = var.mi_mv_hostanme
  tags = var.mi_mv_tags

  boot_disk {
    device_name = var.mi_mv_disk_name
    initialize_params {
      type = var.mi_mv_type_disk
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220712"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.ip_estatica.address
    }
  }


  metadata_startup_script = "apt update"

}
