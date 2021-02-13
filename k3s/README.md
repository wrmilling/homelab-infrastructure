# Mixed-architecture Kubernetes Cluster Setup Using k3s

## amd64

My x86_64 / amd64 nodes are built on top of Proxmox instead of bare metal nodes due to the hardware I have on hand. These will primarily be worker nodes in the cluster with one of the arm64 nodes acting as master. Please see the [amd64 README.md](amd64/README.md) for more information.

## arm64

My arm64 nodes includes the master node for the full cluster as well as a few worker nodes. My long term goal is to have core services run on the low power arm nodes and in the even of a power failure, allow for longer overall runtime with my UPS by shutting down the higher power x86_64 nodes and running network + arm nodes for a longer period of time. Please see the [arm64 README.md](arm64/README.md) for more information.

## Credits

This section of `homelab-infrastructure` has an updated [LICENSE](LICENSE) reflect the amount of work pulled from the [billimek/homelab-infrastructure](https://github.com/billimek/homelab-infrastructure/tree/master/k3s) - [License](https://github.com/billimek/homelab-infrastructure/blob/master/LICENSE).
