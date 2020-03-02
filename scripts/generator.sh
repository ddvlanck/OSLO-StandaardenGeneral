#!/bin/bash

ROOTDIR=/tmp/workspace
RESULTDIR=/tmp/workspace/html_pages
REPODIR=/tmp/workspace/repositories

mkdir -p "$RESULTDIR/erkende-standaard"
mkdir -p "$RESULTDIR/standaard-in-ontwikkeling"
mkdir -p "$RESULTDIR/kandidaat-standaard"

mkdir -p "$RESULTDIR"

for REPO in $(find "$REPODIR" -maxdepth 1 -mindepth 1 -type d)
do
  THEME_NAME=$(echo "$REPO" | cut -d "/" -f 5 | cut -d "-" -f 2,3)
  DESCRIPTION="$ROOTDIR/descriptions/$THEME_NAME-description.html"
  STATUS=$(cat "$ROOTDIR/status.txt" | grep "$THEME_NAME" | cut -d ":" -f 2)
  CONFIG=$(cat "$ROOTDIR/configuration.txt" | grep "$THEME_NAME" | cut -d ":" -f 2)

  ## Read the config file of every standard en change the relative links of the documents to absolute links, linked to the repository itself
  ##TODO
  #cd /$REPODIR/$REPO

  ### Presentatie values
  #if [ "$(jq '.presentatie | length' "$CONFIG") " -gt "0" ]; then
  #  for k in $(jq '.presentaties | keys | .[]' "$CONFIG" ); do
  #    VALUE=$(jq -r ".presentaties[$k].waarde" vocabularium-persoon.json | cut -d "/" -f 2,3)
  #    jq ".presentaties[$k].waarde = https://github.com/ddvlanck/$REPO/blob/standaardenregister/$VALUE" "$CONFIG"
  #  done
  #fi


  cd /app
  if test -f "$DESCRIPTION" ; then
    echo "A description was provided for the $THEME_NAME repository"
    node html_page_generator.js -f "$REPO/$CONFIG" -o "$RESULTDIR/$STATUS/$(echo "$CONFIG" | cut -d "." -f 1)-index.html" -t "$ROOTDIR/descriptions/$THEME_NAME-description.html"
  else
    echo "No description was provided for the $THEME_NAME repository"
    node html_page_generator.js -f "$REPO/$CONFIG" -o "$RESULTDIR/$STATUS/$(echo "$CONFIG" | cut -d "." -f 1)-index.html"
  fi
done

