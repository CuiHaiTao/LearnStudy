set dire=%1
C:
cd %dire%
dir *. /b/s | findstr "\\[0-9]2015[0-9]" > lst
for /f %p in (lst) do xcopy %p \\tsclient\D\test /e
for /f %p in (lst) do del del /Q %p
pause > nul
