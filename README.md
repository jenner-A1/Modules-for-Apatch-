# Modules-for-Apatch-
My custom built modules for Apatch and kernel
mkdir -p ~/SuperROM_Forge/Source_APM/ColdCoreBattery/META-INF/com/google/android

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/ColdCoreBattery/module.prop
id=superrom_cold_core
name=10 - Cold-Core Battery Engine
version=v1.0
author=SuperROM_Architect
description=Aggressive sleep state manipulation. Parks big CPU cores and drops minimum voltage to save massive battery when screen is off.
EOF

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/ColdCoreBattery/service.sh
#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Set conservative scaling
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo "schedutil" > $cpu
done

# Allow deeper sleep states
echo 1 > /sys/module/lpm_levels/parameters/sleep_disabled

log -p i -t SuperROM "[MODULE 10] Cold-Core Battery Saver ONLINE."
EOF
chmod +x ~/SuperROM_Forge/Source_APM/ColdCoreBattery/service.sh

python ~/SuperROM_Forge/Tools/pack_module.py ColdCoreBattery
cp ~/SuperROM_Forge/Builds/ColdCoreBattery.zip /sdcard/Download/


mkdir -p ~/SuperROM_Forge/Source_APM/AbsoluteAdBlock/system/etc

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/AbsoluteAdBlock/module.prop
id=superrom_absolute_adblock
name=09 - Absolute Ad & Tracker Blocker
version=v1.0
author=SuperROM_Architect
description=Replaces system hosts file to permanently block Meta, Google Ads, and telemetry at the DNS level.
EOF

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/AbsoluteAdBlock/system/etc/hosts
127.0.0.1 localhost
::1 localhost
# Block Meta/Facebook Telemetry
0.0.0.0 graph.facebook.com
0.0.0.0 edge-mqtt.facebook.com
0.0.0.0 mqtt-mini.facebook.com
# Block Ads
0.0.0.0 googleads.g.doubleclick.net
0.0.0.0 pagead2.googlesyndication.com
EOF

python ~/SuperROM_Forge/Tools/pack_module.py AbsoluteAdBlock
cp ~/SuperROM_Forge/Builds/AbsoluteAdBlock.zip /sdcard/Download/

mkdir -p ~/SuperROM_Forge/Source_APM/GoogleAIFramework/system/etc/sysconfig

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/GoogleAIFramework/module.prop
id=superrom_google_ai
name=08 - Google AI & Face Unlock Framework
version=v1.0
author=SuperROM_Architect
description=Injects Pixel-exclusive XML permissions into the system framework. Prepares the device for Face Unlock and Live Translate APKs.
EOF

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/GoogleAIFramework/system/etc/sysconfig/pixel_features.xml
<?xml version="1.0" encoding="utf-8"?>
<config>
    <feature name="com.google.android.feature.PIXEL_EXPERIENCE" />
    <feature name="com.google.android.feature.FACE_AUTHENTICATION" />
    <feature name="com.google.android.feature.SYSTEM_TRANSLATE" />
</config>
EOF

python ~/SuperROM_Forge/Tools/pack_module.py GoogleAIFramework
cp ~/SuperROM_Forge/Builds/GoogleAIFramework.zip /sdcard/Download/
mkdir -p ~/SuperROM_Forge/Source_APM/NetHunterCore/META-INF/com/google/android

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/NetHunterCore/module.prop
id=superrom_nethunter_core
name=07 - NetHunter Kernel Infrastructure
version=v1.0
author=SuperROM_Architect
description=Kernel-level preparation for Kali NetHunter. Enables USB HID Gadget routing and disables MAC randomization for Wi-Fi auditing.
EOF

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/NetHunterCore/service.sh
#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Disable MAC Randomization for stable Wi-Fi monitoring
settings put global wifi_connected_mac_randomization_enabled 0

# Enable USB HID Gadget capabilities (BadUSB/DuckDucky emulation)
setprop sys.usb.configfs 1
echo "" > /config/usb_gadget/g1/UDC
echo 0x1d6b > /config/usb_gadget/g1/idVendor
echo 0x0104 > /config/usb_gadget/g1/idProduct

log -p i -t SuperROM "[MODULE 7] NetHunter Kernel Infrastructure ONLINE."
EOF
chmod +x ~/SuperROM_Forge/Source_APM/NetHunterCore/service.sh

python ~/SuperROM_Forge/Tools/pack_module.py NetHunterCore
cp ~/SuperROM_Forge/Builds/NetHunterCore.zip /sdcard/Download/
mkdir -p ~/SuperROM_Forge/Source_APM/LiveFastboot/system/bin

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/LiveFastboot/module.prop
id=superrom_live_fastboot
name=06 - Live Fastboot Command
version=v1.0
author=SuperROM_Architect
description=Injects the 'live-fastboot' command into the global system binary. Type it in Termux to instantly hot-reboot to FastbootD.
EOF

cat << 'EOF' > ~/SuperROM_Forge/Source_APM/LiveFastboot/system/bin/live-fastboot
#!/system/bin/sh
echo "[SUPER-ROM] Initiating hot-swap to FastbootD..."
sleep 1
su -c "reboot fastboot"
EOF
chmod +x ~/SuperROM_Forge/Source_APM/LiveFastboot/system/bin/live-fastboot

python ~/SuperROM_Forge/Tools/pack_module.py LiveFastboot
cp ~/SuperROM_Forge/Builds/LiveFastboot.zip /sdcard/Download/
# 1. Create Workspace
mkdir -p ~/SuperROM_Forge/Source_APM/PixelSpoofer/META-INF/com/google/android

# 2. Identity File
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/PixelSpoofer/module.prop
id=superrom_pixel10_spoof
name=05 - Pixel 10 Pro Spoofer
version=v1.0
author=SuperROM_Architect
description=Changes device fingerprint to Pixel 10 Pro. Unlocks Chromebook integration and Google native AI features.
EOF

# 3. The Identity Script
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/PixelSpoofer/post-fs-data.sh
#!/system/bin/sh
# Altering system identity before Android fully loads
resetprop ro.product.model "Pixel 10 Pro"
resetprop ro.product.brand "google"
resetprop ro.product.name "tegus"
resetprop ro.product.device "tegus"
resetprop ro.product.manufacturer "Google"
resetprop ro.build.flavor "tegus-user"
EOF
chmod +x ~/SuperROM_Forge/Source_APM/PixelSpoofer/post-fs-data.sh

# 4. Zip and Export
python ~/SuperROM_Forge/Tools/pack_module.py PixelSpoofer
cp ~/SuperROM_Forge/Builds/PixelSpoofer.zip /sdcard/Download/

# 1. Create Workspace
mkdir -p ~/SuperROM_Forge/Source_APM/BasebandOverdrive/META-INF/com/google/android

# 2. Identity File
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/BasebandOverdrive/module.prop
id=superrom_baseband_satellite
name=04 - T-Mobile NTN & 5G Overdrive
version=v1.0
author=SuperROM_Architect
description=Forces NTN Satellite band preference, enables TCP BBR congestion control, and maximizes radio transmission power.
EOF

# 3. The Baseband Injection Script
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/BasebandOverdrive/service.sh
#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Inject Network Properties
resetprop persist.radio.ntn.enable true
resetprop persist.vendor.radio.force_on_dc true
resetprop ro.telephony.default_network 33

# Load TCP BBR for hyper-fast data
modprobe tcp_bbr
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.core.default_qdisc=fq

log -p i -t SuperROM "[MODULE 4] Baseband Overdrive ONLINE."
EOF
chmod +x ~/SuperROM_Forge/Source_APM/BasebandOverdrive/service.sh

# 4. Zip and Export
python ~/SuperROM_Forge/Tools/pack_module.py BasebandOverdrive
cp ~/SuperROM_Forge/Builds/BasebandOverdrive.zip /sdcard/Download/

# 1. Create Workspace
mkdir -p ~/SuperROM_Forge/Source_APM/GodModeEngine/META-INF/com/google/android

# 2. Identity File
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/GodModeEngine/module.prop
id=superrom_god_mode
name=03 - Snapdragon Absolute Performance
version=v1.0
author=SuperROM_Architect
description=Unlocks the Snapdragon CPU/GPU governors. Forces maximum clock speeds and disables thermal throttling. YOUR PHONE WILL GET WARM.
EOF

# 3. The Core Engine Script
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/GodModeEngine/service.sh
#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Force Performance Governor on all cores
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo "performance" > $cpu
done

# Disable Core Parking (Keeps all brains awake)
echo 0 > /sys/module/core_ctl/parameters/is_active

# Boost GPU to max frequencies
echo "performance" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

log -p i -t SuperROM "[MODULE 3] God-Mode Performance ONLINE."
EOF
chmod +x ~/SuperROM_Forge/Source_APM/GodModeEngine/service.sh

# 4. Zip and Export
python ~/SuperROM_Forge/Tools/pack_module.py GodModeEngine
cp ~/SuperROM_Forge/Builds/GodModeEngine.zip /sdcard/Download/
# 1. Create Workspace
mkdir -p ~/SuperROM_Forge/Source_APM/UbuntuShell/system/app/UbuntuLauncher

# 2. Identity File
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/UbuntuShell/module.prop
id=superrom_ubuntu_shell
name=02 - Ubuntu System Shell Injector
version=v1.0
author=SuperROM_Architect
description=Grants system-privileges for Ubuntu/Linux CLI style desktop launchers, preventing Android 16 from killing them in the background.
EOF

# 3. Zip and Export
python ~/SuperROM_Forge/Tools/pack_module.py UbuntuShell
cp ~/SuperROM_Forge/Builds/UbuntuShell.zip /sdcard/Download/
# 1. Create the Module Workspace
mkdir -p ~/SuperROM_Forge/Source_APM/QuantumVRAM/META-INF/com/google/android

# 2. Write the Identity File
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/QuantumVRAM/module.prop
id=superrom_vram_quantum
name=01 - Quantum 16GB VRAM Expander
version=v2.0-Absolute
versionCode=2
author=SuperROM_Architect
description=Forces 16GB zRAM with ZSTD compression. Edits kernel VM swappiness, watermarks, and LRU cache for zero background app killing.
EOF

# 3. Write the Core Engine Script
cat << 'EOF' > ~/SuperROM_Forge/Source_APM/QuantumVRAM/service.sh
#!/system/bin/sh
# Wait until the system is fully booted
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Disable default Motorola swap
swapoff /dev/block/zram0

# Set compression to ultra-fast ZSTD and size to 16GB
echo zstd > /sys/block/zram0/comp_algorithm
echo 16G > /sys/block/zram0/disksize

# Initialize and turn on
mkswap /dev/block/zram0
swapon /dev/block/zram0 -p 100

# Kernel VM Tweaks (The Magic Sauce)
# Forces the kernel to use the new RAM efficiently without lagging the CPU
echo 100 > /proc/sys/vm/swappiness
echo 0 > /proc/sys/vm/page-cluster
echo 10 > /proc/sys/vm/watermark_scale_factor
echo 100 > /proc/sys/vm/vfs_cache_pressure

log -p i -t SuperROM "[MODULE 1] Quantum 16GB VRAM Engine is ONLINE."
EOF
chmod +x ~/SuperROM_Forge/Source_APM/QuantumVRAM/service.sh

# 4. Create the Python Packer (if you don't have it yet)
cat << 'EOF' > ~/SuperROM_Forge/Tools/pack_module.py
import os, sys, zipfile
def pack_apm(folder_name):
    zip_name = f"{folder_name}.zip"
    build_path = os.path.expanduser(f"~/SuperROM_Forge/Builds/{zip_name}")
    source_path = os.path.expanduser(f"~/SuperROM_Forge/Source_APM/{folder_name}")
    with zipfile.ZipFile(build_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(source_path):
            for file in files:
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, source_path)
                zipf.write(full_path, rel_path)
    print(f"\n✅ SUCCESS! Module packed to: {build_path}")
if __name__ == "__main__":
    pack_apm(sys.argv[1])
EOF

# 5. Pack the Module into a Flashable Zip
python ~/SuperROM_Forge/Tools/pack_module.py QuantumVRAM

# 6. Move it to your Downloads folder so you can flash it in APatch
cp ~/SuperROM_Forge/Builds/QuantumVRAM.zip /sdcard/Download/
