menuentry $"Android-x86 Live" --class android{
    set kcmdline="root=/dev/ram0";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
if [ "${android_selinux}" = " " ]; then
    menuentry "[ ] androidboot.selinux=permissive"{
        export android_selinux="androidboot.selinux=permissive";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] androidboot.selinux=permissive"{
        export android_selinux=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;
if [ "${android_hardware}" = " " ]; then
    menuentry "[ ] androidboot.hardware=android_x86"{
        export android_hardware="androidboot.hardware=android_x86";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] androidboot.hardware=android_x86"{
        export android_hardware=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;
