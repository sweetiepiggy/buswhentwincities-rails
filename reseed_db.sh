#!/usr/bin/bash

heroku run -a buswhentwincities rake db:drop db:create db:seed db:mongoid:create_indexes

