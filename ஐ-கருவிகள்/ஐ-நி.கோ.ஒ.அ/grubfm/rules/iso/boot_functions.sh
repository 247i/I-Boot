# This file was created for use with YUMI 

# What to do with the ISO file
function _filemod {
     if [ -d ($bootdev,4) ]; then
         echo $"WARNING: Will erase ALL data on ($bootdev,4)"
         echo $"Press [1] to continue. Press any other key to return."
         getkey key
     else
         key=49
     fi

     if [ x$key = x49 ]; then
         partnew --type=0x00 --file=$iso_path ($bootdev) 4
         loopback loop "$iso_path"

     if [ "$grub_platform" = "efi" ];
         then
         map -f "$iso_path";
     else
         #set cmd="set file=$iso_path;map --mem (rd)+1 (fd0);map --hook;configfile (fd0)/menu.lst;map %file% (0xff);map --hook;chainloader (0xff);boot";
         set cmd="set file=$iso_path;map %file% (0xff);map --hook;chainloader (0xff)";
         linux ${prefix}/grub.exe --config-file=$cmd;
         initrd (rd);
	 fi 	     
	 fi 
}

function _ubuntu_mod {
     if [ -d ($bootdev,4) ]; then
         echo $"WARNING: Will erase ALL data on ($bootdev,4)"
         echo $"Press [1] to continue. Press any other key to return."
         getkey key
     else
         key=49
     fi

     if [ x$key = x49 ]; then
         partnew --type=0x00 --file=$iso_path ($bootdev) 4
         loopback loop "$iso_path"     
	 fi 
}

# Does a persistence file exist? - if so, how to handle it
function _persistent {
     if [ -e $dir/writable ]; then
         set casper_path=$dir/writable
	     set persist="persistent"
	     set pertype="writable"	 
		 
        if [ -d ($bootdev,3) ]; then
            echo $"WARNING: Will erase ALL data on ($bootdev,3)"
            echo $"Press [1] to continue. Press any other key to return."
            getkey key
        else
            key=49
        fi

        if [ x$key = x49 ]; then
            partnew --type=0x00 --file=$casper_path ($bootdev) 3
		    loopback casper "$casper_path"	 
	        echo "Booting $isoname with $pertype persistence ..." 
	    fi			 
		 
		 
     elif [ -e $dir/casper-rw ]; then
         set casper_path=$dir/casper-rw
	     set persist="persistent"
	     set pertype="casper-rw"
		 
        if [ -d ($bootdev,3) ]; then
            echo $"WARNING: Will erase ALL data on ($bootdev,3)"
            echo $"Press [1] to continue. Press any other key to return."
            getkey key
        else
            key=49
        fi

        if [ x$key = x49 ]; then
            partnew --type=0x00 --file=$casper_path ($bootdev) 3
		    loopback casper "$casper_path"	 
	        echo "Booting $isoname with $pertype persistence ..." 
	    fi	
     else
	        echo "Booting $isoname without persistence ..."
	 fi	 
}  

# Loading the Kernel
function _vmlinuz {
# Ubuntu Based
     if [ -e ($loop)/casper/vmlinu* ]; then
      for vmlinuz in ($loop)/casper/vmlinu*; do set vmlinuz; done
      linux $vmlinuz fsck.mode=skip boot=casper noprompt noeject $persist	
# Debian Live Based
     elif [ -e ($loop)/live/vmlinu* ]; then
      for vmlinuz in ($loop)/live/vmlinu*; do set vmlinuz; done
      linux $vmlinuz boot=live noprompt noeject floppy.allowed_drive_mask=0 ignore_uuid
# CentOS Based			  
# Puppy Based
     elif [ -e ($loop)/vmlinuz ]; then
      linux ($loop)/vmlinuz pfix=fsck pmedia=cd iso-scan/filename=$isopath		
# System rescue
     elif [ -e ($loop)/isolinux/rescue64 ]; then
      linux ($loop)/isolinux/rescue64 isoloop=$isopath docache
	  initrd ($loop)/isolinux/initram.igz 
     elif [ -e ($loop)/boot/grub/grubsrcd.cfg ]; then	 
	 set root=(loop)
	 configfile /boot/grub/grubsrcd.cfg
     #elif [ -e ($loop)/sysresccd/boot/x86_64/vmlinuz ]; then	 
      #probe -u $root --set=rootuuid
      #set imgdevpath="/dev/disk/by-uuid/$rootuuid"
      #export imgdevpath rootuuid
      #probe --label --set=cd_label ($loop)
      #linux ($loop)/sysresccd/boot/x86_64/vmlinuz "img_dev=$imgdevpath img_loop=$isopath earlymodules=loop archisobasedir=sysresccd archisolabel=$cd_label"
      #initrd ($loop)/sysresccd/boot/intel_ucode.img ($loop)/sysresccd/boot/amd_ucode.img ($loop)/sysresccd/boot/x86_64/sysresccd.img
# CentOS	  
	 elif [ -e ($loop)/isolinux/vmlinuz ]; then
	 linux ($loop)/isolinux/vmlinuz
	 initrd ($loop)/isolinux/initrd.img
	 fi											
}

function _config {
# Priority - Catch All Configs
#if [ -e ($loop)/boot/grub/loopback.cfg ]; then
# configfile ($loop)/boot/grub/loopback.cfg
if [ -e ($loop)/boot/grub/grub.cfg ]; then
	configfile ($loop)/boot/grub/grub.cfg
elif [ -e ($loop)/BOOT/GRUB/GRUBSRCD.cfg ]; then
	configfile ($loop)/BOOT/GRUB/GRUBSRCD.cfg	
elif [ -e ($loop)/grub/grub.cfg ]; then
	configfile ($loop)/grub/grub.cfg
elif [ -e ($loop)/EFI/BOOT/grub.cfg ]; then
	configfile ($loop)/EFI/BOOT/grub.cfg
elif [ -e ($loop)/EFI/debian/grub/grub.cfg ]; then
	configfile ($loop)/EFI/debian/grub/grub.cfg	
elif [ -e ($loop)/isolinux.cfg ]; then
	syslinux_configfile ($loop)/isolinux.cfg	 
#elif [ -e ($loop)/isolinux/live.cfg ]; then
	#syslinux_configfile ($loop)/isolinux/live.cfg
elif [ -e ($loop)/boot/isolinux/isolinux.cfg ]; then
	syslinux_configfile ($loop)/boot/isolinux/isolinux.cfg
elif [ -e ($loop)/boot/isolinux/syslinux.cfg ]; then
	syslinux_configfile ($loop)/boot/syslinux/isolinux.cfg	
elif [ -e ($loop)/boot/syslinux/syslinux.cfg ]; then
	syslinux_configfile ($loop)/boot/syslinux/syslinux.cfg	
elif [ -e ($loop)/boot/syslinux/porteus.cfg ]; then
	syslinux_configfile ($loop)/boot/syslinux/porteus.cfg	  
elif [ -e ($loop)/slax/boot/syslinux.cfg ]; then
	syslinux_configfile ($loop)/slax/boot/syslinux.cfg
else	  
# Else try directly allocated linux/initrd 
	linux ($loop)$vmlinuz_img $kcmdline;
    initrd ($loop)$initrd_img;	  
fi	
}

# Loading the Initial Ram Filesystem
function _initrd {
# Ubuntu Based
     if [ -e ($loop)/casper/init* ]; then
	  for initrd in ($loop)/casper/init*; do set initrd; done
	  #for initrd in ($loop)/casper/init*; do echo $initrd; done
      initrd $initrd	
     elif [ -e ($loop)/boot/grub/initrd.xz ]; then
         initrd ($loop)/boot/grub/initrd.xz
     elif [ -e ($loop)/initrd.gz ]; then
         initrd ($loop)/initrd.gz
     elif [ -e ($loop)/initrd.lz ]; then
         initrd ($loop)/initrd.lz	
     elif [ -e ($loop)/initrd ]; then
         initrd ($loop)/initrd		 
# Debian Live Based	
     elif [ -e ($loop)/live/init* ]; then
      for initrd in ($loop)/live/init*; do set initrd; done	  
      initrd ${initrd}	  
# Slax Based
     elif [ -e ($loop)/slax/boot/initrfs.img ]; then
        initrd /slax/boot/initrfs.img
# Parted Magic		
     elif [ -e ($loop)/pmagic/initrd.img ]; then
        initrd /pmagic/initrd.img
     elif [ -e ($loop)/boot/initrd.xz ]; then
        initrd /boot/initrd.xz
     elif [ -e ($loop)/boot/initrd.gz ]; then
        initrd /boot/initrd.gz
     elif [ -f ($loop)/boot/initrd ]; then
        initrd /boot/initrd
     elif [ -f ($loop)/boot/x86_64/loader/initrd ]; then
        initrd /boot/x86_64/loader/initrd
     elif [ -f ($loop)/boot/initramfs-x86_64.img ]; then
        initrd /boot/initramfs-x86_64.img
     elif [ -f ($loop)/boot/isolinux/initramfs_data64.cpio.gz ]; then 
        initrd /boot/isolinux/initramfs_data64.cpio.gz 	
# Isolinux init		
     elif [ -f ($loop)/isolinux/initrd.gz ]; then 
        initrd /isolinux/initrd.gz	
     else
	 _config
	 fi
}

#menuentry "manual test" {
# set iso_path="/multiboot/linuxmint-19.3-mate-32bit/linuxmint-19.3-mate-32bit.iso"
# export iso_path

#if [ -d ($bootdev,4) ]; then
#  echo $"WARNING: Will erase ALL data on ($bootdev,4)"
#  echo $"Press [1] to continue. Press any other key to return."
#  getkey key
#else
#  key=49
#fi

#if [ x$key = x49 ]; then
#  partnew --type=0x00 --file=$iso_path ($bootdev) 4
  
#  if [ "$grub_platform" = "efi" ]; then
#   map -f "$iso_path"
#   set loop=vd0
#   export loop
   #linux (vd0)/casper/vmlinuz fsck.mode=skip boot=casper noprompt noeject floppy.allowed_drive_mask=0 ignore_uuid
   #initrd (vd0)/casper/initrd.lz
#  else
#  loopback loop "$iso_path"
#  set loop=loop
#  export loop
# fi
#fi
# _vmlinuz
# _initrd
#}

