#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y --fix-missing --no-install-recommends postgresql-client nano netcat libpq-dev gcc make dpkg-dev git librsvg2-bin wget ruby-mini-magick g++
  
# Clean 
apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*