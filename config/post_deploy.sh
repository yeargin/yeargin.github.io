#!/bin/bash

source ~/.bash_profile

bundle exec jekyll build
bundle exec rake notify
