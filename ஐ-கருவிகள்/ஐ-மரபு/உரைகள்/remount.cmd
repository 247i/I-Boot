rem http://tamilneram.github.io
@echo off
cls

 Set Distroname=ISONAMESLUG
 echo %Distroname%
 subst Z: "%~d0\!\%Distroname%"
 echo mounted "%~d0\!\%Distroname%" as Z:
 REM pause
exit