# fcchooser
enables easily using the custom firmware made from the fc-patcher tool

Credits to all the OG's, Matioupi, mefistotelis, fvantienen, jcase, jezzab, jan and anyone else involved with making the toolset or associated tools. Here's to the community

Flow:
- User selects aircraft type
- Tool downloads appropriate firmware
- Runs dumldore
- User Connect Aircrafts
- Files are copied and appropriate state set
- User Starts flash

This is a batch file which makes things easier to flash using the tail end of the fc patcher process, custom made firmware.

tldr: helps custom flashing of dji aircraft using fcpatcher made files

prereqs:
- java runtime environment or jdk installed
- dji aircraft
- knowing what you are doing, takes responsibility for safe flying

download the download.jar and the .bat file to a folder, then run the batch file. Choose your AC and follow the steps.

Note: To use this you MUST be on the latest version of AC.

Supported AC: 

   1) Mavic Pro 1 / Mavic Platinum / Mavic Artic White 1.04.0300
   2) Phantom 4 Standard 2.00.0700
   3) Phantom 4 Advanced 1.00.0128
   4) Phantom 4 Pro 1.05.0600
   5) Phantom 4 Pro v2 1.00.1500
   6) Inspire 2 1.02.0200
   7) Spark 1.00.0900
