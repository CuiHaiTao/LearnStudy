set str=%1
set num=%2
gawk.exe -F"\t" "BEGIN{OFS="""\t"""}{print $1,$2,$3,$4,$5,$5}" Label_Cls_FeatureFile_SentAndPosNGramAndSubNum_XXC004_%str%_00%num% > E:\Task\train\tested\5feature\Label_Cls_FeatureFile_SentAndPosNGramAndSubNum_DoubleXXC004_%str%_00%num%