#!/bin/bash

# Shows the labels.
function showLabel() {
  if [[ "$0" == *"undeploy.sh"* ]]; then
    echo "** Undeploy ** "
  elif [[ "$0" == *"deploy.sh"* ]]; then
    echo "** Deploy ** "
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

# Gets a credential value.
function getCredential() {
  if [ -f "$CREDENTIALS_FILENAME" ]; then
    value=$(awk -F'=' '/'$1'/,/^\s*$/{ if($1~/'$2'/) { print substr($0, length($1) + 2) } }' "$CREDENTIALS_FILENAME" | tr -d '"' | tr -d ' ')
  else
    value=
  fi

  echo "$value"
}

# Prepares the environment to execute the commands of this script.
function prepareToExecute() {
  # Required files/paths.
  export WORK_DIR="$PWD/iac"
  export CREDENTIALS_FILENAME="$WORK_DIR"/.credentials

  # Required binaries.
  export TERRAFORM_CMD=$(which terraform)

  # Environment variables.
  export TF_VAR_linodeToken=$(getCredential "linode" "token")
  export TF_VAR_edgeGridAccountKey=$(getCredential "edgegrid" "account_key")
  export TF_VAR_edgeGridHost=$(getCredential "edgegrid" "host")
  export TF_VAR_edgeGridAccessToken=$(getCredential "edgegrid" "access_token")
  export TF_VAR_edgeGridClientToken=$(getCredential "edgegrid" "client_token")
  export TF_VAR_edgeGridClientSecret=$(getCredential "edgegrid" "client_secret")
}

prepareToExecute