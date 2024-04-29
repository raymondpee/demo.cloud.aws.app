#!/bin/bash

NUM_REPLICAS=10

# Stop the parser service replicas
for ((i=1; i<=NUM_REPLICAS; i++)); do
    docker stop parser_$i
    docker rm parser_$i
done