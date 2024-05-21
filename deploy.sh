#!/bin/bash

# Checks the dependencies of this script.
function checkDependencies() {
  if [ ! -f "$CREDENTIALS_FILENAME" ]; then
    echo "The credentials filename was not found! Please finish the setup first to continue!"

    exit 1
  fi

  if [ -z "$TERRAFORM_CMD" ]; then
    echo "terraform is not installed! Please install it first to continue!"

    exit 1
  fi
}

# Prepares the environment to execute this script.
function prepareToExecute() {
  source functions.sh

  showBanner

  cd iac || exit 1
}

# Starts the provisioning based on the IaC files.
function deploy() {
  $TERRAFORM_CMD init \
                 -upgrade \
                 -migrate-state || exit 1

  $TERRAFORM_CMD plan -out /tmp/plan || exit 1

  $TERRAFORM_CMD apply \
                 -auto-approve \
                 /tmp/plan
}

# Clean-up.
function cleanUp() {
  rm -f /tmp/plan
}

# Main function.
function main() {
  prepareToExecute
  checkDependencies
  deploy
  cleanUp
}

main