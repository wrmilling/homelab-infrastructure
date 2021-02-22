#!/usr/bin/env bash

echo "Building Master Node"
qm clone 1000 400 --name k3s-amd64-0.homelab.tokyo --format raw --full --storage local-lvm
qm resize 400 scsi0 64G
qm set 400 --boot c --startup order=3 -onboot 1 --bootdisk scsi0
qm set 400 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-amd64-0.iso
qm start 400
qm terminal 400
