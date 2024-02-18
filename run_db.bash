#!/bin/bash

mkdir -p .database
mongod --dbpath ./.database > mongo.log 2>&1
