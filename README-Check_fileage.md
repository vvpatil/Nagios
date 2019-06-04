# Nagios
Plugins/scripts/documents for Nagios/Check_fileage.ps1

This plugin checks if any of the files from the specified directory has breached the aging threshold. it checks the individual file's created time against current system time.
If the maximum age of any file is exceeded, a critical message is returned.

It can check for a local as well as a shared path on your system.

Tested on Windows 2k8, 2k3 servers
1. Copy the plugin in scripts directory of your nsclient folder 
2. modify the Path & age in the plugin 
3. add the command alias under "/settings/external scripts/wrapped scripts"
