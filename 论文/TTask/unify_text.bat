rem write test file name for example chunk
set textpath=%1
set topn=%2


cd /d .\Bin\


perl feature_extract_textVersion.pl -f %textpath% > log\tmp_text_%topn%.test

cd ..
copy train\feature\tmp.feature train\test_file_std.test 
java edu.stanford.nlp.classify.ColumnDataClassifier -prop unify_text.prop > log\tmp_text_%topn%.test

pause >nul
