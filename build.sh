#!/bin/bash

echo "Branch: ${GIT_BRANCH}"

echo "Installing Dependencies..."
npm install || exit 1

echo "Removing old builds..."
rm -rvf dist/*

echo "Building applications..."
ng build --base-href / || exit 1

echo "Droping old apps from server"
ssh root@162.241.90.60 'rm -rvf /var/www/html/*'

echo "Deploying application on EC2..."
rsync -avzP dist/keyshell/* root@162.241.90.60:/var/www/html/

if [ $? -eq 0 ]; then
    echo "Deployed the apps successfully"
fi
