if test -f (loop)/arch/boot/x86_64/vmlinuz* -a -f (loop)/arch/boot/x86_64/archiso.img; then
    set vmlinuz_img="/arch/boot/x86_64/vmlinuz*";
    set initrd_img="/arch/boot/x86_64/archiso.img";
    set kcmdline="archisodevice=/dev/loop0 earlymodules=loop";
fi;
if test -f (loop)/boot/vmlinuz_x86_64 -a -f (loop)/boot/initramfs_x86_64.img; then
    set vmlinuz_img="/boot/vmlinuz_x86_64";
    set initrd_img="/boot/initramfs_x86_64.img";
    set kcmdline="";
fi;
if test -f (loop)/arch/boot/vmlinuz* -a -f (loop)/arch/boot/archiso.img; then
    set vmlinuz_img="/arch/boot/vmlinuz*";
    set initrd_img="/arch/boot/archiso.img";
    set kcmdline="archisobasedir=arch earlymodules=loop modules-load=loop";
fi;
if test -f (loop)/arch/boot/intel_ucode.img; then
    set initrd_img="/arch/boot/intel_ucode.img ${initrd_img}"
fi;
source ${prefix}/rules/iso/custom_partnew.sh;
