# Lab Scripts

## silenceFans.sh

This script is used to set the fan speed thresholds on my HP DL380P G8 which is running a custom version of [iLO 4 v2.73](https://www.reddit.com/r/homelab/comments/hix44v/silence_of_the_fans_pt_2_hp_ilo_4_273_now_with/). This custom firmware allows for individual fan control or pid control to slow down (or speed up) the fans in the server. This is required due to "unsupported" PCIe devices causing the fans to ramp up to nearly 100%. The current configuration in the script overrides 3 different pairs of PCIe pids as well as two fan zone pids (assumption based on experimentation). It current has to be executed at each boot if the PCIe devices are installed. 

## setupK3sMaster.sh and setupK3sWorkers.sh

Basically following the guide in [k3s/amd64](/k3s/amd64) to build a master node and three worker nodes in VMs on ProxMox. These assume the template is setup and is id 1000. 
