terraform {
  source   = "git::git@github.com:mekhanme/yc-vpc-terraform-module.git"
}

inputs   = {
  network     = {
    name      = "k8s"
  }
  subnets     = {
    a   = {
      name    = "k8s-a"
      zone    = "ru-central1-a"
      block   = "10.20.1.0/24"
    }
    b   = {
      name    = "k8s-b"
      zone    = "ru-central1-b"
      block   = "10.20.2.0/24"
    }
    c   = {
      name    = "k8s-c"
      zone    = "ru-central1-c"
      block   = "10.20.3.0/24"
    }
  }
  token       = get_env("YC_TOKEN")
  cloud_id    = get_env("YC_CLOUD_ID")
  folder_id   = get_env("YC_FOLDER_ID")
}
