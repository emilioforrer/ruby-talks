#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y --fix-missing --no-install-recommends postgresql-client nano netcat libpq-dev gcc make dpkg-dev git librsvg2-bin wget ruby-mini-magick g++

# Install NodeJs
wget -qO- https://deb.nodesource.com/setup_12.x  | bash - && \
  apt-get install -y nodejs && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install yarn 
  
# Clean 
apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*