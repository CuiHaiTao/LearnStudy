rem write test file name for example chunk
set textpath=%1
set topn=%2


cd /d .\Bin\


perl feature_extract_textVersion.pl -f %textpath%
perl merge_Two_FileUseTab.pl ..\train\Label\tmp.lbl ..\train\feature\tmp.feature > ..\train\tested\tested.tmp
cd ..
copy train\tested\tested.tmp train\test_file_std.tag 
if exist tmp.test del tmp.test
java edu.stanford.nlp.classify.ColumnDataClassifier -prop unify_tag.prop > log\tmp_tag_%topn%.test
cd Bin
perl Accu.pl ..\log\tmp_tag_%topn%.test 
cd /d ..\train
copy *.tag tested
del *.tag
cd ..
pause >nul
