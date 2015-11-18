use strict;
use FindBin qw($Bin); 
use lib "$Bin/../lib";
use WPosParse_TypeDependent qw(WordsAndPos_Penn_TypedDependt TextPath Pos Word Penn TypeDpdt Verb SentenceKinds Predivate_Verb_and_Location Sentence_Sub_Locate);
use File::Find;
use Cwd;
my ($usage) = "perl .pl fullpathtext";
@ARGV || die $usage;
my ($tfff) = @ARGV;

TextPath("$tfff");


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



my @word = Word();
my @pos = Pos();
my @typedpdt = TypeDpdt();
my @sentencekind = SentenceKinds();
my $Qwd = qr/^(what|who|Which|whose|whom|when|where|why|how)$/i;
my $be = qr/^(are|were|is|was|am)$/i;
#my $have = qr/^(has|have|had)$/i;
my $Qauxverb = qr/^(do|does|did|has|have|had)$/i;
my $MD = qr/\b(can|could|may|might|need|shall|should|will|would|dare)\b/i;
my @Fnl_St = ();
for(my $i = 0;$i <=$#sentencekind; $i++)
{
	if($sentencekind[$i] == 1)
	{
		my @Qword = @{$word[$i]};
		my @Qpos = @{$pos[$i]};
		my @Qtypedpdt = @{$typedpdt[$i]};
		if($Qpos[scalar(@Qword)-2] =~ /\bPRP\b/ and $Qpos[scalar(@Qword)-3] =~ /\bMD\b/ and $Qword[scalar(@Qword)-4] =~ /,/)
		{
			splice(@Qword,scalar(@Qword)-3,3);
			pop(@Qword);
			push(@Qword,".");
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}print"\n";
			next;
		}
		if($Qpos[scalar(@Qword)-3] =~ /\bRB\b/ and $Qpos[scalar(@Qword)-4] =~ /\bMD\b/ and $Qpos[scalar(@Qword)-5] =~ /,/)
		{
			splice(@Qword,scalar(@Qword)-4,4);
			pop(@Qword);
			push(@Qword,".");
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}print"\n";
			next;
		}
		if($Qpos[scalar(@Qword)-2] =~ /\bPRP\b/ and $Qword[scalar(@Qword)-3] =~ /\b($be|$Qauxverb)\b/ and $Qword[scalar(@Qword)-4] =~ /,/)
		{
			splice(@Qword,scalar(@Qword)-3,3);
			pop(@Qword);
			push(@Qword,".");
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}print"\n";
			next;
		}
		if($Qpos[scalar(@Qword)-3] =~ /\bRB\b/ and $Qword[scalar(@Qword)-4] =~ /\b($be|$Qauxverb)\b/ and $Qpos[scalar(@Qword)-5] =~ /,/)
		{
			splice(@Qword,scalar(@Qword)-4,4);
			pop(@Qword);
			push(@Qword,".");
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}print"\n";
			next;
		}
		if($Qword[0] =~ /$Qauxverb/)
		{
			my @out = commom_QS(\@Qword);
			push(@Fnl_St,\@out);
		}
		for(my $ti = 0;$ti <=$#Qword; $ti++)
		{
			if($Qword[$ti] =~ /,/ and $Qword[$ti+1] =~ /$Qauxverb/)
			{
				my @split_part = @Qword[0..$ti];
				splice(@Qword,0,$ti+1);
				my @out = commom_QS(\@Qword,\@split_part);
				push(@Fnl_St,\@out);
				@Qword = ();
				last;
			}
			if($Qword[$ti] =~ /,/ and $Qword[$ti+1] =~ /$MD/ and $Qpos[scalar(@Qword)-3] !~ /\bMD\b/)
			{
				my @split_part = @Qword[0..$ti];
				splice(@Qword,0,$ti+1);
				my @out = commom_QS(\@Qword,\@split_part);
				push(@Fnl_St,\@out);
				@Qword = ();
				last;
			}
			if($Qword[$ti] =~ /,/ and $Qword[$ti+1] =~ /$Qwd/ and $Qword[$ti+2] =~ /$Qauxverb/)
			{
				my @split_part = @Qword[0..$ti];
				splice(@Qword,0,$ti+1);
				my @out = special_QS(\@Qword,\@split_part);
				push(@Fnl_St,\@out);
				@Qword = ();
				last;
			}
		}

		if($Qword[0] =~ /$MD/)
		{
			my $sftmd = shift(@Qword);
			pop(@Qword);
			push(@Qword,".");
			my $fstnsubjloc = nsubj(\@Qtypedpdt);
			splice(@Qword,$fstnsubjloc-1,0,lc$sftmd);
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}
			print"\n";
		}
		if($Qword[0] =~ /$Qwd/ and $Qword[1] =~ /$Qauxverb/)
		{
			splice(@Qword,0,2);
			pop(@Qword);
			push(@Qword,".");
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}
			print"\n";
		}
		
	}
	elsif($sentencekind[$i] == 3)
	{
		my @Qword = @{$word[$i]};
		my @Qpos = @{$pos[$i]};
		if($Qword[0] =~ /\bPlease\b/i)
		{
			shift(@Qword);
			unshift(@Qword,"You");
			pop(@Qword);
			push(@Qword,".");
			push(@Fnl_St,\@Qword);
			foreach(@Qword){print"$_ ";}
			print"\n";
			next;
		}
		if($Qword[0] !~ /\bPlease\b/i)
		{
			unshift(@Qword,'You');foreach(@Qword){print"$_ ";}print"\n";
			push(@Fnl_St,\@Qword);
		}
	}
	else
	{
		my @Qword = @{$word[$i]};
		push(@Fnl_St,\@Qword);
	}
}

sub nsubj
{
	my $reftypedpdt = shift;
	my @tmptypedpdt = @$reftypedpdt;
	#foreach(@tmptypedpdt){print"$_ VVV\n";}
	my (@stgnsubjall) = "@tmptypedpdt" =~ /nsubj.*?\)/g;
	my $stgnsubj = $stgnsubjall[0];
	$stgnsubj =~ s/.*\-|\)//g;
	return $stgnsubj;
}
sub commom_QS
{
	my ($refarr,$splt_arr) = @_;
	my @qword = @$refarr;
	my @split_arr = ();
	if(defined($splt_arr)){@split_arr=@$splt_arr;}
	shift(@qword);
	pop(@qword);
	push(@qword,".");
	splice(@qword,0,0,@split_arr);
	foreach(@qword){print"$_ ";}
	print"\n";
	return @qword;
}
sub special_QS
{
	my ($refarr,$splt_arr) = @_;
	my @qword = @$refarr;
	my @split_arr = ();
	if(defined($splt_arr)){@split_arr=@$splt_arr;}
	shift(@qword);
	shift(@qword);
	pop(@qword);
	push(@qword,".");
	splice(@qword,0,0,@split_arr);
	foreach(@qword){print"$_ ";}
	foreach(@qword){print"$_ ";}
	print"\n";
	return @qword;
}
 my $FH;
 open($FH,"> $tfff") || die "can not \n";
 foreach(@Fnl_St){print $FH "@{$_}\n";}













