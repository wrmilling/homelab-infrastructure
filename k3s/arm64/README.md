# arm64 Bootstrap on Bare-metal

This guide sets up a Raspberry Pi 4 as a k3s worker node which joins your existing k3s cluster.

## OS Image

We are using the arm64 ubuntu image for the Raspberry Pi 4 nodes. They can be flashed with your preferred program, I normally use [balena-etcher](https://www.balena.io/etcher/?ref=etcher_menu).

Download: [Ubuntu Server 20.04.2 LTS](https://ubuntu.com/download/raspberry-pi/thank-you?version=20.04.2&architecture=server-arm64+raspi)

## k3s Node Setup

### Scripted

The steps to prepare the drive are automated through the [bootstrap](bootstrap) script. Example run below: 

```bash
./bootstrap prepare k3s-pi4-a /mnt/system-boot
```

### Manual

The manual steps tp prepare the drive are as follows: 

1. Mount the newly created drive on your system (example mount point: `/mnt/system-boot/`)
2. Copy the following files to that drive
   1. user-data: `envsubst < ./nodes/k3s-pi4-a > /mnt/system-boot/user-data`
   2. network-config: `envsubst < ./nodes/k3s-pi4-a.network-config > "$TARGET_VOLUME/network-config"`
   3. cmdline.txt: `cp ./cmdline.txt /mnt/system-boot/cmdline.txt`


### First-boot

First boot will take time for cloud-init to execute the settings provided, waiting 10 minutes before attempting to SSH into the node is most likely enough time. The new node should auto-join the k3s cluster. 
