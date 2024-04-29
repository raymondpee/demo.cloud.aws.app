#!/bin/bash

# Number of replicas to create
NUM_REPLICAS=10

# Environment variables
IOT_ENDPOINT="a2pxo6fuzs7mhm-ats.iot.ap-southeast-1.amazonaws.com"
IOT_PORT=8883
IOT_ROOT_CA_PATH="/auth/AmazonRootCA1.pem"
IOT_KEY_PATH="/auth/4b2b4d5f0595f1e59de38b8374b1ac18393869a823a521c1b2e3901da08e0b32-private.pem.key"
IOT_CERT_PATH="/auth/4b2b4d5f0595f1e59de38b8374b1ac18393869a823a521c1b2e3901da08e0b32-certificate.pem.crt"
ID=1

# Run the parser service replicas
for ((i=1; i<=NUM_REPLICAS; i++)); do
    docker run -d \
      --name parser_$i \
      --env IOT_ENDPOINT=$IOT_ENDPOINT \
      --env IOT_PORT=$IOT_PORT \
      --env IOT_ROOT_CA_PATH=$IOT_ROOT_CA_PATH \
      --env IOT_KEY_PATH=$IOT_KEY_PATH \
      --env IOT_CERT_PATH=$IOT_CERT_PATH \
      --env ID=$i \
      --volume ./aws-iot-auth:/auth \
      parser:latest
done