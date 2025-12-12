#!/bin/bash
set -e

sudo apt update -y 

sudo systemctl disable --now apt-daily.timer || true
sudo systemctl disable --now apt-daily-upgrade.timer || true

sudo apt install -y \
  libssl3 libssl-dev libgstreamer1.0-0 gstreamer1.0-tools \
  gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly gstreamer1.0-libav \
  libgstreamer-plugins-base1.0-dev libgstrtspserver-1.0-0 \
  libjansson4 libyaml-cpp-dev libjsoncpp-dev protobuf-compiler \
  gcc make git python3

git clone https://github.com/confluentinc/librdkafka.git
cd librdkafka
git checkout tags/v2.2.0
./configure --enable-ssl
make
sudo make install
sudo mkdir -p /opt/nvidia/deepstream/deepstream/lib
sudo cp /usr/local/lib/librdkafka* /opt/nvidia/deepstream/deepstream/lib
sudo ldconfig

wget --content-disposition 'https://api.ngc.nvidia.com/v2/resources/org/nvidia/deepstream/7.0/files?redirect=true&path=deepstream-7.0_7.0.0-1_arm64.deb' --output-document 'deepstream-7.0_7.0.0-1_arm64.deb'

sudo apt-get install ./deepstream-7.0_7.0.0-1_arm64.deb
sudo ldconfig

wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-aarch64.deb -O rustdesk.deb
sudo dpkg -i rustdesk.deb || sudo apt-get install -f -y
rm rustdesk.deb

sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.chromium.Chromium -y

/opt/nvidia/deepstream/deepstream-7.0/bin/deepstream-app --version

sudo reboot
