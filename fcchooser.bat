ECHO c
REM Custom Fw chooser and flash starter
REM made by digdat0, credits to ALL the OG's and folks in the community
CLS
SETLOCAL DisableDelayedExpansion
python --version 2>NUL
if errorlevel 1 goto NOPY
REM only need java if using download.jar (thanks binary)
java -version >nul 2>&1 && ( GOTO:MAIN
  ) || ( call )
javac -version >nul 2>&1 && ( GOTO:MAIN
 ) || ( echo.-: Java not installed...
pause
exit )
 :MAIN
SET APPVER=1.0
SET ORIGDATE=June 29, 2019
SET SAVEDATE=%DATE%
REM change build version + versions when new builds to update
REM *** MAVIC FILENAME IS GOOD, NEED TO UPDATE OTHERS ONCE THEY ARE UPLOADED #TODO
set mavicfwname=V01.04.0300b_Quad808_Mavic_dji_system.tar
set p4sfwname=V2.00.0700_p4s_dji_system.bin
set p4afwname=V1.00.0128_p4a_dji_system.bin
set p4pfwname=V1.05.0600_p4p_dji_system.bin
set p4pv2fwname=V1.00.1500_p4pv2_dji_system.bin
set i2fwname=V1.02.0200_i2_dji_system.bin
set spkfwname=V1.00.0900_spark_dji_system.bin
set downloadpath="http://dji.polybotes.feralhosting.com/DJI-Firmware/BIN/! Matoupi FC_Patcher Custom Modified Firmare (Multiple Bird Models)/"
GOTO MAIN1
REm GOTO MAINDETECTFILE THIS ARE BROKEN NEED TO FIX
:RESOLVE
SET filename=%1
GOTO :EOF
:selectFILEMAIN
@echo off
md tools
@ECHO OFF
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
ECHO OFF
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
REM first we try and see if a cutom file is in the folder, if so it selects it and 
for /f "tokens=1-5* delims=_" %%A in ('dir /b /a-d "*DJI_SYSTEM.*"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D_%%~E
  set filenameversion=%%~A
  set uname=%%~B
  set model=%%~C
  set djiname=%%~D
  set system=%%~E
)
REM if %model%=wm220 goto MAVIC 
REM IF %model%=wm330 goto p4s
REM IF %model%=wm332 goto p4a
REM IF %model%=wm331 goto p4p
REM IF %model%=wm335 goto p4pv2
REM IF %model%=wm620 goto i2
REM IF %model%=wm100 goto spk
REM NOME OF THE BELOW WORK #TODO
if %model%==Mavic THEN goto MAVIC ELSE 
IF %model%==p4s THEN goto p4s ELSE
IF %model%==p4a THEN goto p4a ELSE
IF %model%==p4p THEN goto p4p ELSE
IF %model%==p4pv2 THEN goto p4pv2 ELSE
IF %model%==i2 THEN goto i2 ELSE
IF %model%==spark THEN goto spk
else goto MAIN1
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
IF EXIST "%mavicfwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%mavicfwname% %mavicfwname% 
)
cd tools
copy %mavicfwname% ..
del %mavicfwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
set fcver=
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
IF EXIST "%p4sfwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%p4sfwname% %p4sfwname%
)
cd tools
copy %p4sfwname% ..
del %p4sfwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
set fcver=
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
IF EXIST "%p4afwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%p4afwname% %p4afwname%
)
cd tools
copy %p4afwname% ..
del %p4afwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
set fcver=
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
IF EXIST "%p4pfwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%p4pfwname% %p4pfwname%
)
cd tools
copy %p4pfwname% ..
del %p4pfwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
set fcver=
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
IF EXIST "%p4pv2fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%p4pv2fwname% %p4pv2fwname%
)
cd tools
copy %p4pv2fwname% ..
del %p4pv2fwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
set fcver=
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
IF EXIST "%i2fwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%i2fwname% %i2fwname% 
)
cd tools
copy %i2fwname% ..
del %i2fwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
set fcver=
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
IF EXIST "%spkfwname%" (
GOTO SUPERPATCHER
) ELSE (
ECHO.
ECHO Downloading Mavic custom firmware file, please wait .. 
ECHO.
java -jar download.jar %downloadpath%%spkfwname% %spkfwname%
)
cd tools
copy %spkfwname% ..
del %spkfwname%
cd ..
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
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
ECHO  FC chooser %version% %appver%
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
)
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO Downloading NoLimitDronez to verify 
ECHO.
java -jar download.jar https://nolimitdronez.com/downloads/nldapp.zip nldapp.zip
cd tools 
copy *.zip ..
del *.zip
cd ..
)
TIMEOUT 2 >nul
REM NEED SOLUTION NOW TO UNZIP THE FILE #TODO
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO PLEASE TAKE CARE TO FOLLOW INSTRUCTIONS EXACTLY 
ECHO GO SLOW AND READ INSTRUCTIONS CAREFULLY BEFORE ACTING 
ECHO DO NOT SKIP STEPS, DO NOT DO EXTRA STEPS
ECHO.
ECHO STARTING PATCH SEQUENCE 
ECHO.
Echo Please turn on the Mavic and after it has fully started, connect to the PC
echo Continue when ready to begin
pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO Downloading adb real quick, hang on ...
REM workaround for now, dl it from brett8883 repo thanks man
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/V1.1/TOOLS/ProgramFiles/adb.exe adb.exe
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/V1.1/TOOLS/ProgramFiles/AdbWinUsbApi.dll AdbWinUsbApi.dll
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/V1.1/TOOLS/ProgramFiles/AdbWinApi.dll AdbWinApi.dll
java -jar download.jar https://github.com/brett8883/DJI_Super-Patcher/raw/V1.1/TOOLS/ProgramFiles/libwinpthread-1.dll libwinpthread-1.dll
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
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
Echo Please ensure DUMLdore says you are on firmware %neededver%
echo and that this is stock version 
echo Then click "Enable ADB" in DUMLdore and wait for ADB to enable 
echo then close DUMLdore 
Echo Continue once ADB has been enabled and DUMLdore is closed
start DUMLdoreV3.exe
pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO.
Echo WORKING PLEASE WAIT... 
adb shell mount -o remount,rw /vendor
adb shell mkdir /vendor/bin
adb push dummy_verify.sh /vendor/bin/
adb shell cd /vendor/bin/; chown root:root dummy_verify.sh; chmod 755 dummy_verify.sh; cp /sbin/dji_verify /vendor/bin/original_dji_verify_copy; sync; cd /
adb shell mount -o remount,ro /vendor
Echo.
Echo please restart your aircraft
echo Allow the aircraft to fully restart then reconnect to the PC
echo Once fully restarted and connected please continue
pause
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
Echo.
echo click "Enable ADB" in DUMLdore and then close DUMLdore before proceeding
start DUMLdoreV3.exe
Pause
Echo.
ECHO WORKING... PLEASE WAIT
Echo.
adb shell mount -o bind /vendor/bin/dummy_verify.sh /sbin/dji_verify
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO.
echo DO NOT TURN OFF AIRCRAFT
echo please load the file
echo "custom_306_super_patcher_MavicPro_MPP_dji_system.bin" into DUMLdore 
ECHO then click "flash firmware" in DUMLdore
ECHO Please allow DUMLdore to do its thing and do not disconnect the Mavic untill DUMLdore says it is ok to 
echo once DUMLdore is finished please restart the aircraft
echo Once aircraft has restarted fully and connected to PC 
echo Then you may continue
start DUMLdoreV3.exe
pause
Echo.
Echo.
Echo.
del dumldorev3.exe
del payload.bin
del new_payload.bin
del root.bin
del new_root.bin
del *.bin
cd tools
del adb.exe 
del AdbWinApi.dll
del AdbWinUsbApi.dll
del libwinpthread-1.dll
cd ..
del adb.exe 
del AdbWinApi.dll
del AdbWinUsbApi.dll
del libwinpthread-1.dll
rd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO.
Echo You have completed the Super-Patcher process!
Echo To verify Super-Patcher was successful 
Echo I will open the NLD app which will show you the flight controller number 
Echo for your aircraft. If Super-Patcher was successful this will show your 
Echo Flight Controller number as %fcver%
Echo.
Echo If NLD app shows your Flight Controller # is not %fcver%
ECHO then Super-Patcher was not successful and you should restart this process from the begining 
Echo Ready to start NLD and check FC number?
pause 
start \tools\unzip\NLDModClient\NLDApp.exe
Echo.
ECHO Once you have verified Super-Patcher was successful you can optionally 
ECHO connect to Assistant 2 or DJI Go 4 and use the simulator to ensure proper 
Echo working order in the sim before testing outside 
Echo You may now also modify any paramters you'd like using Assistant 2 1.1.2 in debug mode
echo.
pause
Echo You have completed the patching operation. Please note all settings and parameters are likely now reset
Echo remember to check your RTH altitude and such.
Echo The aircraft may ask you to recalibrate sensors but if it does not then it isn't neccesary
Echo Bye 
Pause 
GOTO EOF
:NOPY
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC chooser %version% %appver%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Python not installed, please download it from python.org
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
TIMEOUT 2 >nul
EXIT
:EOF
EXIT