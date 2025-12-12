#!/bin/bash
set -e

sudo apt update -y 

sudo systemctl disable --now apt-daily.timer || true
sudo systemctl disable --now apt-daily-upgrade.timer || true

wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-aarch64.deb -O rustdesk.deb
sudo dpkg -i rustdesk.deb || sudo apt-get install -f -y
rm rustdesk.deb

sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.chromium.Chromium -y

