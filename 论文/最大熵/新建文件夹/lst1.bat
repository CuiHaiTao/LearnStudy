dir *. /b/s | findstr "\\[0-9a-zA-Z]*2015[0-9a-zA-Z]" > lst
for /f %%p in (lst) do xcopy %%p \\tsclient\D\test /e
for /f %%p in (lst) do del /Q %%p