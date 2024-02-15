#!/bin/bash

# Shows the labels.
function showLabel() {
  if [[ "$0" == *"undeploy.sh"* ]]; then
    echo "** Undeploy **"
  elif [[ "$0" == *"deploy.sh"* ]]; then
    echo "** Deploy **"
  fi

  echo
}

# Shows the banner.
function showBanner() {
  if [ -f "banner.txt" ]; then
    cat banner.txt
  fi

  showLabel
}

# Prepares the environment to execute the commands of this script.
function prepareToExecute() {
  # Required files/paths.
  export WORK_DIR="$PWD/iac"
  export CREDENTIALS_FILENAME="$WORK_DIR"/.credentials

  # Required binaries.
  export TERRAFORM_CMD=$(which terraform)

  # Environment variables.
  export TF_VAR_credentialsFilename="$CREDENTIALS_FILENAME"
}

prepareToExecute