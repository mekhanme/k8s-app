include {
  path   = find_in_parent_folders()
}

terraform {
  source   = "git::git@github.com:mekhanme/yc-k8s-cluster-terraform-module.git"
}

dependency "vpc" {
  config_path   = "../vpc"
}

dependency "service-account" {
  config_path   = "../service-account"
}

dependency "kms-key" {
  config_path   = "../kms-key"
}

inputs   = {
  name                      = "k8s-cluster"
  node_platform_id          = "standard-v2"
  kubernetes_version        = "1.21"
  release_channel           = "RAPID"
  network_policy_provider   = "CALICO"
  container_runtime         = "containerd"
  node_group_size           = 1
  network   = {
    name        = dependency.vpc.outputs.network_name
    region      = "ru-central1"
    public_ip   = true
  }
  subnets     = {
    a   = {
      name    = dependency.vpc.outputs.subnet-name.a
      zone    = dependency.vpc.outputs.subnet-zone.a
    }
    b   = {
      name    = dependency.vpc.outputs.subnet-name.b
      zone    = dependency.vpc.outputs.subnet-zone.b
    }
    c   = {
      name    = dependency.vpc.outputs.subnet-name.c
      zone    = dependency.vpc.outputs.subnet-zone.c
    }
  }
  resources   = {
    memory          = 2
    cores           = 2
    core_fraction   = 5
  }
  boot_disk   = {
    type   = "network-ssd"
    size   = 30
  }
  key_id                    = dependency.kms-key.outputs.key_id
  node_service_account      = dependency.service-account.outputs.sa_id
  cluster_service_account   = dependency.service-account.outputs.sa_id
  token                     = get_env("YC_TOKEN")
  cloud_id                  = get_env("YC_CLOUD_ID")
  folder_id                 = get_env("YC_FOLDER_ID")
}
