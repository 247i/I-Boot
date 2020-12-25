set icon="opensuse";
set vmlinuz_img="/boot/*/loader/linux";
set initrd_img="/boot/*/loader/initrd";

if [ -d (loop)/LiveOS ];
then
    set kcmdline="rd.live.image splash=silent";
fi;
source ${prefix}/rules/iso/custom_partnew.sh;
