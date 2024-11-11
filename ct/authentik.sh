#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/remz1337/Proxmox/remz/misc/build.func)
# Copyright (c) 2021-2024 remz1337
# Author: remz1337
# License: MIT
# https://github.com/remz1337/Proxmox/raw/main/LICENSE

function header_info {
  clear
  cat <<"EOF"
    ___         __  __               __  _ __  
   /   | __  __/ /_/ /_  ___  ____  / /_(_) /__
  / /| |/ / / / __/ __ \/ _ \/ __ \/ __/ / //_/
 / ___ / /_/ / /_/ / / /  __/ / / / /_/ / ,<   
/_/  |_\__,_/\__/_/ /_/\___/_/ /_/\__/_/_/|_|  
                                               
EOF
}
header_info
echo -e "Loading..."
APP="Frigate"
var_disk="12"
var_cpu="6"
var_ram="8192"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  FW=1
  NVIDIA_PASSTHROUGH="yes"
  VLAN=""
  SSH="no"
  VERB="yes"
  echo_default
}

function update_script() {
  if [[ ! -f /etc/systemd/system/authentik.service ]]; then
    msg_error "No ${APP} Installation Found!"
    exit
  fi
  header_info
  #Write update path
}

start
build_container
description

msg_info "Setting Container to Normal Resources"
pct set $CTID -memory 1024
pct set $CTID -cores 2
msg_ok "Set Container to Normal Resources"
msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:9000/if/flow/initial-setup/${CL} \n"