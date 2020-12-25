menuentry $"Parted Magic (x86_64)" --class $icon{
    set kcmdline="eject=no load_ramdisk=1";
    set vmlinuz_img="/pmagic/bzImage64";
    set initrd_img="/pmagic/initrd.img (loop)/pmagic/fu.img (loop)/pmagic/m64.img";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry $"Parted Magic (i686)" --class $icon{
    set kcmdline="eject=no load_ramdisk=1";
    set vmlinuz_img="/pmagic/bzImage";
    set initrd_img="/pmagic/initrd.img (loop)/pmagic/fu.img (loop)/pmagic/m32.img";
    source ${prefix}/rules/iso/custom_partnew.sh;
}