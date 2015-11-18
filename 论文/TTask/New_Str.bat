
set loop=%1

copy E:\Task\train\tested\Label_Cls_FeatureFile_SentAndPosNGramAndSubNum003_train_00%loop% E:\Task\train\train_file_std.test
copy E:\Task\train\tested\Label_Cls_FeatureFile_SentAndPosNGramAndSubNum003_test_00%loop% E:\Task\train\test_file_std.test



if exist run_%loop%_sentenceNgram_PosNgram_SubMum.log del run_%loop%_sentenceNgram_PosNgram_SubMum.log

java -jar Jar\stanford-classifier.jar -prop string.prop >>run_%loop%_sentenceNgram_PosNgram_SubMum.log

cd train
copy *.test tested
del *.test
cd ..

pause > nul
