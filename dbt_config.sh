#!/bin/bash

# Run `source dbt_config.sh` to correct dbt config

export DBT_TARGET="postgres"
export PG_ADDRESS="postgres-db.cauam24mhfkz.eu-west-2.rds.amazonaws.com"
export PG_PORT="5432"
export PG_USERNAME="postgres"
export PG_PASSWORD="postgres1234"
export PG_DATABASE="movies_db"
export DBT_SOURCE_SCHEMA="admin"
export DBT_TARGET_SCHEMA="public"