#!/bin/bash

set -o xtrace

scripts/bootstrap-roles.sh
scripts/bootstrap-inventory.sh
scripts/bootstrap-jira.sh
