#!/bin/bash

source ~/.bash_profile

bundle install
bundle exec jekyll build
bundle exec rake notify
