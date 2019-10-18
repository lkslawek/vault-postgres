resource "docker_image" "vault" {
  name = "vault:1.2.3"
  keep_locally = true
}

resource "random_string" "vault_root_token" {
  length = 64
  special = false
}

resource "docker_container" "vault" {
  name = "vault"
  image = docker_image.vault.latest

  networks_advanced {
    name = docker_network.vaulted.name
  }

  ports {
    internal = 8200
    external = 8200
  }

  env = ["VAULT_DEV_ROOT_TOKEN_ID=${random_string.vault_root_token.result}"]
}

output "vault_root_token" {
  value = random_string.vault_root_token.result
  sensitive = true
}
