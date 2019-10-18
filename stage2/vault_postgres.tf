resource "vault_mount" "database" {
  path = "database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend = "${vault_mount.database.path}"
  name = "postgres"
  allowed_roles = ["*"]

  postgresql {
    connection_url = "postgres://postgres:${data.terraform_remote_state.stage1.outputs.postgres_password}@postgres/postgres?sslmode=disable"
  }
}

resource "vault_database_secret_backend_role" "admin" {
  backend = "${vault_mount.database.path}"
  name = "admin"
  db_name = "${vault_database_secret_backend_connection.postgres.name}"
  creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'"]
}
