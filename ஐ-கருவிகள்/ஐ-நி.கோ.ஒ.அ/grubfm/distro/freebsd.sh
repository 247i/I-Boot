if test -f /boot/kernel/kernel*; then
    set bsd_kernel=/boot/kernel/kernel*;
else
    set bsd_kernel=/boot/kernel/kfreebsd.gz;
fi;
set bsd_mfsroot=/boot/mfsroot.gz;
enable_progress_indicator=1;
echo $"Loading kernel";
kfreebsd ${bsd_kernel};
echo $"Loading ISO";
if test -f ${bsd_mfsroot}; then
    kfreebsd_module "${bsd_mfsroot}" type=mfs_root;
else
    kfreebsd_module "${linux_extra}" type=mfs_root;
    set kFreeBSD.vfs.root.mountfrom=cd9660:/dev/md0;
    set kFreeBSD.vfs.root.mountfrom.options=ro;
    set kFreeBSD.grub.platform=$grub_platform;
fi;
echo $"Starting FreeBSD";

# for use with YUMI - derived from e2b.sh 
source ${prefix}/func.sh;
source ${prefix}/rules/iso/boot_functions.sh

stat --set=frag -c -q "${grubfm_file}";
if [ "${frag}" != "1" ];
then
  echo $"ERROR:"
  echo $"File is non-contiguous. (${frag} fragments)";
  sleep 3;
  return;
fi;

if [ -d (${grubfm_disk},4) ];
then
  echo $"WARNING: Will erase ALL data on (${grubfm_disk},4)";
  echo $"Press [1] to continue. Press any other key to return.";
  getkey key;
else
  key=49;
fi;
if [ x$key = x49 ];
then
  partnew --type=0x00 --file="${grubfm_file}" "${grubfm_disk}" 4;
  if [ "$grub_platform" = "efi" ];
  then
    map -f "${grubfm_file}";
    set loop="vd0"
    export loop	
    set root="(vd0)"
    
if test -f /boot/kernel/kernel*; then
    set bsd_kernel=/boot/kernel/kernel*;
else
    set bsd_kernel=/boot/kernel/kfreebsd.gz;
fi;
set bsd_mfsroot=/boot/mfsroot.gz;
enable_progress_indicator=1;
echo $"Loading kernel";
kfreebsd ${bsd_kernel};
echo $"Loading ISO";
if test -f ${bsd_mfsroot}; then
    kfreebsd_module "${bsd_mfsroot}" type=mfs_root;
else
    kfreebsd_module "${linux_extra}" type=mfs_root;
    set kFreeBSD.vfs.root.mountfrom=cd9660:/dev/md0;
    set kFreeBSD.vfs.root.mountfrom.options=ro;
    set kFreeBSD.grub.platform=$grub_platform;
fi;
echo $"Starting FreeBSD";

  else
    to_g4d_path "${grubfm_file}";
    if [ -n "${g4d_path}" ];
    then
      set g4d_cmd="map --mem (rd)+1 (fd0);map --hook;configfile (fd0)/menu.lst";
      to_g4d_menu "set file=${g4d_path}\x0amap %file% (0xff)\x0amap --hook\x0achainloader (0xff)\x0aboot";
      linux ${prefix}/grub.exe --config-file=${g4d_cmd};
      initrd (rd);
    fi;
  fi;
else
  echo $"Canceled.";
  sleep 3;
fi;
