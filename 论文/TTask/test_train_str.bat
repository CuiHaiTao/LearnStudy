
set loop=%1

copy E:\Task\train\tested\4featureAddYDC\Label_Cls_FeatureFile_MainFtr_test_006 E:\Task\train\test_file_std.test
copy E:\Task\train\tested\4featureAddYDC\Label_Cls_FeatureFile_MainFtr_train_006 E:\Task\train\train_file_std.test

if exist run_%loop%_Label_lngram.log del run_%loop%_Label_lngram.log

java -jar Jar\stanford-classifier.jar -prop 1feature.prop >>run_%loop%_Label_lngram.log

cd train
copy *.test tested
del *.test
cd ..

pause > nul
