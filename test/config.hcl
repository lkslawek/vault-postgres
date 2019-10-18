upcase = true

vault {
  renew_token = false
}

secret {
  path = "database/creds/admin"
  no_prefix = true
  format = "PG{{ key }}"
}
