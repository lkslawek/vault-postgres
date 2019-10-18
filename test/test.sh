#!/bin/bash

export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=$(cd ../stage1; terraform output vault_root_token)

envconsul -config config.hcl ./_psql.sh
