set vmlinuz_img="/boot/generic";
set initrd_img="/boot/initrd.img";
set kcmdline="load_ramdisk=1 prompt_ramdisk=0 rw printk.time=0";
linux $vmlinuz_img $kcmdline $linux_extra;
initrd $initrd_img;
source ${prefix}/rules/iso/custom_partnew.sh;
