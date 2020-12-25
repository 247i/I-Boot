set vmlinuz_img="/boot/vmlinuz*";
set initrd_img="/boot/initrd.img*";
set kcmdline="boot=fll fromhd systemd.show_status=1";
source ${prefix}/rules/iso/custom_partnew.sh;
