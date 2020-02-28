#!/bin/bash

ROOTDIR=/tmp/workspace
RESULTDIR=/tmp/workspace/html_pages
REPODIR=/tmp/workspace/repositories

mkdir -p "$RESULTDIR/erkende-standaard"
mkdir -p "$RESULTDIR/standaard-in-ontwikkeling"
mkdir -p "$RESULTDIR/kandidaat-standaard"

mkdir -p "$RESULTDIR"
cd /app

for REPO in $(find "$REPODIR" -maxdepth 1 -mindepth 1 -type d)
do
  THEME_NAME=$(echo "$REPO" | cut -d "/" -f 5 | cut -d "-" -f 2,3)
  DESCRIPTION="$ROOTDIR/descriptions/$THEME_NAME-description.html"
  STATUS=$(cat "$ROOTDIR/status.txt" | grep "$THEME_NAME" | cut -d ":" -f 2)

  if test -f "$DESCRIPTION" ; then
    echo "A description was provided for the $THEME_NAME repository"
    node html_page_generator.js -f "$REPO/config.json" -o "$RESULTDIR/$STATUS/$THEME_NAME-index.html" -t "$ROOTDIR/descriptions/$THEME_NAME-description.html"
  else
    echo "No description was provided for the $THEME_NAME repository"
    node html_page_generator.js -f "$REPO/config.json" -o "$RESULTDIR/$STATUS/$THEME_NAME-index.html"
  fi
done

