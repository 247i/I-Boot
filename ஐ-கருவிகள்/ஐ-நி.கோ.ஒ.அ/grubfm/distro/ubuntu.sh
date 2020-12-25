# This entry created for YUMI

# Create a partition, (if it isn't in use) and mount the ISO
if ! test -d ($grubfm_disk,4) ; then 
     partnew --type=0x00 --file="$grubfm_file" ($grubfm_disk) 4  
fi 
# Check for a persistence file, then if it exists, create a partition, (if it isn't in use) and mount it
if test -f "$grubfm_current_path/writable"; then 
     set casper_file="$grubfm_current_path/writable"
	 set persist="persistent"
	 set pertype="writable"
        if ! test -d ($grubfm_disk,3) ; then 
	     partnew --type=0x00 --file="$casper_file" ($grubfm_disk) 3
	     loopback casper "$casper_path"	 
	     echo "Booting $grubfm_name with $pertype persistence ..." 
        fi	 	  	 
elif test -f "$grubfm_current_path/casper-rw"; then 
	 set casper_file="$grubfm_current_path/casper-rw"
	 set persist="persistent"
	 set pertype="casper-rw"
        if ! test -d ($grubfm_disk,3) ; then 
	     partnew --type=0x00 --file="$casper_file" ($grubfm_disk) 3
	     loopback casper "$casper_path"	 
	     echo "Booting $grubfm_name with $pertype persistence ..." 
        fi	
else
	 echo "Booting $grubfm_name without persistence ..."	
fi	 
	
# Set linux - vmlinu* via wildcard (catch all) 
if test -f (loop)/casper/vmlinu*; then 
     set vmlinuz="(loop)/casper/vmlinu*"; fi		
# Set initrd - init* via wildcard (catch all)
if test -f (loop)/casper/init*; then 
     set initrd="(loop)/casper/init*"; fi	 
linux $vmlinuz fsck.mode=skip boot=casper noprompt noeject $persist	 
initrd $initrd		 
