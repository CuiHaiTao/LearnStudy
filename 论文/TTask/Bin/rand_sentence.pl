use strict;



#
my $indexRsladvcBg;
my $indexRsladvcEd;
my $indexRadvcBg;
my $indexRadvcEd;
my $indexPadvcBg;
my $indexPadvcEd;
my $indexCmasBg;
my $indexCmasEd;
  
#读取文件
my $usage = "perl rand_sentence file";
@ARGV == 2 || die "$usage\n";
my ($file,$out_flag) = @ARGV;
my $fl_handle;
#my $stc_counter=0;
open($fl_handle,"< $file") or die "can not open the file\n";
my @sentence_arr;
while(<$fl_handle>)
{
	chomp;
	#$stc_counter ++;
	if($_ =~ /^RSLADVC/){}
	push(@sentence_arr,"$_");
}
close($fl_handle);
#存取文件
for(my $i = 0;$i<=$#sentence_arr;$i++)
{
	if($sentence_arr[$i] !~ /^RSLADVC/ and $sentence_arr[$i+1] =~ /^RSLADVC/){$indexRsladvcBg=$i+1;}
	if($sentence_arr[$i] =~ /^RSLADVC/ and $sentence_arr[$i+1] !~ /^RSLADVC/){$indexRsladvcEd=$i;}
	if($sentence_arr[$i] !~ /^RADVC/ and $sentence_arr[$i+1] =~ /^RADVC/){$indexRadvcBg=$i+1;}
	if($sentence_arr[$i] =~ /^RADVC/ and $sentence_arr[$i+1] !~ /^RADVC/){$indexRadvcEd=$i;}
	if($sentence_arr[$i] !~ /^PADVC/ and $sentence_arr[$i+1] =~ /^PADVC/){$indexPadvcBg=$i+1;}
	if($sentence_arr[$i] =~ /^PADVC/ and $sentence_arr[$i+1] !~ /^PADVC/){$indexPadvcEd=$i;}
	if($sentence_arr[$i] !~ /^CMAS/ and $sentence_arr[$i+1] =~ /^CMAS/){$indexCmasBg=$i+1;}
	if($sentence_arr[$i] =~ /^CMAS/ and $sentence_arr[$i+1] !~ /^CMAS/){$indexCmasEd=$i;}
}
#
#产生不重复的随机数
my %sns = ();
my $no;
my $sns;
my @arr =();
for(my $i = 0;$i < 5; $i ++) {
   my $range = $indexRsladvcEd;
   do{
    $no = rand($range);
   $no = int($no);
  # $no = $no * 3 + 1;
   
   }while($sns{"$no"} == 1 or $no < $indexRsladvcBg);
   $sns{"$no"} = 1;
   push(@arr,$no);
   #print "$no\n";

}
for(my $i = 0;$i < 5; $i ++) {
   my $range = $indexRadvcEd;
   do{
    $no = rand($range);
   $no = int($no);
  # $no = $no * 3 + 1;
   
   }while($sns{"$no"} == 1 or $no < $indexRadvcBg);
   $sns{"$no"} = 1;
   push(@arr,$no);
   #print "$no\n";

}
for(my $i = 0;$i < 5; $i ++) {
   my $range = $indexPadvcEd;
   do{
    $no = rand($range);
   $no = int($no);
  # $no = $no * 3 + 1;
   
   }while($sns{"$no"} == 1 or $no < $indexPadvcBg);
   $sns{"$no"} = 1;
   push(@arr,$no);
   #print "$no\n";

}
for(my $i = 0;$i < 5; $i ++) {
   my $range = $indexCmasEd;
   do{
    $no = rand($range);
   $no = int($no);
  # $no = $no * 3 + 1;
   
   }while($sns{"$no"} == 1 or $no < $indexCmasBg);
   $sns{"$no"} = 1;
   push(@arr,$no);
   #print "$no\n";

}
for(my $i = 0;$i < 180; $i ++) {
   my $range = 916;
   do{
    $no = rand($range);
   $no = int($no);
  # $no = $no * 3 + 1;
   
   }while($sns{"$no"} == 1 or ($no > $indexCmasBg and $no < $indexCmasEd) or ($no >= $indexRsladvcBg and $no < $indexRsladvcEd) or ($no > $indexRadvcBg and $no < $indexRadvcEd) or ($no > $indexPadvcBg and $no < $indexPadvcEd));
   $sns{"$no"} = 1;
   push(@arr,$no);
   #print "$no\n";

}
my $hdl;
open($hdl,"> ..\\train\\Test_Set\\test_file_$out_flag.test");
foreach(@arr){print $hdl "$sentence_arr[$_]\n";}
close($hdl);

#training file
my $hd2;
open($hd2,"> ..\\train\\Train_Set\\train_file_$out_flag.train");
#my @arr_train_index;
for(my $i = 0;$i<=$#sentence_arr;$i++)
{
	for(my $j=0;$j<=$#arr;$j++)
	{
		if($i == $arr[$j]){$sentence_arr[$i] = "AAAA";}
	}
}
foreach(@sentence_arr){if($_ !~ /AAAA/){print $hd2 "$_\n";}}
