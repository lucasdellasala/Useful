
# Setup Act led
echo -e "\n\nEnabling external activity led"
echo "--------------------------------"

echo "# Act led" | sudo tee -a /boot/config.txt
echo "dtoverlay=pi3-act-led,gpio=26" | sudo tee -a /boot/config.txt

# Download case button script
echo -e "\n\nDownloading case button script"
echo "--------------------------------"
wget raw.githubusercontent.com/luxarts/Useful/master/Python/casebutton.py
sudo chmod +x casebutton.py

# Move the script to PATH
sudo mv casebutton.py /usr/bin/casebutton

echo -e "\n\nExecute script at start"
echo "--------------------------------"

# Delete last line from rc.local ("exit 0" command)
sudo head -n -1 /etc/rc.local > rclocal.tmp && sudo mv rclocal.tmp /etc/rc.local

# Turn on the GPIO 27
echo "# Turn on the GPIO 27"
echo "sudo echo \"27\" > /sys/class/gpio/export" | sudo tee -a /etc/rc.local
echo "sudo echo \"out\" > /sys/class/gpio/gpio27/direction" | sudo tee -a /etc/rc.local
echo "sudo echo \"1\" > /sys/class/gpio/gpio27/value" | sudo tee -a /etc/rc.local

echo "# Read the power button"
echo "sudo casebutton &" | sudo tee -a /etc/rc.local

# Add exit 0
echo "exit 0" | sudo tee -a /etc/rc.local

# Add execution to rc.local
sudo chmod +x /etc/rc.local
