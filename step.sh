#!/bin/bash
set -ex

# Ensure AppCenter CLI installed
if which appcenter > /dev/null; then
  echo "AppCenter CLI already installed."
else
  echo "AppCenter CLI is not installed. Installing..."
  npm install -g appcenter-cli
fi

# Change the working dir if necessary
if [ ! -z "${react_native_project_root}" ] ; then
    echo "==> Switching to react native project root: ${react_native_project_root}"
    cd "${react_native_project_root}"
    if [ $? -ne 0 ] ; then
        echo " [!] Failed to switch to react native project root: ${react_native_project_root}"
        exit 1
    fi
fi

appcenter codepush release-react -a $app_id --token $api_token --quiet --description "${description}" --deployment-name "${deployment}" --rollout $percentage $private_key $options

exit 0
