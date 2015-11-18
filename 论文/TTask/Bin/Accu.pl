use strict;
my $usage = "perl Accu.pl TextFile";
@ARGV || die "$usage\n";
my ($TextFile) = @ARGV;
my $TextFileHDL;
open($TextFileHDL,"< $TextFile") or die "can not open $TextFileHDL!\n";
my $Totl=0;
my $MthCount=0;
my $Accu;
while(<$TextFileHDL>)
{
	chomp;
	if($_ =~ /^[0-9] best\s+[A-Za-z]+/)
	{
		s/.*?\://;
		s/^\s+//g;
		my @tmp = split("	",$_);
		for(my $tmpi=1;$tmpi<$#tmp;$tmpi++)
		{
			if((($tmpi%2)==0) and ($tmp[0] eq $tmp[$tmpi]))
			{
				$MthCount++;
			}
		}
		$Totl++;
	}
	
}
close($TextFileHDL);
$Accu = ($MthCount)/($Totl);


print "Accuracy:$Accu\n";




