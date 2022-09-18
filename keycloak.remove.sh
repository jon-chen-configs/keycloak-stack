#!/bin/sh

WD=$(dirname $0)
SCRIPTS_DIR=${WD}/../../scripts
export STACK_NAME=keycloak-swarm

${SCRIPTS_DIR}/stack.remove.sh
