#!/usr/bin/env bash
sudo docker-compose -f docker-compose.yml -f build.yml -f dev.yml up -d --build