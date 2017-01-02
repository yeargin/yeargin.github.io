#!/bin/bash

export RBENV_VERSION=2.1.1

source ~/.bash_profile

ruby --version

bundle install --path=vendor/bundle
