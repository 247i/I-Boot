# Modified for use with YUMI
set vmlinuz_img="/slax/boot/vmlinuz";
set initrd_img="/slax/boot/initr*";
   if test -f (loop)/boot/vmlinuz; then
     vmlinuz_img='/boot/vmlinuz';
     initrd_img='/boot/initr*';
   fi
set kcmdline="vga=normal load_ramdisk=1 prompt_ramdisk=0 rw printk.time=0 slax.flags=perch,automount";
source ${prefix}/rules/iso/custom_partnew.sh;
