#!/usr/bin/env bash
set -e

/opt/wait-for-it.sh mysql-cluster.mysql-cluster.svc.cluster.local:3306
npm run migration:run
npm run seed:run:relational
npm run start:prod
