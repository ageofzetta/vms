#!/usr/bin/env bash

  sudo apt-get update;
  sudo apt-get upgrade;
  sudo apt-get install php5-xdebug;
  sudo echo "source ~/post_setup.sh" >> /home/vagrant/.bashrc