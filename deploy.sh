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

# Deploys the infrastructure based on IaC files.
function deploy() {
  $TERRAFORM_CMD init \
                 -upgrade \
                 -migrate-state || exit 1

  $TERRAFORM_CMD plan || exit 1

  $TERRAFORM_CMD apply \
                 -auto-approve
}

# Main functions.
function main() {
  prepareToExecute
  checkDependencies
  deploy
}

main