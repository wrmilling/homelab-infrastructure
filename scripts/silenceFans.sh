#!/usr/bin/env bash

echo "SSH Password:"
IFS= read -rs SSHPASS

for I in 33 36 38 52 58 59 62;
do
  sshpass -p $SSHPASS ssh -oKexAlgorithms=+diffie-hellman-group14-sha1 Administrator@10.10.10.80 "fan pid $I lo 3500";
done


for I in 53 63;
do
  sshpass -p $SSHPASS ssh -oKexAlgorithms=+diffie-hellman-group14-sha1 Administrator@10.10.10.80 "fan pid $I lo 5500";
done
