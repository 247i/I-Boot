set kcmdline="archisobasedir=sysresccd copytoram";
set vmlinuz_img="(loop)/sysresccd/boot/x86_64/vmlinuz";
set initrd_img="(loop)/sysresccd/boot/intel_ucode.img (loop)/sysresccd/boot/amd_ucode.img (loop)/sysresccd/boot/x86_64/sysresccd.img"
source ${prefix}/rules/iso/custom_partnew.sh;