#!/bin/bash

RESULTDIR=/tmp/workspace/html_pages
REPODIR=/tmp/workspace/repositories

mkdir -p "$RESULTDIR"
cd /app

for REPO in $(find "$REPODIR" -maxdepth 1 -mindepth 1 -type d)
do
  THEME_NAME=$(echo "$REPO" | cut -d "/" -f 5 | cut -d "-" -f 2)
  node html_page_generator.js -f "$REPO"/standaardenregister.json -o "$RESULTDIR"/"$THEME_NAME"-index.html
done

