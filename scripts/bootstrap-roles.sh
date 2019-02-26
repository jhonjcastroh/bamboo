#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Fetch all roles with latest version.
rm -rf roles
git checkout -- roles
git submodule init
git submodule update --remote

# Setup submodule precisely for development.
ls -1d $DIR/../roles/* | while read line; do
    cd $line

    git remote -v | grep push | grep http | while read remote; do
        remote=`echo $remote | sed 's/^.*http[s]*:\/\/\([^\/]*\)\/\(.*\.git\).*$/git\@\1:\2/g'`
        git remote set-url --push origin $remote
    done

    git branch -r | grep origin | grep -v HEAD | while read branch; do
        branch=`echo $branch | sed 's/^origin\///g'`
        git checkout $branch
        git reset --hard @{upstream}
        git clean -fdx
        git pull
    done

    git flow init -fd

    git checkout master
done
