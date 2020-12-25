set vmlinuz_img="/syslinux/alt0/vmlinuz";
set initrd_img="/syslinux/alt0/full.cz";
set kcmdline="noeject fastboot live lowmem showopts quiet splash live_rw stagename=live";
source ${prefix}/rules/iso/custom_partnew.sh;
