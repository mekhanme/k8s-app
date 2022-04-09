terraform {
  source = "git::git@github.com:mekhanme/yc-service-account-terraform-module.git"
}

inputs   = {
  name        = "k8s-admin-sa"
  roles       = [
    "admin"
  ]
  token       = get_env("YC_TOKEN")
  cloud_id    = get_env("YC_CLOUD_ID")
  folder_id   = get_env("YC_FOLDER_ID")
}
