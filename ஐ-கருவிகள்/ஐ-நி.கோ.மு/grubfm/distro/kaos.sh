set vmlinuz_img="/kdeos/boot/x86_64/kdeosiso";
set initrd_img="/kdeos/boot/x86_64/kdeosiso.img";
set kcmdline="kdeosisodevice=/dev/loop0 earlymodules=loop";
source ${prefix}/rules/iso/custom_partnew.sh;