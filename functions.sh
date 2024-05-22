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
  if [ -f "$3" ]; then
    value=$(awk -F'=' '/'$1'/,/^\s*$/{ if($1~/'$2'/) { print substr($0, length($1) + 2) } }' "$3" | tr -d '"' | tr -d ' ')
  else
    value=
  fi

  echo "$value"
}

# Prepares the environment to execute the commands of this script.
function prepareToExecute() {
  # Required files/paths.
  WORK_DIR="$PWD/iac"
  CREDENTIALS_FILENAME="$WORK_DIR"/.credentials

  # Environment variables.
  if [ -f "$CREDENTIALS_FILENAME" ]; then
    export TF_VAR_linodeToken=$(getCredential "linode" "token" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridAccountKey=$(getCredential "edgegrid" "account_key" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridHost=$(getCredential "edgegrid" "host" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridAccessToken=$(getCredential "edgegrid" "access_token" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridClientToken=$(getCredential "edgegrid" "client_token" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridClientSecret=$(getCredential "edgegrid" "client_secret" "$CREDENTIALS_FILENAME")
  else
    CREDENTIALS_FILENAME=~/.aws/credentials

    export TF_VAR_linodeToken=$(getCredential "default" "token" "$CREDENTIALS_FILENAME")

    CREDENTIALS_FILENAME=~/.edgerc

    export TF_VAR_edgeGridAccountKey=$(getCredential "default" "account_key" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridHost=$(getCredential "default" "host" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridAccessToken=$(getCredential "default" "access_token" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridClientToken=$(getCredential "default" "client_token" "$CREDENTIALS_FILENAME")
    export TF_VAR_edgeGridClientSecret=$(getCredential "default" "client_secret" "$CREDENTIALS_FILENAME")
  fi

  # Required binaries.
  export TERRAFORM_CMD=$(which terraform)
}

prepareToExecute