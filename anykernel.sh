### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string="ZenKernel by Guilherme"
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
do.check_boot_version=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
keycheck.timeout=10
'; } # end properties


### AnyKernel install
## boot shell variables
block=boot
is_slot_device=auto
ramdisk_compression=auto
patch_vbmeta_flag=auto
no_magisk_check=1

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh

# Match the GKI family built by ZenKernel. Android's userspace version may
# differ from the Android branch of its kernel, so inspect the kernel release.
kernel_version=$(awk '{print $3}' /proc/version)
case $kernel_version in
    5.10.*-android12-*) ksu_supported=true ;;
    *) ksu_supported=false ;;
esac

ui_print " " "  -> Current kernel: $kernel_version"
$ksu_supported || abort "  -> This package requires Android 12 GKI 5.10."

# boot install
split_boot

if [ -f "$SPLITIMG/ramdisk.cpio" ]; then
    unpack_ramdisk
    write_boot
else
    flash_boot
fi

ui_print " "
ui_print "ZenKernel"
ui_print "KernelSU Next + SUSFS"
ui_print "Android 12 GKI Kernel 5.10"
ui_print "Moto G73 5G Stock"
ui_print "Compilado por Guilherme"
ui_print " "
ui_print "https://github.com/Guizzk1/AnyKernel3-ZenKernel"
ui_print " "
