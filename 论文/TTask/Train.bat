set loop=%1
call train_1d.bat %loop% set%loop%
set loop=%1
call test_1d.bat %loop% set%loop%
pause > nul