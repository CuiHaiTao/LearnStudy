
set loop=%1

copy E:\Task\train\Test_Set\test_file_916_set1.test E:\Task\train\test_file_std.test
copy E:\Task\train\Train_Set\train_file_916_set1.train E:\Task\train\train_file_std.test

if exist run_%loop%_letter.log del run_%loop%_letter.log

java -jar Jar\stanford-classifier.jar -prop 1feature.prop >>run_%loop%_letter.log

cd train
copy *.test tested
del *.test
cd ..

pause > nul
