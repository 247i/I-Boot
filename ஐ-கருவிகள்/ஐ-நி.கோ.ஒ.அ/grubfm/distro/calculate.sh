set vmlinuz_img="/boot/vmlinuz";
set initrd_img="/boot/initrd";
set kcmdline="vga=791 init=/linuxrc rd.live.squashimg=livecd.squashfs nodevfs quiet noresume splash=silent,theme:calculate console=tty1";
source ${prefix}/rules/iso/custom_partnew.sh;
