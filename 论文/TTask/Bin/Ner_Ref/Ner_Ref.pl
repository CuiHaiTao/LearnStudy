use strict;
use File::Find;
use Cwd;
my $usage = "perl *.pl Text\n";
@ARGV == 1 || die $usage;
my ($text) = @ARGV;




my $datapath;
my $jarpath;
my $modelpath;
#my @NerArr;
sub wanted 
{
		if ($_ =~ /^data$/i and -d $_)
		{
			$datapath = $File::Find::name;
			#print $datapath."DDDD\n\n";
		}
		if ($_ =~ /^jar$/i and -d $_)
		{
			$jarpath = $File::Find::name;
		}
		if ($_ =~ /^model/i and -d $_)
		{
			$modelpath = $File::Find::name;
		}
}


my $dirpath = getcwd();
	#my $count_sprit;

	my ($dirname, $outName) = $dirpath =~ /(.*)\/(.*)/;
	my @count = $dirpath =~ /\//g;
	if(scalar(@count) <= 1.1)
	{
		finddepth(\&wanted,"$dirpath");
	}
	else
	{
		finddepth(\&wanted,"$dirname");
	}




my @Ref_answer;
my @Ref_Sentence;
my @Ner_Sentence;
my $ref_handle;
open($ref_handle,"< $text") || die "can not open it\n";
while(<$ref_handle>)
{
	chomp;
	s/\(.*?\)//g;
	my $string = $_;
	$string =~ s/.*?AAAA//;
	$string =~ s/^\s+|\s+$//;
	push(@Ref_Sentence,$string);
	s/AAAA.*//;
	s/^\s+|\s+$//;
	push(@Ref_answer,$_);
}
close($ref_handle);
open($ref_handle,"> $text") || die "can not open it\n";
foreach(@Ref_Sentence)
{
	print $ref_handle "$_\n";
}
close($ref_handle);
#open($ref_handle,"< $datapath/Ref_Test") || die "can not open it\n";
my $tmpm_handle;
open($tmpm_handle,"> $datapath/Fnl_Ref") || die "can not $datapath/Fnl_Ref \n";
print $tmpm_handle `java -cp $jarpath/stanford-ner-3.5.2.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier $modelpath/english.muc.7class.distsim.crf.ser.gz -textFile $text -outputFormat inlineXML`;
close($tmpm_handle);
open($tmpm_handle,"< $datapath/Fnl_Ref") || die "can not $datapath/Fnl_Ref \n";
while(<$tmpm_handle>)
{
	chomp;
	s/\<DATE\>.*?\>/TIME/g;
	s/\<LOCATION\>.*?\>/PLACE/g;
	s/\<[A-Z]+\>//g;
	s/\<\/[A-Z]+\>//g;
	push(@Ner_Sentence,$_);
}
close($tmpm_handle);
open($tmpm_handle,"> $datapath/Fnl_Ref") || die "can not $datapath/Fnl_Ref \n";
if(scalar(@Ref_answer) == scalar(@Ner_Sentence))
{
	for(my $i = 0;$i<=$#Ner_Sentence;$i++)
	{
		$Ref_answer[$i] .= "AAAA"."$Ner_Sentence[$i]"; 
		print $tmpm_handle "$Ref_answer[$i]\n";
	}
}