set kcmdline="archisodevice=/dev/loop0 earlymodules=loop archisobasedir=blackarch";
if test -f (loop)/blackarch/boot/x86_64/vmlinuz* -a -f (loop)/blackarch/boot/x86_64/archiso.img; then
    set vmlinuz_img="/blackarch/boot/x86_64/vmlinuz*";
    set initrd_img="/blackarch/boot/x86_64/archiso.img";
else
    set vmlinuz_img="/blackarch/boot/i386/vmlinuz*";
    set initrd_img="/blackarch/boot/i386/archiso.img";
fi;
source ${prefix}/rules/iso/custom_partnew.sh;
