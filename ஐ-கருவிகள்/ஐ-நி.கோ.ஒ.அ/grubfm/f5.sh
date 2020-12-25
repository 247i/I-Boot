# Grub2-FileManager
# Copyright (C) 2020  A1ive.
#
# Grub2-FileManager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Grub2-FileManager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Grub2-FileManager.  If not, see <http://www.gnu.org/licenses/>.

if [ -n "${aioboot}" ];
then
  if [ "${grub_platform}" = "efi" ];
  then
    chainloader -t (${aioboot})/efi/boot/boot${EFI_ARCH}.efi;
  else
    set root=${aioboot};
    multiboot /AIO/grub/i386-pc/core.img;
  fi;
  boot;
elif [ -n "${ventoy}" ];
then
  if [ "${grub_platform}" = "efi" ];
  then
    if [ -f (${ventoy})/efi/boot/VENTOY${EFI_ARCH}.efi ];
    then
      chainloader -t (${ventoy})/efi/boot/VENTOY${EFI_ARCH}.efi;
    else
      chainloader -t (${ventoy})/efi/boot/BOOT${EFI_ARCH}.efi;
    fi;
  elif [ -f "(${ventoy})/ventoy/core.img" ];
  then
    set root=${ventoy};
    multiboot /ventoy/core.img;
  else
    regexp --set=1:vtdisk '(hd[0-9]+)[0-9,]*' "${ventoy}";
    chainloader (${vtdisk})+1;
  fi;
  boot;
else
  configfile ${prefix}/netboot.sh;
fi;
