#!/bin/bash

# Checks the dependencies to run this script.
function checkDependencies() {
  if [ -z "$TERRAFORM_CMD" ]; then
    echo "Terraform is not installed! Please install it first to continue!"

    exit 1
  fi
}

# Prepares the environment to run this script.
function prepareToExecute() {
  source functions.sh

  showBanner

  cd iac || exit 1
}

# Undeploys the provisioned infrastructure.
function undeploy() {
  $TERRAFORM_CMD init \
                 -upgrade \
                 -migrate-state || exit 1

  $TERRAFORM_CMD destroy \
                 -auto-approve
}

# Main functions.
function main() {
  prepareToExecute
  checkDependencies
  undeploy
}

main