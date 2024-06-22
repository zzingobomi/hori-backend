#!/usr/bin/env bash
set -e

# /opt/wait-for-it.sh postgres:5432
# /opt/wait-for-it.sh hori-database-service:5432
# /opt/wait-for-it.sh mysql:3306
/opt/wait-for-it.sh mysql-cluster.mysql-cluster.svc.cluster.local:3306
npm run migration:run
npm run seed:run:relational
npm run start:prod
