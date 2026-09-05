#!/bin/bash

p="devteam"
d="/opt/project_alpha"

sudo groupadd "$p"
sudo useradd -m -g devteam alice
sudo useradd -m -g devteam bob
sudo useradd -m -g devteam charlie
sudo mkdir -p "$d"
sudo chown :devteam "$d"
sudo chmod 2770 "$d"

