use strict;
my $usage = "perl .pl LabelFile FeatureFile";
@ARGV || die "$usage\n";

my ($LabelFile,$FeatureFile) = @ARGV;

my $LabelFileHDL;
my $FeatureFileHDL;
open($LabelFileHDL,"< $LabelFile") or die "can not open $LabelFile!\n";
open($FeatureFileHDL,"< $FeatureFile") or die "can not open $FeatureFile!\n";
my @ARR_Label;
my @ARR_Feature;
my @ARR_Label_Feature;
while(<$LabelFileHDL>)
{
	chomp;
	push(@ARR_Label,$_);
}
close($LabelFileHDL);
while(<$FeatureFileHDL>)
{
	chomp;
	push(@ARR_Feature,$_);
}
close($FeatureFileHDL);
#my $out_file_sentence_hdl;
#open($out_file_sentence_hdl,"> ..\\train\\tested\\$NumTag") or die "can not append it!\n";
for(my $i = 0;$i<=$#ARR_Label;$i++){print "$ARR_Label[$i]"."	"."$ARR_Feature[$i]"."\n";}


