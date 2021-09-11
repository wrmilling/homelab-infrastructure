# amd64 Bootstrap on Proxmox

## Build Base VM Template

This is a one-time activity to be done on the Proxmox host and creates a base template from the Ubuntu cloud-init image. This assumes a fairly standard proxmox install using lvm and having iso images stored on the local drive. Currently using 8GB ram nodes to match the arm64 node base memory. 

```
qm create 1000 --name focal-server-cloudimg-amd64 --memory 8192 --cpu cputype=host --cores 4 --serial0 socket --vga serial0 --net0 virtio,bridge=vmbr1,tag=1040 --agent enabled=1
qm importdisk 1000 /var/lib/vz/template/iso/focal-server-cloudimg-amd64.img local-lvm -format qcow2
qm set 1000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-1000-disk-0,discard=on
qm template 1000
```

## Build Cloud-init Seed ISOs

This is leveraging the [cloud-localds](https://manpages.debian.org/testing/cloud-image-utils/cloud-localds.1.en.html) tool to inject cloud-init user-data to a special ISO consumed by the ubuntu cloudimg. This generated ISO, when added to the VM, will automatically be detected and used by first boot to run the cloud-init instructions. This was intentionally done vs using the builtin proxmox cloud-init approach becuase there is more that can be manipulated with the 'raw' cloud-init.

See [geniso](geniso) for details on how this is done.

## Create a Node 

For each 'node' that needs to be created,

* Clone the template to a new VM
* Resize the hard drive to the new desired size
* Force booting from the new drive
* Add the seed ISO file to the VM
* Add a disk (virtual or real) for rook-ceph
* Up the memory if it is a worker node (16GB in example

For example, for node `k3s-1`, we create VM ID 401 by running the following:

```shell
qm clone 1000 401 --name k3s-1 --format raw --full --storage local-lvm
qm resize 401 scsi0 164G
qm set 401 --boot c --startup order=3 -onboot 1 --bootdisk scsi0
qm set 401 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-1.iso
qm set 401 -scsi1 local-lvm:128
qm set 401 --memory 24576
```

My most recent build of the nodes should be available as a [script](/scripts) in this repo.