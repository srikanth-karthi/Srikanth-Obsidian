T-minus

| 22                                                                                                                                                                                                                                                                            |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Write down IP address and Entity Code for RMS _  <br>Open command Propmt - type in ipconfig (note the IP address)Create /etc host file with new IP/Host name of the target server and put it on D:\Migration                                                                  |
| 25                                                                                                                                                                                                                                                                            |
| Check Windows Task Scheduler for AEV events as well as any scheduled tasks for Intergy, PA, ISS. If present, export to a migration folder created above. export to a migration folder. (e.g., D:\Migration)  <br>Export the following events:  <br>AEV Sent  <br>AEV received |

| 26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Login to Intergy>System Administration (Usually a folder on desktop called “Greenway Intergy”)  <br>Check serialization for:  <br>Card Scanning (usually on E: Drive that need to be migrated)  <br>Document Image System  <br>TMS - Interop  <br>HL7 backbone - Interop  <br>Drs LIS note directory : (usually C:\LIS). Copy C:\LIS directory or similar name to migration folder.  <br>Prescriptions DUR & Prescriptions EDI will need to be tested on backside of migration  <br>EHRPrint the serialization and attach it to the case. Also Go through the checklist for Interop to gather Information for Clinician, HL7, TMSAutoImport. See guide named Interop Migration checklist. |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| 43                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Copy confirguration files of CLC and TMS to D:\Migration                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |


T-0


| 27                                                                                             |
| ---------------------------------------------------------------------------------------------- |
| Incremental Backup of AuditDB and IntergyDB to D:\Migration                                    |
| 28                                                                                             |
| IPA SQL XPRESS Admin Data Base Steps for QME and FUll:  <br>Full backup of SQL Xpress Admin DB |


other points:
i have a cmd for online incremental backups and offline backups not for online full backups
when did i do incremental backups and full backups 
Ensure the incremental  backup cmd  for medman 





