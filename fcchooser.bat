@echo off
REM Custom Fw chooser and flash starter
REM worked with bret8883 on it after he put out super patcher
REM made by digdat0, credits to ALL the OG's and folks in the community
CLS
SETLOCAL DisableDelayedExpansion
REM only need java if using download.jar (thanks binary)
java -version >nul 2>&1 && ( GOTO:MAIN
  ) || ( call )
javac -version >nul 2>&1 && ( GOTO:MAIN
 ) || ( echo.-: Java not installed...
pause
exit )
:MAIN
SET APPVER=1.1
SET ORIGDATE=June 29, 2019
SET SAVEDATE=%DATE%
REM change build version + versions when new builds to update
set downloadpath="http://dji.polybotes.feralhosting.com/DJI-Firmware/BIN/! Matoupi FC_Patcher Custom Modified Firmare (Multiple Bird Models)/"
REM GOTO FLOW
GOTO INTRO
:INTRO
@echo off
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  Welcome to FC Chooser %appver%. 
ECHO.
ECHO  This batch file will help you easily patch newer DJI aicraft. Supported AC and verions are:
echo.
ECHO  	-:- .. Mavic Pro 1 / Mavic Platinum / Mavic Artic White 1.04.0300
ECHO  	-:- .. Phantom 4 Standard 2.00.0700
ECHO  	-:- .. Phantom 4 Advanced 1.00.0128
ECHO  	-:- .. Phantom 4 Pro 1.05.0600
ECHO  	-:- .. Phantom 4 Pro v2 1.00.1500
ECHO  	-:- .. Inspire 2 1.02.0200
ECHO  	-:- .. Spark 1.00.0900
ECHO.
ECHO. This tool will remove height and flight zone restrictions. All other mods including
ECHO  speed changes, battery changes, motor start, etc need to be done in assistant 1.1.2.
ECHO.
ECHO  Use this software at your own risk. There is risk you could negatively affect your 
ECHO  aircraft, you assume all responsiblity as you execute the required steps/software.
echo.
ECHO  Credits .. alot of smart folk put in alot of work. I want to give kudos to all the
ECHO  OG's, Matioupi, mefistotelis, fvantienen, brett883 and anyone else involved 
ECHO  with making the fc patcher toolset or associated tools. Here's to the community.
echo.
echo. created by digdat0 %ORIGDATE%
ECHO -------------------------------------------------------------------------------------------
ECHO.
pause
GOTO selectFILEMAIN
:FLOW 
REM This is temp to allow easy testing
@echo off
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Which flow? User selection or fw file detection?
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO   1) Detect and display custom fw filename in folder
ECHO   2) User selected firmware choice from a list
ECHO.
SET /P M=Chose your aircraft: 
IF %M%==1 GOTO selectFILEMAIN
IF %M%==2 GOTO MAIN1
IF %M%==Q GOTO CREDITS
IF %M%==X GOTO CREDITS
IF %M%==q GOTO CREDITS
IF %M%==x GOTO CREDITS
:RESOLVE
SET filename=%1
GOTO :EOF
:selectFILEMAIN
REM the tool will detect if there are dji_system.* files in the folder, if so will prompt and ask user to select
REM if no detection is found, then it moves to user choice of aircraft
@echo off
md tools
IF EXIST "*dji_system.*" (
ECHO IT worked
CLS
) ELSE (
  GOTO MAIN1
)
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Pick the firmware file you want to use ...
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
@ECHO OFF
SET index=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*dji_system.*) DO (
   SET file!index!=%%f
   ECHO   !index! - %%f
   SET /A index=!index!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION
ECHO.
SET /P selection="Select the proper file: "
SET file%selection% >nul 2>&1
IF ERRORLEVEL 1 (
   ECHO.
   ECHO Invalid number selected
   TIMEOUT 2   
   GOTO MAIN1
)
CALL :RESOLVE %%file%selection%%%
ECHO Selected file name: %filename%
TIMEOUT 2 >nul
GOTO MAINDETECTFILE
:MAINDETECTFILE
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Evaluating the file ... caller please hold
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
REM we will also set variables using the filename
for /f "tokens=1-5* delims=_" %%A in ('dir /b /a-d "%filename%"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D_%%~E
  set filenameversion=%%~A
  set uname=%%~B
  set acname=%%~C
  set djiname=%%~D
  set system=%%~E
  )
if "%acname%"=="Mavic" GOTO MAVIC
if "%acname%"=="mavic" GOTO MAVIC
IF "%acname%"=="p4s" GOTO p4s
IF "%acname%"=="p4a" goto p4a
IF "%acname%"=="p4p" goto p4p
IF "%acname%"=="p4pv2" goto p4pv2
IF "%acname%"=="i2" goto i2
IF "%acname%"=="Spark" goto spk
IF "%acname%"=="spark" goto spk
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We couldnt find any valid files .. will let you choose.
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
TIMEOUT 2 >nul
GOTO MAIN1 
:MAIN1
@echo off
md tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Chose your aircraft
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO   1) Mavic Pro 1 / Mavic Platinum / Mavic Artic White
ECHO   2) Phantom 4 Standard
ECHO   3) Phantom 4 Advanced
ECHO   4) Phantom 4 Pro
ECHO   5) Phantom 4 Pro v2
ECHO   6) Inspire 2
ECHO   7) Spark
ECHO.
SET /P M=Chose your aircraft: 
IF %M%==1 GOTO MAVIC
IF %M%==2 GOTO P4S
IF %M%==3 GOTO P4A
IF %M%==4 GOTO P4P
IF %M%==5 GOTO P4PV2
IF %M%==6 GOTO I2
IF %M%==7 GOTO SPK
IF %M%==Q GOTO EXIT
:MAVIC
@echo off
set acname=Mavic
set acmodel=wm220
set neededver=1.04.0300
set fcver=3.02.44.10
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
pause
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname% 
)
cd tools
copy %fwname%  ..
del %fwname%
cd ..
rd tools
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:P4S
@echo off
set acname=Phantom 4 Standard
set acmodel=wm330
set neededver=2.00.0700
set fcver=03.02.44.07
REM set fwname=V2.00.0700_p4s_dji_system.bin
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname%
)
cd tools
copy %fwname% ..
del %fwname%
cd ..
rd tools
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:P4A
@echo off
set acname=Phantom 4 Advanced
set acmodel=wm332
set neededver=1.00.0128
set fcver=03.02.35.05
rem set fwname=V1.00.0128_p4a_dji_system.bin
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname%
)
cd tools
copy %fwname% ..
del %fwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:P4P
@echo off
set acname=Phantom 4 Pro
set acmodel=wm331
set neededver=1.05.0600
set fcver=03.02.44.07
rem set fwname=V1.05.0600_p4p_dji_system.bin
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname%
)
cd tools
copy %fwname% ..
del %fwname%
cd ..
rd tools
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:P4PV2
@echo off
set acname=Phantom 4 Pro v2
set acmodel=wm335
set neededver=1.00.1500
set fcver=03.03.04.13
rem set fwname=V1.00.1500_p4pv2_dji_system.bin
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname%
)
cd tools
copy %fwname% ..
del %fwname%
cd ..
rd tools
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:I2
@echo off
set acname=Inspire 2
set acmodel=wm620
set neededver=1.02.0200
set fcver=03.03.09.09
rem set fwname=V1.02.0200_i2_dji_system.bin
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname%
)
cd tools
copy %fwname% ..
del %fwname%
cd ..
rd tools
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:SPK
@echo off
set acname=Spark
set acmodel=wm100
set neededver=1.00.0900
set fcver=03.02.43.20
rem set fwname=V1.00.0900_spark_dji_system.bin
set fwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will download the %acname% file. This file will remove height limit, nfz and add 
ECHO  Galeleo satelite support. You must be on %neededver% for this to work.
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "%fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading %acname% custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%fwname% %fwname%
)
cd tools
copy %fwname% ..
del %fwname%
cd ..
rd tools
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Download successful. We will start patching process now for your %acname%
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
GOTO SUPERPATCHER
:SUPERPATCHER
REM Borrowed from brett8883 https://github.com/brett8883/DJI_Super-Patcher
@echo off
REM This is where you can verify and then download dumldore and nld
md tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO Downloading dumldore3 files
ECHO.
REM Downloading all individually removes need to unzip/untar
java -jar download.jar https://github.com/jezzab/DUMLdore/raw/master/DUMLdoreV3.exe DUMLdoreV3.exe
java -jar download.jar https://github.com/jezzab/DUMLdore/raw/master/payload.bin payload.bin
java -jar download.jar https://github.com/jezzab/DUMLdore/raw/master/payload_new.bin payload_new.bin
java -jar download.jar https://github.com/jezzab/DUMLdore/raw/master/root.bin root.bin
java -jar download.jar https://github.com/jezzab/DUMLdore/raw/master/root_new.bin new_root.bin
cd tools
copy *.* ..
del *.exe
del *.bin
cd ..
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO Downloading adb real quick, hang on ... thanks brett8883
echo.
ECHO -------------------------------------------------------------------------------------------
REM workaround for now, dl it from brett8883 repo thanks man
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/master/TOOLS/ProgramFiles/adb.exe adb.exe
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/master/TOOLS/ProgramFiles/AdbWinUsbApi.dll AdbWinUsbApi.dll
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/master/TOOLS/ProgramFiles/AdbWinApi.dll AdbWinApi.dll
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/master/TOOLS/ProgramFiles/libwinpthread-1.dll libwinpthread-1.dll
cd tools
copy adb.exe .. 
copy AdbWinApi.dll ..
copy AdbWinUsbApi.dll ..
copy libwinpthread-1.dll ..
del adb.exe 
del AdbWinApi.dll
del AdbWinUsbApi.dll
del libwinpthread-1.dll
cd ..
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
Echo Make sure DUMLdore says firmware %neededver% and that this is stock firmware
ECHO.
echo Then click "Enable ADB" in DUMLdore and wait for ADB to enable, then close DUMLdore 
ECHO.
Echo Continue once ADB has been enabled and DUMLdore is closed
ECHO.
ECHO ------------------------------------------------------------------------------------------- 
start DUMLdoreV3.exe
pause
GOTO ADBTREE
:ADBTREE
@echo off
REM DJI Spark    /sbin
REM DJI Mavic Pro    /sbin
REM DJI Phantom 4     /system/bin
REM DJI Phantom 4 Pro     /system/bin
REM DJI Phantom 4 advanced     /system/bin
REM DJI Inspire 2    
REM DJI Phantom 4 Pro V2     /system/bin
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO.
Echo ADB is trying to copy a file to the aircraft ...
ECHO.
ECHO ------------------------------------------------------------------------------------------- 
adb shell mount -o remount,rw /vendor
adb shell mkdir /vendor/bin
adb push dummy_verify.sh /vendor/bin/
if "%acname%"=="Mavic" GOTO ADBTREE1
IF "%acname%"=="p4s" GOTO ADBTREE2
IF "%acname%"=="p4a" goto ADBTREE2
IF "%acname%"=="p4p" goto ADBTREE2
IF "%acname%"=="p4pv2" goto ADBTREE2
IF "%acname%"=="i2" goto ADBTREE2
IF "%acname%"=="spark" goto ADBTREE1
:ADBTREE1
adb shell cd /vendor/bin/; chown root:root dummy_verify.sh; chmod 755 dummy_verify.sh; cp /sbin/dji_verify /vendor/bin/original_dji_verify_copy; sync; cd /
GOTO NEXTUP
:ADBTREE2
adb shell cd /vendor/bin/; chown root:root dummy_verify.sh; chmod 755 dummy_verify.sh; cp /system/bin/dji_verify /vendor/bin/original_dji_verify_copy; sync; cd /
GOTO NEXTUP
:NEXTUP
adb shell mount -o remount,ro /vendor
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
Echo. 
ECHO We copied the good stuff over, please restart your aircraft. Turn off then back on, keep 
ECHO it connected to the PC.  Once fully powered off and on, please continue
ECHO.
ECHO ------------------------------------------------------------------------------------------- 
pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
Echo.
echo Click "Enable ADB" in DUMLdore and then close DUMLdore before proceeding
start DUMLdoreV3.exe
ECHO.
ECHO ------------------------------------------------------------------------------------------- 
Pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
Echo.
echo Working on mounting the verify file ... please wait
Echo.
ECHO ------------------------------------------------------------------------------------------- 
if "%acname%"=="Mavic" GOTO ADBTREE3
IF "%acname%"=="p4s" GOTO ADBTREE4
IF "%acname%"=="p4a" goto ADBTREE4
IF "%acname%"=="p4p" goto ADBTREE4
IF "%acname%"=="p4pv2" goto ADBTREE4
IF "%acname%"=="i2" goto ADBTREE4
IF "%acname%"=="spark" goto ADBTREE3
:ADBTREE3
adb shell mount -o bind /vendor/bin/dummy_verify.sh /sbin/dji_verify
:ADBTREE4
adb shell mount -o bind /vendor/bin/dummy_verify.sh /system/bin/dji_verify
GOTO ADBNEXT
:ADBNEXT
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO.
echo Now, we willl flash the firmware file. DO NOT TURN OFF AIRCRAFT
echo.
echo Load the file %fwname% into DUMLdore, click "flash firmware" 
echo.
ECHO Please allow DUMLdore to do its thing and do not disconnect the %acname% until finished
echo.
echo When complete, turn the aircraft off and back on.  
echo.
ECHO ------------------------------------------------------------------------------------------- 
start DUMLdoreV3.exe
pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO.
echo Now, we are done. You will want to validate that the flight controller version has updated.
Echo.
Echo NoLimitDronez app can show version. You want %fcver% as the version. We will download it.
Echo.
ECHO From here, you can modify speed and battery settings in DJI assistant 1.1.2
echo.
ECHO ------------------------------------------------------------------------------------------- 
pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO Downloading NoLimitDronez to verify, we'll even open it too!
ECHO.
ECHO ------------------------------------------------------------------------------------------- 
java -jar download.jar https://nolimitdronez.com/downloads/nldapp.exe nldapp.exe
cd tools 
copy *.exe ..
del *.exe
cd ..
start nldapp.exe
GOTO DONE
:DONE
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 						Aircraft: %acname%
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO You are all done! 
echo.
echo Fly safe and responsibly. Now going to cleanup some things ...
echo.
ECHO ------------------------------------------------------------------------------------------- 
pause
@echo off
del dumldorev3.exe
del payload.bin
del new_payload.bin
del root.bin
del new_root.bin
del *.bin
taskkill /im adb.exe /f
del adb.exe 
del AdbWinApi.dll
del AdbWinUsbApi.dll
del libwinpthread-1.dll
cd tools
del adb.exe 
del AdbWinApi.dll
del AdbWinUsbApi.dll
del libwinpthread-1.dll
cd ..
rd tools
TIMEOUT 2 >nul
GOTO CREDITS
:CREDITS
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver% 
ECHO -------------------------------------------------------------------------------------------
Echo.
ECHO  Credits .. alot of smart folk put in alot of work. I want to give kudos to all the
ECHO  OG's, Matioupi, mefistotelis, fvantienen, brett883 and anyone else involved 
ECHO  with making the fc patcher toolset or associated tools. Here's to the community.
ECHO                             respect -- digdat0
ECHO.
ECHO -------------------------------------------------------------------------------------------
pause
GOTO EOF
:EOF
EXIT