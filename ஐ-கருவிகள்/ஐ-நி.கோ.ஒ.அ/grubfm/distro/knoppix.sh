set vmlinuz_img="/boot/isolinux/linux";
set initrd_img="/boot/isolinux/minirt.gz";
set kcmdline="ramdisk_size=100000 lang=en apm=power-off nomce libata.force=noncq hpsa.hpsa_allow_any=1 loglevel=1 tz=localtime";
set linux_suffix=;
set kernel_arch=;
if [ "$grub_platform" != "efi" ];
then
  set linux_suffix=16;
fi;
if cpuid -l;
then
  if [ -f (loop)/boot/isolinux/linux64 ];
  then
    set vmlinuz_img="/boot/isolinux/linux64";
  fi;
fi;
source ${prefix}/rules/iso/custom_partnew.sh;