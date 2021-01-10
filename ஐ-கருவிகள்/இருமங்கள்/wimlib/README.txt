								INTRODUCTION

wimlib is a C library for creating, modifying, extracting, and mounting files in the Windows Imaging
Format (WIM files)on UNIX-like systems and Windows.  wimlib and its command-line frontend 'wimlib-imagex'
provide a free and cross-platform alternative to Microsoft's WIMGAPI, ImageX,
and DISM.

								INSTALLATION

To install wimlib and wimlib-imagex on UNIX-like systems, you can compile from
source (e.g. './configure && make && sudo make install').  Alternatively, check
if a package has already been prepared for your operating system.  Example files
for Debian and RPM packaging are in the debian/ and rpm/ directories.

To install wimlib and wimlib-imagex on Windows, just download and extract the
ZIP file containing the latest binaries.  See README.WINDOWS for more details.

All official wimlib releases are available from https://wimlib.net.

                                   WIM FILES

A Windows Imaging (WIM) file is an archive designed primarily for archiving
Windows filesystems.  However, it can be used on other platforms as well, with
some limitations.  Like some other archive formats such as ZIP, files in WIM
archives may be compressed.  WIM archives support multiple compression formats,
including LZX, XPRESS, and LZMS.  All these formats are supported by wimlib.

A WIM archive contains one or more "images", each of which is a logically
independent directory tree.  Each image has a 1-based index and usually a name.

WIM archives provide data deduplication at the level of full file contents.  In
other words, each unique "file contents" is only stored once in the archive,
regardless of how many files have that contents across all images.

A WIM archive may be either stand-alone or split into multiple parts.

An update of the WIM format --- first added by Microsoft for Windows 8 ---
supports solid-mode compression.  This refers to files being compressed together
(e.g. as in a .tar.xz or .7z archive) rather than separately (e.g. as in a .zip
archive).  This usually produces a much better compression ratio.  Solid
archives are sometimes called "ESD files" by Microsoft and may have the ".esd"
file extension rather than ".wim".  They are supported in wimlib since v1.6.0.

                             IMAGEX IMPLEMENTATION

wimlib itself is a C library, and it provides a documented public API (See:
https://wimlib.net/apidoc) for other programs to use.  However, it is also
distributed with a command-line program called "wimlib-imagex" that uses this
library to implement an imaging tool similar to Microsoft's ImageX.
wimlib-imagex supports almost all the capabilities of Microsoft's ImageX as well
as additional capabilities.  wimlib-imagex works on both UNIX-like systems and
Windows, although some features differ between the platforms.

Run `wimlib-imagex' with no arguments to see an overview of the available
commands and their syntax.  For additional documentation:

  * If you have installed wimlib-imagex on a UNIX-like system, you will find
    further documentation in the man pages; run `man wimlib-imagex' to get
    started.

  * If you have downloaded the Windows binary distribution, you will find the
    documentation for wimlib-imagex in PDF format in the "doc" directory,
    ready for viewing with any PDF viewer.  Please note that although the PDF
    files are converted from UNIX-style "man pages", they do document
    Windows-specific behavior when appropriate.

                                  COMPRESSION

wimlib (and wimlib-imagex) can create XPRESS, LZX, and LZMS compressed WIM
archives.  wimlib's compression codecs usually outperform and outcompress their
closed-source Microsoft equivalents.  Multiple compression levels and chunk
sizes as well as solid mode compression are supported.  Compression is
multithreaded by default.  Detailed benchmark results and descriptions of the
algorithms used can be found at https://wimlib.net/compression.html.

                                  NTFS SUPPORT

WIM images may contain data, such as alternate data streams and
compression/encryption flags, that are best represented on the NTFS filesystem
used on Windows.  Also, WIM images may contain security descriptors which are
specific to Windows and cannot be represented on other operating systems.
wimlib handles this NTFS-specific or Windows-specific data in a
platform-dependent way:

  * In the Windows version of wimlib and wimlib-imagex, NTFS-specific and
    Windows-specific data are supported natively.

  * In the UNIX version of wimlib and wimlib-imagex, NTFS-specific and
    Windows-specific data are ordinarily ignored; however, there is also special
    support for capturing and extracting images directly to/from unmounted NTFS
    volumes.  This was made possible with the help of libntfs-3g from the
    NTFS-3G project.

For both platforms the code for NTFS capture and extraction is complete enough
that it is possible to apply an image from the "install.wim" contained in recent
Windows installation media (Vista or later) directly to an NTFS filesystem, and
then boot Windows from it after preparing the Boot Configuration Data.  In
addition, a Windows installation can be captured (or backed up) into a WIM file,
and then re-applied later.

                                   WINDOWS PE

A major use for wimlib and wimlib-imagex is to create customized images of
Windows PE, the Windows Preinstallation Environment, on either UNIX-like systems
or Windows without having to rely on Microsoft's software and its restrictions
and limitations.

Windows PE is a lightweight version of Windows that can run entirely from memory
and can be used to install Windows from local media or a network drive or
perform maintenance.  It is the operating system that runs when you boot from
the Windows installation media.

You can find Windows PE on the installation media for Windows (Vista or later)
as the file `sources/boot.wim'.  Windows PE can also be found in the Windows
Automated Installation Kit (WAIK), which is free to download from Microsoft,
inside the `WinPE.cab' file, which you can extract natively on Windows, or on
UNIX-like systems if you install either the `cabextract' or `p7zip' programs.

In addition, Windows installations and recovery partitions frequently contain a
WIM containing an image of the Windows Recovery Environment, which is similar to
Windows PE.

A shell script `mkwinpeimg' is distributed with wimlib on UNIX-like systems to
ease the process of creating and customizing a bootable Windows PE image.

                                  DEPENDENCIES

This section documents the dependencies of wimlib and the programs distributed
with it, when building for a UNIX-like system from source.  If you have
downloaded the Windows binary distribution of wimlib and wimlib-imagex then all
dependencies were already included and this section is irrelevant.

* libxml2 (required)
	This is a commonly used free library to read and write XML documents.
	Almost all Linux distributions should include this; however, you may
	need to install the header files, which might be in a package named
	"libxml2-dev" or similar.  For more information see http://xmlsoft.org/.

* libfuse (optional but recommended)
	Unless configured --without-fuse, wimlib requires a non-ancient version
	of libfuse.  Most Linux distributions already include this, but make
	sure you have the libfuse package installed, and also libfuse-dev if
	your distribution distributes header files separately.  FUSE also
	requires a kernel module.  If the kernel module is available it should
	automatically be loaded if you try to mount a WIM image.  For more
	information see http://fuse.sourceforge.net/.

* libntfs-3g (optional but recommended)
	Unless configured --without-ntfs-3g, wimlib requires the library and
	headers for libntfs-3g to be installed.  The minimum required version is
	2011-4-12, but newer versions contain important bug fixes.

* OpenSSL / libcrypto (optional)
	wimlib can use the SHA-1 message digest implementation from libcrypto
	(usually provided by OpenSSL) instead of compiling in yet another SHA-1
	implementation.

* cdrkit (optional)
* mtools (optional)
* syslinux (optional)
* cabextract (optional)
	The `mkwinpeimg' shell script will look for several other programs
	depending on what options are given to it.  Depending on your Linux
	distribution, you may already have these programs installed, or they may
	be in the software repository.  Making an ISO filesystem requires
	`mkisofs' from `cdrkit' (http://www.cdrkit.org).  Making a disk image
	requires `mtools' (http://www.gnu.org/software/mtools) and `syslinux'
	(http://www.syslinux.org).  Retrieving files from the Windows Automated
	Installation Kit requires `cabextract' (http://www.cabextract.org.uk).

                                 CONFIGURATION

This section documents the most important options that may be passed to the
"configure" script when building from source:

--without-ntfs-3g
	If libntfs-3g is not available or is not version 2011-4-12 or later,
	wimlib can be built without it, in which case it will not be possible to
	capture or apply WIM images directly from/to NTFS volumes.

	The default is --with-ntfs-3g when building for any UNIX-like system,
	and --without-ntfs-3g when building for Windows.

--without-fuse
	The --without-fuse option disables support for mounting WIM images.
	This removes dependencies on libfuse and librt.  The wimmount,
	wimmountrw, and wimunmount commands will not work.

	The default is --with-fuse when building for Linux, and --without-fuse
	otherwise.

--without-libcrypto
	Build in functions for SHA-1 rather than using external SHA-1 functions
	from libcrypto (usually provided by OpenSSL).

	The default is to use libcrypto if it is found on your system.

 gcc and clang are the only supported compilers.  A few nonstandard
extensions are used in the code.


                                    HISTORY

wimlib was originally a project started by Carl Thijssen for use on Linux in the
Ultimate Deployment Appliance (http://www.ultimatedeployment.org/). 
                                    NOTICES

email to ebiggers3@gmail.com or posted to https://wimlib.net/forums.

On UNIX-like systems, if you do not want wimlib to be dynamically linked with
libcrypto (OpenSSL), configure with --without-libcrypto.  This replaces the SHA1
implementation with built-in code and there will be no difference in
functionality.
