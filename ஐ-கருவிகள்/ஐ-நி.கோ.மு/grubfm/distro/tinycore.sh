set vmlinuz_img="/boot/vmlinuz";
set initrd_img="/boot/core.gz";
if test -f (loop)/boot/vmlinuz64; then
    vmlinuz_img="/boot/vmlinuz64";
    initrd_img="/boot/corepure64.gz";
fi
set kcmdline="loglevel=3 cde vga=791";
source ${prefix}/rules/iso/custom_partnew.sh;
