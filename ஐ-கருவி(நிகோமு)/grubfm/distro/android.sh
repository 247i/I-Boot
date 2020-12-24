export vmlinuz_img="/kernel";
export initrd_img="/initrd.img";
export android_selinux="androidboot.selinux=permissive";
export android_hardware=" ";
configfile ${prefix}/distro/andmenu.sh;
source ${prefix}/rules/iso/custom_partnew.sh;
