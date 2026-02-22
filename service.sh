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
