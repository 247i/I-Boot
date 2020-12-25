set vmlinuz_img="/boot/vmlinuz";
set initrd_img="/boot/initrd*";
if test -d (loop)/wifislax64; then
    set kcmdline="kbd=us tz=Asia/Shanghai locale=en_US.utf8 rw";
    source ${prefix}/rules/iso/custom_partnew.sh;
elif test -d (loop)/wifislax; then
    if test -f (loop)/wifislax/vmlinuz*; then
        set vmlinuz_img="/wifislax/vmlinuz*";
        set initrd_img="/wifislax/initrd*";
    fi;
    set kcmdline="noload=006-Xfce load=English";
    source ${prefix}/rules/iso/custom_partnew.sh;
elif test -d (loop)/wifiway; then
    set kcmdline="";
    if [ "$grub_platform" != "efi" ]; then
        kcmdline="${kcmdline} autoexec=telinit~4 vga=788 noload=efi";
    fi;
    source ${prefix}/rules/iso/custom_partnew.sh;
fi;
