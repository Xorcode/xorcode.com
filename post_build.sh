#!/usr/bin/env bash

# Based on https://github.com/wet-boew/wet-boew/blob/master/build/post_build.sh

start=$(date +%s)
echo -e "Current repo: $TRAVIS_REPO_SLUG\n"

function error_exit
{
  echo -e "\e[01;31m$1\e[00m" 1>&2
  exit 1
}

if [ "$POST_BUILD" == "true" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] &&  [ "$TRAVIS_REPO_SLUG" == "Xorcode/xorcode.com" ]; then
  #Set git user
  git config --global user.email "tbjers@xorcode.com"
  git config --global user.name "Travis"

  echo -e "Setting up Github Pages configuration for Octopress"
  rake setup_github_pages[https://${GH_TOKEN}@github.com/Xorcode/xorcode.github.io] # 2> /dev/null || error_exit "Error setting up Octopress for Github Pages";
  echo -e "Generating site and deploying to Github Pages"
  rake generate # 2> /dev/null || error_exit "Error generating site";
  rake deploy # 2> /dev/null || error_exit "Error deploying site to Github Pages";
fi
