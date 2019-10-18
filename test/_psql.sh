#!/bin/bash

docker run \
	--env PGUSER="$PGUSERNAME" \
	--env PGPASSWORD="$PGPASSWORD" \
	--env PGHOST=postgres \
        --env PGDATABASE=postgres \
	--network vaulted \
	--tty \
	--interactive \
	postgres:12.0-alpine psql
