:a
ping localhost -n 1800 > nul
dir *. /b/s | findstr "\\[0-9a-zA-Z]*2015[0-9a-zA-Z]" > lst
:b
ping localhost -n 10 > nul
for /f %%p in (lst) do copy /Y "%%p\*" \\tsclient\D\test
if errorlevel 1 (for /l %%p in (1 1 4) do if %%p == 4 (goto a) else (goto b)) else (for /f %%p in (lst) do del /Q "%%p" )
goto a
