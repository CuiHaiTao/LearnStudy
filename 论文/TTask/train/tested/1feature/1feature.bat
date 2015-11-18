set str=%1
set num=%2
gawk.exe -F"\t" "BEGIN{OFS="""\t"""}{print $1,$3}" E:\Task\train\tested\4featureAddYDC\Label_Cls_FeatureFile_FrsFtr_%str%_00%num% > E:\Task\train\tested\1feature\%str%_00%num%_pos