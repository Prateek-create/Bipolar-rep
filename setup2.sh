git clone https://github.com/waveshareteam/ugv_jetson.git
cd ugv_jetson/
sudo chmod +x setup.sh
sudo chmod +x autorun.sh
sudo unminimize
sudo ./setup.sh
python3 create_jupyter_service.py
sudo mv ugv_jupyter.service /etc/systemd/system/ugv_jupyter.service
sudo systemctl enable ugv_jupyter
sudo systemctl start ugv_jupyter
pactl set-sink-volume alsa_output.usb-Solid_State_System_Co._Ltd._USB_PnP_Audio_Device_000000000000-00.analog-stereo 100%
sudo cp pulseaudio.service /etc/systemd/system/pulseaudio.service
sudo systemctl --system enable --now pulseaudio.service
sudo systemctl --system status pulseaudio.service
sudo pip3 install -U jetson-stats
sudo systemctl enable jtop.service
./autorun.sh
cd AccessPopup
sudo chmod +x installconfig.sh
sudo ./installconfig.sh
*Input 1: Install AccessPopup
*Press any key to exit
*Input 9: Exit installconfig.sh
sudo reboot
