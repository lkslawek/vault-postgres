data "terraform_remote_state" "stage1" {
  backend = "local"

  config = {
    path = "${path.module}/../stage1/terraform.tfstate"
  }
}

provider "vault" {
  version = "~> 2.5"

  address = "http://127.0.0.1:8200"
  token = data.terraform_remote_state.stage1.outputs.vault_root_token
}
