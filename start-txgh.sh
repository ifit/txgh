#!/bin/bash

PORT=9292

setsid bundle exec rackup --host 0.0.0.0 -E production -p ${PORT} &>> out.log &
