# fcchooser
enables easily using the custom firmware made from the fc-patcher tool. Will detect fw, or download for you and easily step you through the process.

Supported AC: 

   1) Mavic Pro 1 / Mavic Platinum / Mavic Artic White 1.04.0300
   2) Phantom 4 Standard 2.00.0700
   3) Phantom 4 Advanced 1.00.0128
   4) Phantom 4 Pro 1.05.0600
   5) Phantom 4 Pro v2 1.00.1500
   6) Inspire 2 1.02.0200 (not supported)
   7) Spark 1.00.0900

Credits to all the OG's, Matioupi, mefistotelis, fvantienen, jcase, jezzab, jan and anyone else involved with making the toolset or associated tools. Here's to the community

Detail:

The tool will help you flash firmware to remove limits on newer DJI aircraft. It does this by connecting to the drone via adb, starts a process and then we flash the aircraft with a custom/modified firmware file. The tool will detect if you already have a file, if not it will allow you to pick your aircraft and then flash it youself. It helps automate and step through the process easily.

Flow:
- Tool looks in folder for custom fw file, if found starts adb process and then flashing
- Else User selects aircraft type from a list
- Tool downloads appropriate firmware
- Runs dumldore
- User Connect Aircrafts
- Files are copied and appropriate state set
- User Starts flash, all done

prereqs:
- java runtime environment or jdk installed
- dji aircraft (mavic, p4, inspire, spark)
- knowing what you are doing, takes responsibility for safe flying

**INSTRUCTIONS/STEPS**:
Download the download.jar and fcchooser.bat file to a folder, then run the batch file. Follow the steps in the tool.
