rem write test file name test%tag%feature
set tag=%1
rem text(article)filepath
rem set filepath=%1
rem cd /d E:\Task\Bin\
rem perl feature_extract_textVersion.pl %filepath% %tag%
copy E:\Task\train\tested\train_916_set3_Imving3.tag E:\Task\train\test_file_std.tag
if exist %tag%.test del %tag%.test
java edu.stanford.nlp.classify.ColumnDataClassifier -prop E:\Task\test_1d.prop > %tag%.test

cd /d E:\Task\train
copy *.tag tested
del *.tag
cd ..
pause >nul
