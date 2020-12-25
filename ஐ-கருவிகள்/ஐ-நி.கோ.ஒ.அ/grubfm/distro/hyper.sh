set vmlinuz_img="/hyperbola/boot/x86_64/vmlinuz";
set initrd_img="/hyperbola/boot/x86_64/hyperiso.img";
set kcmdline="hyperisobasedir=hyperbola earlymodules=loop";
source ${prefix}/rules/iso/custom_partnew.sh;