terraform {
  source   = "git::git@github.com:mekhanme/yc-kms-key-terraform-module.git"
}

inputs   = {
  name                = "k8s-kms-symmetric-key"
  default_algorithm   = "AES_128"
  rotation_period     = "8760h"
  token               = get_env("YC_TOKEN")
  cloud_id            = get_env("YC_CLOUD_ID")
  folder_id           = get_env("YC_FOLDER_ID")
}
