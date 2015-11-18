set str=%1
set num=%2
gawk.exe -F"\t" "BEGIN{OFS="""\t"""}{print $1}" E:\Task\train\tested\%str%_file_00%num%.test > E:\Task\train\Label\%str%_file_00%num%.lbl