Rem Converts syslinux to grub
grub-install.exe --force --no-floppy --target=i386-pc --boot-directory=E:\! //./PHYSICALDRIVE1
grub-install.exe --force --removable --no-floppy --target=i386-efi --boot-directory=E:\! --efi-directory=E:\!
grub-install.exe --force --removable --no-floppy --target=x86_64-efi --boot-directory=E:\! --efi-directory=E:\!