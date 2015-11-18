rem write test file name for example chunk
set tag=%1
set stc=%2


cd /d .\Bin\


perl feature_extract_textVersion.pl ..\train\origin_data\sentence\train_file_916_set%stc%.stc
perl merge_Two_FileUseTab.pl ..\train\Label\train_916_set%stc%.lbl ..\train\feature\tmp.feature > ..\train\tested\%tag%
cd ..
copy train\tested\%tag% train\train_file_std.tag 
if exist tmp.test del tmp.test
java edu.stanford.nlp.classify.ColumnDataClassifier -prop train_model.prop 
rem cd Bin
pause > nul