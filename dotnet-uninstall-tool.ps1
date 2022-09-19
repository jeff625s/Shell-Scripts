#This script will intall the dotnet-uninstall-tool remotely on the user's computer based on their network IP address, uninstall all runtimes and SDK'S, and give the option to reinstall the updated SDK.
Param(
  [Parameter(Mandatory=$true)]
  [string]$ip
)

#The dotnet-uninstall-tool will need to be installed on your computer in the default location Program Files x86.
robocopy "C:\Temp\PSTools\PSExec.exe \\$ip\c$\Program Files (x86)\dotnet-core-uinstall " /E

#This line will list the installed .NET versions on the target computer.
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command dotnet-core-uninstall list

#The following two lines will remove all .NET SDK's and Runtimes.
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command dotnet-core-uninstall remove --all --force --runtime --yes 
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command dotnet-core-uninstall remove --all --sdk --runtime --yes 
echo "All SDKs and runtimes removed."

#The updated SDK's for each version will need to be downloaded to your computer's C:\Temp folder.
$option = read-host -prompt "Update version 3.1? 1 for y, 2 for n."
if($option -eq 1)
{
cp C:\Temp\PSTools\dotnet-sdk-3.*-win.exe \\$ip\c$\temp 
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command "start-process -filepath C:\Temp\dotnet-sdk-3.*-win-x64.exe -Argument '/quiet' -PassThru"
}
elseif($option -eq 2)
{echo "Skipped."
}
$option = read-host -prompt "Update version 6.0? 1 for y, 2 for n."
if($option -eq 1)
{
cp C:\Temp\PSTools\dotnet-sdk-6.*-win.exe \\$ip\c$\temp  
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command "start-process -filepath C:\Temp\dotnet-sdk-6.*-win-x64.exe -Argument '/quiet' -PassThru"
}
elseif($option -eq 2)
{echo "Skipped."
}
$option = read-host -prompt "Update version 7.0? 1 for y, 2 for n."
if($option -eq 1)
{
cp C:\Temp\PSTools\dotnet-sdk-7.*-win.exe \\$ip\c$\temp  
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command "start-process -filepath C:\Temp\dotnet-sdk-7.*-win-x64.exe -Argument '/quiet' -PassThru"
}
elseif($option -eq 2)
{echo "Skipped."
}

#This line will list the installed .NET versions on the target computer.
C:\Temp\PSTools\PSExec.exe \\$ip C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command dotnet-core-uninstall list
