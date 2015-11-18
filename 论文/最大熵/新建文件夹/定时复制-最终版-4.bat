:a
ping localhost -n 1800 > nul
dir *. /b/s | findstr "\\[0-9a-zA-Z]*2015[0-9a-zA-Z]" > lst
:b
for /f %%p in (lst) do copy /Y "%%p\*" \\tsclient\D\test
if errorlevel 1 (for /l %%p in (1 1 3) do goto b) else (for /l %%p in (1 1 3) do del /Q "%%p" )
goto a
