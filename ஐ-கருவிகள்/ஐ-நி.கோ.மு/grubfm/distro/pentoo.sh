set vmlinuz_img="/isolinux/pentoo";
set initrd_img="/isolinux/pentoo.xz";
set kcmdline="root=/dev/ram0 init=/linuxrc nox nodhcp aufs max_loop=256 dokeymap looptype=squashfs loop=/image.squashfs cdroot video=uvesafb:mtrr:3,ywrap,1024x768-16 usbcore.autosuspend=1 console=tty0 net.ifnames=0";
source ${prefix}/rules/iso/custom_partnew.sh;
