set icon="gnu-linux";
set vmlinuz_img="/syslinux/kernel/bzImage";
set initrd_img="/syslinux/kernel/initramfs.*";
menuentry "Plop Linux framebuffer mode" --class $icon{
    set kcmdline="vga=0x317";
source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry "Plop Linux text mode" --class $icon{
    set kcmdline="vga=1 nomodeset";
source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry "Plop Linux text mode + copy2ram" --class $icon{
    set kcmdline="vga=1 nomodeset copy2ram";
source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry "Plop Linux framebuffer mode + copy2ram" --class $icon{
    set kcmdline="vga=0x317 nomodeset copy2ram";
source ${prefix}/rules/iso/custom_partnew.sh;
}