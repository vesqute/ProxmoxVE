<div align="center">
  <a href="#">
    <img src="https://raw.githubusercontent.com/remz1337/ProxmoxVE/remz/misc/images/logo.png" height="100px" />
 </a>
</div>

<div style="border: 2px solid #d1d5db; padding: 20px; border-radius: 8px; background-color: #f9fafb;">
  <h2 align="center">Proxmox VE Helper-Scripts: A Community Legacy</h2>
  <p>Dear Community,</p>
  <p>In agreement with <a href="https://github.com/tteck">tteck</a> and <a href="https://github.com/community-scripts">Community-Scripts</a>, this project has now transitioned into a community-driven effort. We aim to continue his work, building on the foundation he laid to support Proxmox users worldwide.</p>
  <p>tteck, whose contribution has been invaluable, shared recently that he is now in hospice care. His scripts have empowered thousands, and we honor his legacy by carrying this project forward with the same passion and commitment. We’re deeply grateful for his vision, which made Proxmox accessible to so many.</p>
  <p>To tteck: Your impact will be felt in this community for years to come. We thank you for everything.</p>
  <p>Warm regards,<br>The Community</p>
</div>

--- 

<p align="center">
  <a href="https://helper-scripts.com">Website</a> | 
  <a href="https://ko-fi.com/proxmoxhelperscripts">Ko-Fi (for tteck🙏)</a> |
  <a href="https://github.com/remz1337/ProxmoxVE/blob/remz/.github/CONTRIBUTING.md">Contribute</a> |
  <a href="https://github.com/remz1337/ProxmoxVE/blob/remz/USER_SUBMITTED_GUIDES.md">Guides</a> |
  <a href="https://discord.gg/UHrpNWGwkH">Discord</a> |
  <a href="https://github.com/remz1337/ProxmoxVE/blob/remz/CHANGELOG.md">Changelog</a>
</p>

---

This community-managed project continues tteck’s original vision of simplifying Proxmox VE setup. The scripts allow users to create Linux containers or virtual machines interactively, with options for both simple and advanced configurations. While the basic setup adheres to default settings, the advanced setup offers extensive customization options for specific needs.

All configuration choices are displayed in a dialog box, where users can select their preferences. The script then validates these inputs to generate a final configuration for the container or virtual machine.

<hr>

<p align="center">
Please exercise caution and thoroughly review scripts and automation tasks from external sources. <a href="https://github.com/remz1337/ProxmoxVE/blob/remz/CODE-AUDIT.md">Read more</a>
</p>

---

### Note on the Transition:
This project is now maintained by the community in memory of tteck’s invaluable contribution. His dedication transformed the Proxmox experience for countless users, and we’re committed to continuing his work with the same dedication.

---

<sub><div align="center"> Proxmox® is a registered trademark of Proxmox Server Solutions GmbH. </div></sub>

# Disclaimer
This fork aims to add support for Nvidia GPU. The scripts are not guaranteed to work with every hardware, but they have been tested with the following hardware:
- CPU: AMD Ryzen 5 3600
- Compute GPU (LXC): Nvidia T600
- Gaming GPU (VM): Nvidia RTX 2060
- Motherboard: Asrock B450M Pro4-F
- RAM: 4x8GB HyperX (non ECC)

# Extra scripts
Here's a shortlist of scripts/apps that did not get merged upstream (tteck) for various reasons:
- <a href="https://github.com/CollaboraOnline/online">Collabora Online</a>
- <a href="https://github.com/remz1337/Backup2Azure">Backup2Azure</a>
- <a href="https://github.com/blakeblackshear/frigate">Frigate</a> with Nvidia GPU passthrough (older cards such as Pascal may not work)
- <a href="https://github.com/claabs/epicgames-freegames-node">Epic Games free games</a>
- <a href="https://github.com/AnalogJ/scrutiny">Scrutiny</a>
- <a href="https://github.com/remz1337/SAQLottery">SAQLottery</a>
- Nvidia drivers support (detection/installation)
- Windows 11 Gaming VM

# Extra configurations
I have added some configuration options to streamline deployment of certain services in my environment. When building a container, I run an extra script to do that additional configuration. That script is `ct/post_create_lxc.sh`, which is called at the end of the `build_container()` function (in `build.func`). This can be used to:
- mount a shared folder by adding this configuration to the LXC:`mp0: /mnt/pve/share/public,mp=/mnt/pve/share`
- setup postfix service to run as a satellite, leverage a single postfix LXC to send all emails
- passthrough a Nvidia GPU
Some of these configurations leverage settings that can be found in `/etc/pve-helper-scripts.conf`.

# Deploying services
To create a new LXC, run the following command directly on the host:
```
bash -c "$(wget -qLO - https://github.com/remz1337/Proxmox/raw/remz/ct/<app>.sh)"
```
and replace `<app>` by the service you wish to deploy, eg. `.../remz/ct/frigate.sh)`

# Updating services
To update an existing LXC, run the following command directly on the host, where `<ID>` is the LXC ID (eg. 100, 101...) :
```
pct exec <ID> -- /usr/bin/update
```
Alternatively, you can update from within the LXC by running the same command used to create the machine but inside it (not on the host). Easiest way is to log in from the host using the `pct enter` command with the machine ID :
```
pct enter <ID>
bash -c "$(wget -qLO - https://github.com/remz1337/Proxmox/raw/remz/ct/<app>.sh)"
```
