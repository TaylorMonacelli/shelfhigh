# FROM mcr.microsoft.com/windows/nanoserver:1809
FROM cirrusci/windowsservercore:2019
RUN powershell -c 'New-Item -Type "directory" -Force -Path /Windows/Temp/sxs'
COPY ./script1.ps1 /Windows/Temp/script1.ps1
RUN powershell /Windows/Temp/script1.ps1
RUN dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All /Source:d:\sources\sxs /NoRestart /LimitAccess
COPY ./script.ps1 /Windows/Temp/script.ps1
RUN powershell /Windows/Temp/script.ps1
