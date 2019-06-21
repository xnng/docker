#!/bin/bash
# deploy shell script for jenkins
REPO_URL='git@github.com:xnng/test.git'
REPO_NAME='test'
REPO_BRANCH='dev'

if [ ! -d $REPO_NAME ]
then
  git clone -b $REPO_BRANCH $REPO_URL \
  && cd $REPO_NAME
else 
  cd $REPO_NAME \
  && git pull origin $REPO_BRANCH
fi

docker-compose up -d --build