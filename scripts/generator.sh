#!/bin/bash

#docker run -it -v /tmp/workspace/:/data ddvlanck/html-page-generator:1.0 bash
#node html_page_generator.js -f data/repositories/OSLOthema-test/standaardenregister-config.json


node /app/html_page_generator.js -f /tmp/workspace/repositories/OSLOthema-test/standaardenregister.json
