#!/bin/bash

for repo in $(find /tmp/workspace/repositories -maxdepth 1 -mindepth 1 -type d)
do
  echo $repo
done

#mkdir -p /tmp/workspace/html_pages/
#cd /app
#node html_page_generator.js -f /tmp/workspace/repositories/OSLOthema-test/standaardenregister.json -o /tmp/workspace/html_pages

#TODO generator aanpassen zodat volledige naam van het bestand moet meegegeven worden!
