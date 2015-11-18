use strict;
use Lingua::EN::Sentence qw( get_sentences );

my $usage="perl TextToSentence.pl File\n";
@ARGV ==1 || die "$usage\n";
my ($file) = @ARGV;
my $FlHdl;
my @ttl;
open($FlHdl,"< $file") || die "can not open it\n";
while(<$FlHdl>)
{
	chomp;
	#s/\s+//g;
	s/\x{C2}(.)//eg;
	next if /^\s*$/;
	my ($sentences)=get_sentences($_);
	 #;
	push(@ttl,@$sentences);
}
close($FlHdl);
#my $FlHdl1;
open($FlHdl,"> $file") || die "can not open $file\n";
foreach(@ttl){print $FlHdl "$_\n";}

# my $sentences=get_sentences($text);     ## Get the sentences.
# foreach my $sentence (@$sentences) {
        # ## do something with $sentence
# }
