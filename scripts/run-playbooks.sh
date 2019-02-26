#!/bin/bash

set -o xtrace

ansible-playbook -i inventory/jira.aio playbooks/setup-everything.yml
