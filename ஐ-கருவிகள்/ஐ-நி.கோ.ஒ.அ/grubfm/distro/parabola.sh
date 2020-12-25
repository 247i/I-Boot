set vmlinuz_img="/parabola/boot/x86_64/vmlinuz*";
set initrd_img="/parabola/boot/x86_64/parabolaiso.img";
set kcmdline="earlymodules=loop";
source ${prefix}/rules/iso/custom_partnew.sh;
