#!/bin/bash

SSL_KEY="/home/ec2-user/.ssh/key.pem"
SSL_CERT="/home/ec2-user/.ssh/cert.pem"
PORT=9292

SSL_STARTUP_URI="ssl://0.0.0.0:$PORT?key=$SSL_KEY&cert=$SSL_CERT"

setsid puma -b "$SSL_STARTUP_URI" &>>out.log &