set vmlinuz_img="/boot/syslinux/vmlinuz";
set initrd_img="/boot/syslinux/initrd*";
if test -f (loop)/porteus/vmlinuz; then
    set vmlinuz_img="/porteus/vmlinuz";
    set initrd_img="/porteus/initrd*";
fi
set kcmdline="norootcopy nomagic changes=porteus";
configfile ${prefix}/rules/iso/custom_partnew.sh;
