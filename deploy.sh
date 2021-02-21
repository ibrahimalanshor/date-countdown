#!/usr/bin/env sh

# abort on errors

set -e

# build

npm run build

# nav to build output dir

cd dist

git init
git add -A
git commit -m "deploy"
git push -f git@github.com:ibrahimalanshor/date-countdown.git master:gh-pages

cd -