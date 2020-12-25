set vmlinuz_img="/isolinux/gentoo";
set initrd_img="/isolinux/gentoo.xz";
if test -f (loop)/isolinux/gentoo64; then
    vmlinuz_img="/isolinux/gentoo64";
    initrd_img="/isolinux/gentoo64.xz";
fi
set kcmdline="root=/dev/ram0 init=/linuxrc dokeymap aufs looptype=squashfs loop=/image.squashfs cdroot console=tty1";
source ${prefix}/rules/iso/custom_partnew.sh;