REM This file was created for YUMI
@echo off
cls
 cd VHDDISK:\windows\system32
 bcdboot VHDDISK:\windows /s VHDDISK: /f ALL
exit