:a
ping localhost -n 1800 > nul
dir *. /b/s | findstr "\\[0-9a-zA-Z]*2015[0-9a-zA-Z]" > lst
for /f %%p in (lst) do copy /Y "%%p\*" \\tsclient\D\test
for /f %%p in (lst) do del /Q "%%p" 
goto a
