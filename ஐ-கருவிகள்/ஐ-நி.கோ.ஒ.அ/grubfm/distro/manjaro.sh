# set icon="manjaro";
# function manjaro_menu {
    # menuentry $"Manjaro Live" --class $icon{
        # set kcmdline="earlymodules=loop misobasedir=manjaro nouveau.modeset=1 i915.modeset=1 radeon.modeset=1 logo.nologo overlay=free splash showopts";
# source ${prefix}/rules/iso/custom_partnew.sh;
    # }
    # menuentry $"Manjaro Live (non-free drivers)" --class $icon{
        # set kcmdline="earlymodules=loop misobasedir=manjaro nouveau.modeset=0 i915.modeset=1 radeon.modeset=0 nonfree=yes logo.nologo overlay=nonfree splash showopts";
# source ${prefix}/rules/iso/custom_partnew.sh;
    # }
# }
if test -f (loop)/manjaro/boot/*/vmlinuz* -a -f (loop)/manjaro/boot/*/initramfs*; then
    set vmlinuz_img="/manjaro/boot/*/vmlinuz*";
    set initrd_img="/manjaro/boot/*/initramfs*";
    manjaro_menu;
elif test -f (loop)/boot/vmlinuz* -a -f (loop)/boot/initramfs*; then
    set vmlinuz_img="/boot/vmlinuz*";
    set initrd_img="/boot/initramfs*";
    manjaro_menu;
fi;
source ${prefix}/rules/iso/custom_partnew.sh;
