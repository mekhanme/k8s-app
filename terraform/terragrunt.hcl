remote_state {
  backend    = "s3"

  generate   = {
    path        = "backend.tf"
    if_exists   = "overwrite_terragrunt"
  }

  config   = {
    bucket                            = "stateterraform"
    key                               = "k8s/${path_relative_to_include()}/terraform.tfstate"
    region                            = "ru-central1-a"
    endpoint                          = "https://storage.yandexcloud.net"
    skip_region_validation            = true
    skip_credentials_validation       = true
    skip_metadata_api_check           = true
    encrypt                           = false
    skip_bucket_versioning            = true
    skip_bucket_ssencryption          = true
    skip_bucket_accesslogging         = true
    skip_bucket_root_access           = true
    enable_lock_table_ssencryption    = false
    skip_credentials_validation       = true
    skip_metadata_api_check           = true
    force_path_style                  = false
  }
}
