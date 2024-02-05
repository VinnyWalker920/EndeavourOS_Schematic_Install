!# /bin/bash
#Installs All Relevant Packages
sudo pacman -S neofetch vscode sed htop qemu-full virt-manager virt-viewer dnsmasq bridge-utils libguestfs ebtables vde2 openbsd-netcat lightdm lightdm-gtk-greeter lightdm-slick-greeter

#Does Some Magic So KVM Works
sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf
sudo usermod -aG libvirt $USER

#Enables and Starts KVM services
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service

#Configures Greeter and Customizes it
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
sudo sed -i 's/#logind-check-graphical=true/logind-check-graphical=true/' /etc/lightdm/lightdm.conf
#sudo sed -i 's/Session=default/Session=hyprland' ~/.dmrc
sudo cp ~/Downloads/EndeavourOS_Schematic_Install/wallpaper/midnight.jpg /usr/share/pixmaps/
#sudo echo "[Greeter]'\n'background=/usr/share/pixmaps/midnight.jpg" >> /etc/lightdm/slick-greeter.conf
sudo sed -i 'sX#background=Xbackground=/usr/share/pixmaps/midnight.jpgX' /etc/lightdm/lightdm-gtk-greeter.conf
#Enables LightDM Which Will Start Greeter Upon Reboot
sudo systemctl enable lightdm.service

#Clones Hyprland Desktop Environment Install Files
cd ~/Downloads
sudo git clone https://gitlab.com/stephan-raabe/dotfiles.git
cd ~/Downloads/dotfiles

#Runs Install
echo "Hyprland Desktop Env will now install. Follow direction and select new Hyprland install and lightdm as Desktop Manager (Note: It should already be  installed, but cant hur to retry it) you can select reboot at the end and with any luck you should get a greeter once you restart"
sleep 10
./install.sh