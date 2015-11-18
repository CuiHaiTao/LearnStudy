
use strict;
my $usage = "perl pl Text";
@ARGV ==1 || die "\n";
my ($ARGText) = @ARGV;
my $handle;



open($handle,"< $ARGText") || die "can not open $ARGText\n";
my @store = ();
#open($handle1,"+> $ARGText") || die " can not write $ARGText\n";

while(<$handle>)
{
	chomp;
	my $string;
	s/^\s+//g;
	#s/([\.|\!|\?])(.*)/$1/;
	#s/\x{C2}(.)//eg;
	next if /^s*$/;
	s/\x{A3}(.)/chr(ord($1)-128)/eg;
	s/\x{A4}(.)//eg;
	s/(\xA3(.))/chr(ord($2)-128)/eg;
	s/\s+$//g;
	#if($_ !~ /\.$/ and $_ !~ /(\!|\?)$/){s/(.*)/$1\./;}
	if($_ =~ /(\xA1(.))/g)
	{
		if(ord($2) == 175 or ord($2) == 174)
		{
			s/(\xA1(.))/chr(39)/eg;
		}
		if(ord($2) == 165 or ord($2) == 176)
		{
			s/(\xA1(.))/chr(34)/eg;
		}
		if(ord($2) == 170)
		{
			s/(\xA1(.))/chr(45)/eg;
		}
		if(ord($2) == 177)
		{
			s/(\xA1(.))/chr(63)/eg;
		}
		if(ord($2) == 234)
		{
			s/(\xA1(.))/chr(116)/eg;
		}
		if(ord($2) == 246)
		{
			s/(\xA1(.))/chr(32)/eg;
		}
		if(ord($2) == 277)
		{
			s/(\xA1(.))/chr(46)/eg;
		}
		
		#print ord($2);
		#print "HH $2 HH      DDDD\n";
	}
   # if($_ !~ /^([\x8\x9\xa\xd\x20-\x80])*$/)
   # {
	# s/$1//;
	 # print "$1 Gemini character\n";
	 # print "$_\n";
   # }

	push(@store,$_);
}
close($handle);
open($handle,"> $ARGText") || die "can not open $ARGText\n";
foreach(@store)
{
	print $handle "$_\n";
}