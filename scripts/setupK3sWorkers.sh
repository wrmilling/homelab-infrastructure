#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)
. "$REPO_ROOT"/.env

echo "Building worker nodes"
qm clone 1000 401 --name k3s-amd64-a.${INTERNAL_DOMAIN} --format raw --full --storage local-lvm
qm resize 401 scsi0 64G
qm set 401 --boot c --startup order=3 -onboot 1 --bootdisk scsi0
qm set 401 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-amd64-a.iso
qm set 401 -scsi1 local-lvm:32
qm set 401 --memory 16384
qm start 401

qm clone 1000 402 --name k3s-amd64-b.${INTERNAL_DOMAIN} --format raw --full --storage local-lvm
qm resize 402 scsi0 64G
qm set 402 --boot c --startup order=3 -onboot 1 --bootdisk scsi0
qm set 402 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-amd64-b.iso
qm set 402 -scsi1 local-lvm:32
qm set 402 --memory 16384
qm start 402

qm clone 1000 403 --name k3s-amd64-c.${INTERNAL_DOMAIN} --format raw --full --storage local-lvm
qm resize 403 scsi0 64G
qm set 403 --boot c --startup order=3 -onboot 1 --bootdisk scsi0
qm set 403 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-amd64-c.iso
qm set 403 -scsi1 local-lvm:32
qm set 403 --memory 16384
qm start 403

