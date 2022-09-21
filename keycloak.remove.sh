#!/bin/sh

WD="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SCRIPTS_DIR=${WD}/../../scripts
export STACK_NAME=keycloak-swarm

${SCRIPTS_DIR}/stack.remove.sh
