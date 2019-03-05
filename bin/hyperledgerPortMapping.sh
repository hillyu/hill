#!/bin/bash

HOST="hills.ml"
SSHPORT='22222'
ports=(4200 3000 8080)
for PORT in "${ports[@]}" ; do
    echo $PORT
    ssh -fNTL localhost:$PORT:localhost:$PORT $HOST -p $SSHPORT
    
done
