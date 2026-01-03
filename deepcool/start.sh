#!/bin/bash

# Configuration
BINARY_NAME="deepcool-digital-linux"
INSTALL_PATH="/usr/local/bin/$BINARY_NAME"
SERVICE_NAME="deepcool-digital.service"
UDEV_RULE_PATH="/etc/udev/rules.d/99-deepcool-digital.rules"

# 1. Check if the binary exists in the current folder
if [ ! -f "./$BINARY_NAME" ]; then
    echo "❌ Error: Could not find '$BINARY_NAME' in the current directory."
    echo "   Please make sure you are running this script in the same folder as the executable."
    exit 1
fi

echo "🚀 Starting installation..."

# 2. Install the binary
echo "📂 Moving executable to $INSTALL_PATH..."
sudo cp "./$BINARY_NAME" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

# 3. Create Udev Rules (for rootless hardware access)
echo "usb Creating Udev rules for rootless access..."
sudo bash -c "cat > $UDEV_RULE_PATH" <<EOF
# Intel RAPL energy usage file
ACTION=="add", SUBSYSTEM=="powercap", KERNEL=="intel-rapl:0", RUN+="/bin/chmod 444 /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# DeepCool HID raw devices
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3633", MODE="0666"

# CH510 MESH DIGITAL
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="34d3", ATTRS{idProduct}=="1100", MODE="0666"
EOF

# Reload Udev rules immediately
echo "🔄 Reloading Udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

# 4. Create Systemd Service
echo "⚙️  Creating Systemd service..."
sudo bash -c "cat > /etc/systemd/system/$SERVICE_NAME" <<EOF
[Unit]
Description=DeepCool Digital Display Daemon
After=network.target

[Service]
ExecStart=$INSTALL_PATH
Restart=on-failure
RestartSec=5s
# Note: Keeping this as root is standard for hardware drivers to ensure 
# they can read all sensors, but the udev rules allow user access if you manually run it.

[Install]
WantedBy=multi-user.target
EOF

# 5. Enable and Start Service
echo "⚡ Enabling and starting service..."
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl restart $SERVICE_NAME

echo "----------------------------------------------------"
echo "✅ Installation Complete!"
echo "----------------------------------------------------"
echo "Check status with: systemctl status $SERVICE_NAME"
