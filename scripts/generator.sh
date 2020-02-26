#!/bin/bash

RESULTDIR=/tmp/workspace/html_pages
REPODIR=/tmp/workspace/repositories

mkdir -p "$RESULTDIR"

for repo in $(find "$REPODIR" -maxdepth 1 -mindepth 1 -type d)
do
  THEME_NAME=$(echo $repo | cut -d "/" -f 4 | cut -d "-" -f 2)
  echo $THEME_NAME
done

#mkdir -p /tmp/workspace/html_pages/
#cd /app
#node html_page_generator.js -f /tmp/workspace/repositories/OSLOthema-test/standaardenregister.json -o /tmp/workspace/html_pages

#TODO generator aanpassen zodat volledige naam van het bestand moet meegegeven worden!
