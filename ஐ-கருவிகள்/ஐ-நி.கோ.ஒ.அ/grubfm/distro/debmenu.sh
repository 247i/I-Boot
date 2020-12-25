menuentry $"Debian Live" --class debian{
    set kcmdline="boot=live config";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry $"Devuan Live" --class devuan{
    set kcmdline="boot=live config username=devuan";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry $"Elive Live" --class elive{
    set kcmdline="boot=live config username=eliveuser components union=aufs loglevel=0 quiet splash modprobe.blacklist=nouveau,radeonhd,radeon,vmwgfx";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry $"ExTiX Live" --class extix{
    set kcmdline="boot=live username=live";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry $"Q4OS Live" --class q4os{
    set kcmdline="boot=live components username=adminq user-fullname=Admin_Q4OS loglevel=3 systemd.log_color=0 systemd.show_status=1";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
menuentry $"Tails Live" --class tails{
    set kcmdline="boot=live config apparmor=1 security=apparmor nopersistence noprompt timezone=Etc/UTC block.events_dfl_poll_msecs=1000 splash noautologin module=Tails kaslr slab_nomerge slub_debug=FZP mce=0 vsyscall=none page_poison=1 union=aufs";
    source ${prefix}/rules/iso/custom_partnew.sh;
}
if [ "${debian_user}" = "username=root" ]; then
    menuentry "[+] Root Login"{
        export debian_user="username=user";
        configfile ${prefix}/distro/debmenu.sh;
    }
else
    menuentry "[ ] Root Login"{
        export debian_user="username=root";
        configfile ${prefix}/distro/debmenu.sh
    }
fi;
if [ "${debian_union}" = "union=overlay" ]; then
    menuentry "[+] Overlay (Clonezilla/GParted)"{
        export debian_union="";
        configfile ${prefix}/distro/debmenu.sh;
    }
else
    menuentry "[ ] Overlay (Clonezilla/GParted)"{
        export debian_union="union=overlay";
        configfile ${prefix}/distro/debmenu.sh
    }
fi;
if [ "${debian_locale}" = "locales=zh_CN.UTF-8" ]; then
    menuentry "[+] Chinese locale"{
        export debian_locale="";
        configfile ${prefix}/distro/debmenu.sh;
    }
elif [ "${debian_locale}" = "locales=zh_TW.UTF-8" ]; then
    menuentry "[+] Chinese locale"{
        export debian_locale="";
        configfile ${prefix}/distro/debmenu.sh;
    }
else
    menuentry "[ ] Chinese locale"{
        if [ "${lang}" = "zh_CN" ]; then
            export debian_locale="locales=zh_CN.UTF-8";
        elif [ "${lang}" = "zh_TW" ]; then
            export debian_locale="locales=zh_TW.UTF-8";
        fi;
        configfile ${prefix}/distro/debmenu.sh
    }
fi;
if [ "${debian_toram}" = "toram" ]; then
    menuentry "[+] Copy to RAM"{
        export debian_toram="";
        configfile ${prefix}/distro/debmenu.sh;
    }
else
    menuentry "[ ] Copy to RAM"{
        export debian_toram="toram";
        configfile ${prefix}/distro/debmenu.sh
    }
fi;
