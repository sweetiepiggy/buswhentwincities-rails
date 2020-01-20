#!/usr/bin/bash

heroku run rake db:drop db:create db:seed db:mongoid:create_indexes

