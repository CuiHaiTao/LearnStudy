net use n: \\tsclient\D\test
cd /d N:
dir *.txt /b >> netlst.tmp
copy netlst.tmp C:\test
del netlst.tmp
net use n: /del
cd /d C:\test
dir *. /b/s | findstr "\\[0-9a-zA-Z]*2015[0-9a-zA-Z]" > lst.tmp
for /f %%p in (lst.tmp) do (
		cd /d %%p
		dir /b > tmplst.tmp
		copy C:\test\netlst.tmp %%p
		for /f %%a in (netlst.tmp) do (for /f %%b in (tmplst.tmp) do if "%%a"=="%%b" type %%p\%%a >> \\tsclient\D\test\%%a | del %%p\%%a)
		del %%p\tmplst.tmp
		del %%p\netlst.tmp
)
cd /d C:\test
for /f %%k in (lst.tmp) do copy /Y "%%k\*" \\tsclient\D\test
for /f %%p in (lst.tmp) do del /Q "%%p"
pause > nul