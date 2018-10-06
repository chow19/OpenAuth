%SystemRoot%\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe JobSchedule.Service.exe
Net Start \JobSchedule.Service
sc config \JobSchedule.Service start=auto
pause