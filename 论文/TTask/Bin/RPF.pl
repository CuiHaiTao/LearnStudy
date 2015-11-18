use strict;
my $usage = "perl .pl text1  text2";
@ARGV == 2 || die $usage;
my ($testfile,$stdfile) = @ARGV;
#############################xls
use Spreadsheet::WriteExcel;
my $workbook = Spreadsheet::WriteExcel->new('perl.xls');
my $worksheet = $workbook->add_worksheet();
my $format = $workbook->add_format();
my $Black_Format = $workbook->add_format();
$Black_Format->set_color('black');
#$format->set_bold();
#$format->set_color('red');
$format->set_align('center');
##########################################################
my $testhandle;
my $stdhandle;

open($testhandle,"< $testfile") || die "can not open $testfile\n";
open($stdhandle,"< $stdfile") || die "can not open $stdfile\n";
#my @testfilearr;
#my @stdfilearr;
my %test = ();
my %ref = ();
my @testFlag_Sentence = ();
my @RefFlag_Sentence = ();
my $testcount = 0;
my $refcount = 0;
my %True_P_MST_Non_True;
my %Hash_Real_match=(
"SS"=> 0,
"CMAS"=> 0,
"CMBS"=> 0,
"CMCS"=> 0,
"CMRS"=> 0,
"SC"=> 0,
"OC"=> 0,
"PC"=> 0,
"AC"=> 0,
"XATC"=> 0,
"NXATC"=> 0,
"TADVC"=> 0,
"WADVC"=> 0,
"RADVC"=> 0,
"CADVC"=> 0,
"PADVC"=> 0,
"CCSADVC"=> 0,
"CMPADVC"=> 0,
"RSLADVC"=> 0,
"MNRADVC"=> 0,
"NON"=> 0,
);

my %SSTrue_P_MST_Non_True=("SS"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])              ;
#my %CCSADVCTrue_P_MST_Non_True=("SS"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])              ;
my %CMASTrue_P_MST_Non_True=("CMAS"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %CMBSTrue_P_MST_Non_True=("CMBS"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %CMCSTrue_P_MST_Non_True=("CMCS"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %NXATCTrue_P_MST_Non_True=("NXATC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])        ;
my %TADVCTrue_P_MST_Non_True=("TADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])        ;
my %WADVCTrue_P_MST_Non_True=("WADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])        ;
my %RADVCTrue_P_MST_Non_True=("RADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])        ;
my %CADVCTrue_P_MST_Non_True=("CADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])        ;
my %PADVCTrue_P_MST_Non_True=("PADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])        ;
my %CCSADVCTrue_P_MST_Non_True=("CCSADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])     ;
my %CMPADVCTrue_P_MST_Non_True=("CMPADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %NONTrue_P_MST_Non_True=("NON"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])            ;
my %CMRSTrue_P_MST_Non_True=("CMRS"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %ACTrue_P_MST_Non_True=("AC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])              ;
my %OCTrue_P_MST_Non_True=("OC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])              ;
my %PCTrue_P_MST_Non_True=("PC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])              ;
my %SCTrue_P_MST_Non_True=("SC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])              ;
my %XATCTrue_P_MST_Non_True=("XATC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %RSLADVCTrue_P_MST_Non_True=("RSLADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
my %MNRADVCTrue_P_MST_Non_True=("MNRADVC"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])          ;
# "RSLADVC"=> 0,
# "MNRADVC"=> 0;

my %One_Type_RLt_TrueNoRlt = (
"SS"=> 0,
"CMAS"=> 0,
"CMBS"=> 0,
"CMCS"=> 0,
"CMRS"=> 0,
"SC"=> 0,
"OC"=> 0,
"PC"=> 0,
"AC"=> 0,
"XATC"=> 0,
"NXATC"=> 0,
"TADVC"=> 0,
"WADVC"=> 0,
"RADVC"=> 0,
"CADVC"=> 0,
"PADVC"=> 0,
"CCSADVC"=> 0,
"CMPADVC"=> 0,
"RSLADVC"=> 0,
"MNRADVC"=> 0,
"NON"=> 0,
);
my %One_Type_NoRLt_TrueRlt = (
"SS"=> 0,
"CMAS"=> 0,
"CMBS"=> 0,
"CMCS"=> 0,
"CMRS"=> 0,
"SC"=> 0,
"OC"=> 0,
"PC"=> 0,
"AC"=> 0,
"XATC"=> 0,
"NXATC"=> 0,
"TADVC"=> 0,
"WADVC"=> 0,
"RADVC"=> 0,
"CADVC"=> 0,
"PADVC"=> 0,
"CCSADVC"=> 0,
"CMPADVC"=> 0,
"RSLADVC"=> 0,
"MNRADVC"=> 0,
"NON"=> 0,
);
my %Precition_Rate = (
"SS"=> 0,
"CMAS"=> 0,
"CMBS"=> 0,
"CMCS"=> 0,
"CMRS"=> 0,
"SC"=> 0,
"OC"=> 0,
"PC"=> 0,
"AC"=> 0,
"XATC"=> 0,
"NXATC"=> 0,
"TADVC"=> 0,
"WADVC"=> 0,
"RADVC"=> 0,
"CADVC"=> 0,
"PADVC"=> 0,
"CCSADVC"=> 0,
"CMPADVC"=> 0,
"RSLADVC"=> 0,
"MNRADVC"=> 0,
"NON"=> 0,
);
my %Recall_Rate = (
"SS"=> 0,
"CMAS"=> 0,
"CMBS"=> 0,
"CMCS"=> 0,
"CMRS"=> 0,
"SC"=> 0,
"OC"=> 0,
"PC"=> 0,
"AC"=> 0,
"XATC"=> 0,
"NXATC"=> 0,
"TADVC"=> 0,
"WADVC"=> 0,
"RADVC"=> 0,
"CADVC"=> 0,
"PADVC"=> 0,
"CCSADVC"=> 0,
"CMPADVC"=> 0,
"RSLADVC"=> 0,
"MNRADVC"=> 0,
"NON"=> 0,
);
while(<$testhandle>)
{
	chomp;
	s/\s+//g;
	
	$_ = No_Symbol($_);
	#print "$_  GGGGG\n";
	push(@testFlag_Sentence,[split(/AAAA/,$_)]);
	$test{"$testcount"} = $_;
	$testcount++;
	#push(@testfilearr,$_);
}
close($testhandle);
while(<$stdhandle>)
{
	chomp;
	#s/\:\:.*//;
	s/\s+//g;
	$_=No_Symbol($_);
	push(@RefFlag_Sentence,[split(/AAAA/,$_)]);
	
	$ref{"$refcount"} = $_;
	$refcount++;
	#push(@stdfilearr,$_);
#print"$_\n";	
}
close($stdhandle);
######################################################
#精确度

#print PC_Pct();
sub  PC_Pct
{
	my $True_Match_Count = 0;
	my $False_match_Count = 0;
	my $Test_PC_Count = 0;
	my $Ref_length = keys %ref;
	my $Test_length = keys %test;
	my $Non_True_PC_To_PC = 0;
	for(my $j = 0;$j<$#testFlag_Sentence;$j++)
	{
		for(my $i=0;$i<$#RefFlag_Sentence;$i++)
		{
			if(@{$testFlag_Sentence[$j]}[1] =~ /\b@{$RefFlag_Sentence[$i]}[1]\b/ and @{$RefFlag_Sentence[$i]}[0] !~ /^PC$/ and @{$testFlag_Sentence[$j]}[1] =~ /^PC$/)
			{
				$Non_True_PC_To_PC++;
			}
		}
	}
	for(my $j = 0;$j<$Test_length;$j++)
	{
		for(my $i=0;$i<$Ref_length;$i++)
		{
			if($ref{"$i"} =~ /\b$test{"$j"}\b/ and $ref{"$i"} =~ /^PC.*/)
			{
				$True_Match_Count++;
				last;
			}
		}
	}
	# for(my $j = 0;$j<$Test_length;$j++)
	# {
		# for(my $i=0;$i<$Ref_length;$i++)
		# {
			# if($ref{"$i"} =~ /\b$test{"$j"}\b/ and $ref{"$i"} =~ /^PC.*/)
			# {
				# $True_Match_Count++;
				# last;
			# }
		# }
	# }
	foreach(values(%test))
	{
		if($_ =~ /^PC.*/)
		{
			$Test_PC_Count++;
		}
	}
	my $PC_Precition = 0;
	if($True_Match_Count != 0 and $Non_True_PC_To_PC != 0)
	{
		$PC_Precition = $True_Match_Count/($True_Match_Count+$Non_True_PC_To_PC);
	}
	return $PC_Precition;
}
#print XATC_Pct();
sub  XATC_Pct
{
	my $True_Match_Count = 0;
	my $False_match_Count = 0;
	my $Test_PC_Count = 0;
	my $Ref_length = keys %ref;
	my $Test_length = keys %test;
	my $Non_True_PC_To_PC = 0;
	
	for(my $j = 0;$j<$#testFlag_Sentence;$j++)
	{
		for(my $i=0;$i<$#RefFlag_Sentence;$i++)
		{
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] !~ /^XATC$/ and @{$testFlag_Sentence[$j]}[1] =~ /^XATC$/)
			{
				$Non_True_PC_To_PC++;
				
			}
		}
	}
	
	for(my $j = 0;$j<$Test_length;$j++)
	{
		# print $test{"$j"};
		# print"\n\n";
		# print $ref{"$j"};
			# print"\n";
		for(my $i=0;$i<$Ref_length;$i++)
		{
			
			if($ref{"$i"} eq $test{"$j"} and $ref{"$i"} =~ /^XATC.*/)
			{
				#print $ref{"$j"};
				#print"\n";
				$True_Match_Count++;
				last;
			}
		}
	}
	# for(my $j = 0;$j<$Test_length;$j++)
	# {
		# for(my $i=0;$i<$Ref_length;$i++)
		# {
			# if($ref{"$i"} =~ /\b$test{"$j"}\b/ and $ref{"$i"} =~ /^PC.*/)
			# {
				# $True_Match_Count++;
				# last;
			# }
		# }
	# }
	foreach(values(%test))
	{
		if($_ =~ /^XATC.*/)
		{
			$Test_PC_Count++;
		}
	}
	my $PC_Precition = 0;
	if($True_Match_Count != 0 or $Non_True_PC_To_PC != 0)
	{
		$PC_Precition = $True_Match_Count/($True_Match_Count+$Non_True_PC_To_PC);
	}
	return $PC_Precition;
}


my @ALLTrue_Asr_MST_Other = ();
XATC_Rcl();
sub  XATC_Rcl
{
	my $True_Match_Count = 0.0;
	my $False_match_Count = 0.0;
	my $Test_PC_Count = 0.0;
	my $Ref_length = keys %ref;
	my $Test_length = keys %test;
	my $True_PC_To_NoPC = 0.0;
	my @True_Match_Taltal;
	
	# for(my $i = 0;$i<$#testFlag_Sentence ;$i++)
	# {
		# print "@{$testFlag_Sentence[$i]}[0]";
		# print "DDD\n";
	# }
	
	
	for(my $j = 0;$j<=$#testFlag_Sentence;$j++)
	{
		#print"@{$testFlag_Sentence[$j]}[0]\n";
		for(my $i=0;$i<=$#RefFlag_Sentence;$i++)
		{
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^XATC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^XATC$/){XATCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^SS$/ and @{$testFlag_Sentence[$j]}[0] !~ /^SS$/){SSTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CMAS$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CMAS$/){CMASTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CMBS$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CMBS$/){CMBSTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CMCS$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CMCS$/){CMCSTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CMRS$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CMRS$/){CMRSTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^NXATC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^NXATC$/){NXATCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^TADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^TADVC$/){TADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^WADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^WADVC$/){WADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^RADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^RADVC$/){RADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CADVC$/){CADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^PADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^PADVC$/){PADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CCSADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CCSADVC$/){CCSADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^CMPADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^CMPADVC$/){CMPADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^NON$/ and @{$testFlag_Sentence[$j]}[0] !~ /^NON$/){NONTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^PC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^PC$/){PCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^SC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^SC$/){SCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^OC$/ and @{$testFlag_Sentence[$j]}[0] !~ /^OC$/){OCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j);}
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^AC$/ and @{$testFlag_Sentence[$j]}[0] !~ /\bAC\b/){ACTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j); }
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^RSLADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /\bRSLADVC\b/){RSLADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j); }
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1] and @{$RefFlag_Sentence[$i]}[0] =~ /^MNRADVC$/ and @{$testFlag_Sentence[$j]}[0] !~ /\bMNRADVC\b/){MNRADVCTrue_Asr_MST_Other(@{$testFlag_Sentence[$j]}[0],@{$RefFlag_Sentence[$i]}[0],$j); }
			
		}
	}
	for(my $j = 0;$j<$Test_length;$j++)
	{
		for(my $i=0;$i<$Ref_length;$i++)
		{
			if($ref{"$i"} eq $test{"$j"})
			{
				$True_Match_Count++;
				True_Match_Sentence($ref{"$i"},$i);
				last;
			}
		}
	}
	# for(my $j = 0;$j<$Test_length;$j++)
	# {
		# for(my $i=0;$i<$Ref_length;$i++)
		# {
			# if($ref{"$i"} =~ /\b$test{"$j"}\b/ and $ref{"$i"} =~ /^PC.*/)
			# {
				# $True_Match_Count++;
				# last;
			# }
		# }
	# }
	foreach(values(%test))
	{
		if($_ =~ /^XATC.*/)
		{
			$Test_PC_Count++;
		}
	}
	
		for(my $j = 0;$j<=$#testFlag_Sentence;$j++)
	{
		for(my $i=0;$i<$#RefFlag_Sentence;$i++)
		{
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1])
			{
				foreach(keys%One_Type_RLt_TrueNoRlt)
				{
					if(@{$testFlag_Sentence[$j]}[0] eq "$_" and @{$RefFlag_Sentence[$i]}[0] ne "$_")
					{
						$One_Type_RLt_TrueNoRlt{$_}++;
					}
				}
			}
			
		}
		
				
	}
		for(my $j = 0;$j<=$#testFlag_Sentence;$j++)
	{
		for(my $i=0;$i<$#RefFlag_Sentence;$i++)
		{
			if(@{$testFlag_Sentence[$j]}[1] eq @{$RefFlag_Sentence[$i]}[1])
			{
				foreach(keys%One_Type_NoRLt_TrueRlt)
				{
					if(@{$testFlag_Sentence[$j]}[0] ne "$_" and @{$RefFlag_Sentence[$i]}[0] eq "$_")
					{
						$One_Type_NoRLt_TrueRlt{$_}++;
					}
				}
			}	
		}	
	}
	
	
	#my $PC_Rcll = $True_Match_Count/($True_Match_Count+$True_PC_To_NoPC);
	#return $PC_Rcll;
}


#




sub RSLADVCTrue_Asr_MST_Other
{
	
	my ($String,$RefFlag_Sen,$j) = @_;
	my $TADVC = "RSLADVC";
	if($String =~ /\bSS\b/){@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)	{	@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)	{  @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)	{@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/){	@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/){@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)	{ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/){  @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/){@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/){@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/){@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/){@{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}   
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$RSLADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
	
	 #return %TADVCTrue_P_MST_Non_True;
}

sub MNRADVCTrue_Asr_MST_Other                            
{                                                      #SS
	                                                     #SS
	my ($String,$RefFlag_Sen,$j) = @_;                   #SS
	my $TADVC = "MNRADVC";                                  #SS
	if($String =~ /\bSS\b/)														{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;}                           
	if($String =~ /\bSC\b/)														{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$MNRADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
	                                                      
	 #return %TADVCTrue_P_MST_Non_True;                       
} 



#my %TADVCTrue_P_MST_Non_True;
sub TADVCTrue_Asr_MST_Other
{
	
	my ($String,$RefFlag_Sen,$j) = @_;
	my $TADVC = "TADVC";
	if($String =~ /\bSS\b/){@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)	{	@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)	{  @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)	{@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/){	@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/){@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)	{ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/){  @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/){@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/){@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/){@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/){@{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$TADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
	
	 #return %TADVCTrue_P_MST_Non_True;
}
#################
#my %SSTrue_P_MST_Non_True;
#my %SSTrue_P_MST_Non_True;
																								  # my %SSTrue_P_MST_Non_True;
sub SSTrue_Asr_MST_Other                            
{                                                      #SS
	                                                     #SS
	my ($String,$RefFlag_Sen,$j) = @_;                   #SS
	my $TADVC = "SS";                                  #SS
	if($String =~ /\bSS\b/)														{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[4]++;}                           
	if($String =~ /\bSC\b/)														{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$SSTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$SSTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$SSTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$SSTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$SSTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$SSTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
	                                                      
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %CMASTrue_P_MST_Non_True;
																								  # my %CMASTrue_P_MST_Non_True;
sub CMASTrue_Asr_MST_Other                            
{                                                      #CMAS
	                                                     #CMAS
	my ($String,$RefFlag_Sen,$j) = @_;                   #CMAS
	my $TADVC = "CMAS";                                  #CMAS
	if($String =~ /\bSS\b/)														{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[4]++;}                           
	if($String =~ /\bSC\b/)														{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CMASTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CMASTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CMASTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CMASTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                     
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %CMBSTrue_P_MST_Non_True;
																								  # my %CMBSTrue_P_MST_Non_True;
sub CMBSTrue_Asr_MST_Other                            
{                                                      #CMBS
	                                                     #CMBS
	my ($String,$RefFlag_Sen,$j) = @_;                   #CMBS
	my $TADVC = "CMBS";                                  #CMBS
	if($String =~ /\bSS\b/)														{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CMBSTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                      
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %CMCSTrue_P_MST_Non_True;
																								  # my %CMCSTrue_P_MST_Non_True;
sub CMCSTrue_Asr_MST_Other                            
{                                                      #CMCS
	                                                     #CMCS
	my ($String,$RefFlag_Sen,$j) = @_;                   #CMCS
	my $TADVC = "CMCS";                                  #CMCS
	if($String =~ /\bSS\b/)														{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CMCSTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %CMRSTrue_P_MST_Non_True;
																								  # my %CMRSTrue_P_MST_Non_True;
sub CMRSTrue_Asr_MST_Other                            
{                                                      #CMRS
	                                                     #CMRS
	my ($String,$RefFlag_Sen,$j) = @_;                   #CMRS
	my $TADVC = "CMRS";                                  #CMRS
	if($String =~ /\bSS\b/)														{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CMRSTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %PCTrue_P_MST_Non_True;
																								  # my %PCTrue_P_MST_Non_True;
sub PCTrue_Asr_MST_Other                            
{                                                      #PC
	                                                     #PC
	my ($String,$RefFlag_Sen,$j) = @_;                   #PC
	my $TADVC = "PC";                                  #PC
	if($String =~ /\bSS\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)	{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)	{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)	{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)	{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/){@{$PCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$PCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$PCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$PCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$PCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$PCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$PCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %SCTrue_P_MST_Non_True;
																								  # my %SCTrue_P_MST_Non_True;
sub SCTrue_Asr_MST_Other                            
{                                                      #SC
	                                                     #SC
	my ($String,$RefFlag_Sen,$j) = @_;                   #SC
	my $TADVC = "SC";                                  #SC
	if($String =~ /\bSS\b/)														{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$SCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$SCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$SCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$SCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$SCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$SCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
	                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %OCTrue_P_MST_Non_True;
																								  # my %OCTrue_P_MST_Non_True;
sub OCTrue_Asr_MST_Other                            
{                                                      #OC
	                                                     #OC
	my ($String,$RefFlag_Sen,$j) = @_;                   #OC
	my $TADVC = "OC";                                  #OC
	if($String =~ /\bSS\b/)														{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$OCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$OCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$OCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$OCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$OCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$OCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                        
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %ACTrue_P_MST_Non_True;
# my %XATCTrue_P_MST_Non_True;
sub ACTrue_Asr_MST_Other                            
{                                                      #AC
	                                                     #AC
	my ($String,$RefFlag_Sen,$j) = @_;                   #AC
	my $TADVC = "AC";                                  #AC
	if($String =~ /\bSS\b/)														{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bXATC\b/)	{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$ACTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$ACTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$ACTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$ACTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$ACTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$ACTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
	#@{$ACTrue_P_MST_Non_True{"$TADVC"}}[20] = 0;           
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %XATCTrue_P_MST_Non_True;
																								  # my %XATCTrue_P_MST_Non_True;
sub XATCTrue_Asr_MST_Other                            
{                                                      #XATC
	                                                     #XATC
	my ($String,$RefFlag_Sen,$j) = @_;                   #XATC
	my $TADVC = "XATC";                                  #XATC
	if($String =~ /\bSS\b/)														{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$XATCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$XATCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$XATCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$XATCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                        
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %NXATCTrue_P_MST_Non_True;
																								  # my %NXATCTrue_P_MST_Non_True;
sub NXATCTrue_Asr_MST_Other                            
{                                                      #NXATC
	                                                     #NXATC
	my ($String,$RefFlag_Sen,$j) = @_;                   #NXATC
	my $TADVC = "NXATC";                                  #NXATC
	if($String =~ /\bSS\b/)														{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$NXATCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################

#################
#my %WADVCTrue_P_MST_Non_True;
																								  # my %WADVCTrue_P_MST_Non_True;
sub WADVCTrue_Asr_MST_Other                            
{                                                      #WADVC
	                                                     #WADVC
	my ($String,$RefFlag_Sen,$j) = @_;                   #WADVC
	my $TADVC = "WADVC";                                  #WADVC
	if($String =~ /\bSS\b/)														{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$WADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                        
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %RADVCTrue_P_MST_Non_True;
																								  # my %RADVCTrue_P_MST_Non_True;
																									  sub RADVCTrue_Asr_MST_Other                            
{                                                      #RADVC
	                                                     #RADVC
	my ($String,$RefFlag_Sen,$j) = @_;                   #RADVC
	my $TADVC = "RADVC";                                  #RADVC
	if($String =~ /\bSS\b/)														{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$RADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                        
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                            
#################
#my %CADVCTrue_P_MST_Non_True;
																								  #  my %PADVCTrue_P_MST_Non_True;
																								  # my %CADVCTrue_P_MST_Non_True;
 sub CADVCTrue_Asr_MST_Other                            
{                                                      #CADVC
	                                                     #CADVC
	my ($String,$RefFlag_Sen,$j) = @_;                   #CADVC
	my $TADVC = "CADVC";                                  #CADVC
	if($String =~ /\bSS\b/)														{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                                                                                
                                                                                                                      
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
#################
#my %PADVCTrue_P_MST_Non_True;
#my %PADVCTrue_P_MST_Non_True;
sub PADVCTrue_Asr_MST_Other                             #PADVC
{                                                      #PADVC
	                                                     #PADVC
	my ($String,$RefFlag_Sen,$j) = @_;                   #PADVC
	my $TADVC = "PADVC";                                  #PADVC
	if($String =~ /\bSS\b/)														{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$PADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
#DVCTrue_P_MST_Non_True;                       
}                                                           
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
#################
# my %CCSADVCTrue_P_MST_Non_True;
sub CCSADVCTrue_Asr_MST_Other                             #CCSADVC
{                                                      #CCSADVC
	                                                     #CCSADVC
	my ($String,$RefFlag_Sen,$j) = @_;                   #CCSADVC
	my $TADVC = "CCSADVC";                                  #CCSADVC
	if($String =~ /\bSS\b/)														{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CCSADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                       
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
#################
 #my %CMPADVCTrue_P_MST_Non_True;
sub CMPADVCTrue_Asr_MST_Other                             #CMPADVC
{                                                      #CMPADVC
	                                                     #CMPADVC
	my ($String,$RefFlag_Sen,$j) = @_;                   #CMPADVC
	my $TADVC = "CMPADVC";                                  #CMPADVC
	if($String =~ /\bSS\b/)														{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)													{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/)													{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)													{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)													{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/)														{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)			{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)			{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)			{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/)													{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)		{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)		{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)		{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)		{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)		{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)		{@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/) {@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)    {@{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$CMPADVCTrue_P_MST_Non_True{"$TADVC"}}[20]++;}
                                                        
	 #return %TADVCTrue_P_MST_Non_True;                       
}                                                           
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
#################
#my %NONTrue_P_MST_Non_True;
sub NONTrue_Asr_MST_Other
{
	
	my ($String,$RefFlag_Sen,$j) = @_;
	my $TADVC = "NON";
	if($String =~ /\bSS\b/){@{$NONTrue_P_MST_Non_True{"$TADVC"}}[0]++;}                           
	if($String =~ /\bCMAS\b/)	{	@{$NONTrue_P_MST_Non_True{"$TADVC"}}[1]++;}                           
	if($String =~ /\bCMBS\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[2]++;}                           
	if($String =~ /\bCMCS\b/)	{  @{$NONTrue_P_MST_Non_True{"$TADVC"}}[3]++;}                           
	if($String =~ /\bCMRS\b/)	{@{$NONTrue_P_MST_Non_True{"$TADVC"}}[4]++;	}                           
	if($String =~ /\bSC\b/){	@{$NONTrue_P_MST_Non_True{"$TADVC"}}[5]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/){@{$NONTrue_P_MST_Non_True{"$TADVC"}}[6]++;}                                                    
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)	{ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[7]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[8]++;}                           
	if($String =~ /\bXATC\b/){  @{$NONTrue_P_MST_Non_True{"$TADVC"}}[9]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[10]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[11]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/){@{$NONTrue_P_MST_Non_True{"$TADVC"}}[12]++;	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/){@{$NONTrue_P_MST_Non_True{"$TADVC"}}[13]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[14]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/){@{$NONTrue_P_MST_Non_True{"$TADVC"}}[15]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/){@{$NONTrue_P_MST_Non_True{"$TADVC"}}[16]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[17]++;}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[18]++;}
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[19]++;}	
	if($String =~ /\bNON\b/){ @{$NONTrue_P_MST_Non_True{"$TADVC"}}[20]++;}

	 #return %TADVCTrue_P_MST_Non_True;
}
#################
#########################################################################################################################
sub  PC_Rcl
{
	my $True_Match_Count = 0;
	my $False_match_Count = 0;
	my $Test_PC_Count = 0;
	my $Ref_length = keys %ref;
	my $Test_length = keys %test;
	my $True_PC_To_NoPC = 0;
	for(my $j = 0;$j<$#testFlag_Sentence;$j++)
	{
		for(my $i=0;$i<$#RefFlag_Sentence;$i++)
		{
			if(@{$testFlag_Sentence[$j]}[1] =~ /\b@{$RefFlag_Sentence[$i]}[1]\b/ and @{$RefFlag_Sentence[$i]}[0] =~ /^PC$/ and @{$testFlag_Sentence[$j]}[1] !~ /^PC$/)
			{
				$True_PC_To_NoPC++;
			}
		}
	}
	for(my $j = 0;$j<$Test_length;$j++)
	{
		for(my $i=0;$i<$Ref_length;$i++)
		{
			if($ref{"$i"} =~ /\b$test{"$j"}\b/ and $ref{"$i"} =~ /^PC.*/)
			{
				$True_Match_Count++;
				last;
			}
		}
	}
	# for(my $j = 0;$j<$Test_length;$j++)
	# {
		# for(my $i=0;$i<$Ref_length;$i++)
		# {
			# if($ref{"$i"} =~ /\b$test{"$j"}\b/ and $ref{"$i"} =~ /^PC.*/)
			# {
				# $True_Match_Count++;
				# last;
			# }
		# }
	# }
	foreach(values(%test))
	{
		if($_ =~ /^PC.*/)
		{
			$Test_PC_Count++;
		}
	}
	my $PC_Rcll = $True_Match_Count/($True_Match_Count+$True_PC_To_NoPC);
	return $PC_Rcll;
}


sub compare {
    my ( $str1, $str2 ) = @_;
	#my @outarr = ();
    #print "\nCompare '$str1' and '$str2'\n" if $DEBUG;
    my $tok_str1 = tokenize($str1);
    my $tok_str2 = tokenize($str2);
    my (@match,@str1, @str2);
    traverse_sequences( $tok_str1, $tok_str2, {
        MATCH => sub { push @match, $tok_str1->[$_[0]] },
        DISCARD_A => sub { push @str1, $tok_str1->[$_[0]] },
        DISCARD_B => sub { push @str2, $tok_str2->[$_[1]] },
    });
	# my ($var1) = join(' ',@match);
	# my ($var2) = join(' ',@str1);
	# my ($var3) = join(' ',@str2);
	# my ($var4) = @match/(@match+@str1);
	# my ($var5) = @match/(@match+@str2);
	# my ($var6) = $str1;
	# my ($var7) = $str2;
	#push(@outarr,($var1,$var2,$var3,$var4,$var5,$var6,$var7));
   # print "\ncommunal_word '@match' \ndismatch_mdl '@str1' \ndismatch_text '@str2'\n" if $DEBUG;
  return @match/(@match+@str1);
  #return @outarr;
}

sub tokenize {
    my ($str) = @_;
    # remove punctuation stuff
    $str =~ s/\W+//g;
	#$str =~ s/[,;]/ ,/g;
    # lowercase
    $str = lc $str;
    # return array ref
  return [split ' ', $str];
}
sub No_Symbol {
    my ($str) = @_;
    # remove punctuation stuff
    $str =~ s/\W+//g;
	#$str =~ s/[,;]/ ,/g;
    # lowercase
    $str = uc $str;
    # return array ref
  return $str;
}



sub True_Asr_MST_Other
{
	my ($String,$j) = @_;
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bSS\b/)
	{
		@{$True_P_MST_Non_True{"$String"}}[0]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMAS\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[1]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMBS\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[2]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMCS\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[3]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMRS\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[4]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bSC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[5]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bOC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[6]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bSC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[7]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[8]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bAC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[9]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bXATC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[10]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNXATC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[10]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bTADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[11]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bWADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[12]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[13]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[14]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bPADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[15]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCCSADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[16]++;
	}                           
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bCMPADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[17]++;
	} 
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bRSLADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[18]++;
	}  
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bMNRADVC\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[19]++;
	}  
	if(@{$testFlag_Sentence[$j]}[0] =~ /\bNON\b/)
	{                           
		@{$True_P_MST_Non_True{"$String"}}[20]++;
		#print "GGGGGGGGGGGGGG\n";
	}

}

#######################################################################
sub True_Match_Sentence
{
	my ($String,$i) = @_;
	if($String =~ /^SS.*/)
	{
		$Hash_Real_match{"SS"}++;
	}                           
	if($String =~ /^CMAS.*/)
	{                           
		$Hash_Real_match{"CMAS"}++;
	}                           
	if($String =~ /^CMBS.*/)
	{                           
		$Hash_Real_match{"CMBS"}++;
	}                           
	if($String =~ /^CMCS.*/)
	{                           
		$Hash_Real_match{"CMCS"}++;
	}                           
	if($String =~ /^CMRS.*/)
	{                           
		$Hash_Real_match{"CMRS"}++;
	}                           
	if($String =~ /^SC.*/)
	{                           
		$Hash_Real_match{"SC"}++;
	}                           
	if($String =~ /^OC.*/)
	{          
		
		$Hash_Real_match{"OC"}++;
	}                                                     
	if($String =~ /^PC.*/)
	{                           
		$Hash_Real_match{"PC"}++;
	}                           
	if($String =~ /^AC.*/)
	{                          
		$Hash_Real_match{"AC"}++;
	}                           
	if($String =~ /^XATC.*/)
	{                           
		$Hash_Real_match{"XATC"}++;
	}                           
	if($String =~ /^NXATC.*/)
	{                           
		$Hash_Real_match{"NXATC"}++;
	}                           
	if($String =~ /^TADVC.*/)
	{                           
		$Hash_Real_match{"TADVC"}++;
	}                           
	if($String =~ /^WADVC.*/)
	{                        
		$Hash_Real_match{"WADVC"}++;
	}                           
	if($String =~ /^RADVC.*/)
	{                           
		$Hash_Real_match{"RADVC"}++;
	}                           
	if($String =~ /^CADVC.*/)
	{               # print "$i\n";               
		$Hash_Real_match{"CADVC"}++;
	}                           
	if($String =~ /^PADVC.*/)
	{                          
		$Hash_Real_match{"PADVC"}++;
	}                           
	if($String =~ /^CCSADVC.*/)
	{                           
		$Hash_Real_match{"CCSADVC"}++;
	}                           
	if($String =~ /^CMPADVC.*/)
	{                           
		$Hash_Real_match{"CMPADVC"}++;
	}
	if($String =~ /^RSLADVC.*/)
		{                           
			$Hash_Real_match{"RSLADVC"}++;
		}
	if($String =~ /^MNRADVC.*/)
		{                           
			$Hash_Real_match{"MNRADVC"}++;
		}	
	if($String =~ /^NON.*/)
	{                           
		$Hash_Real_match{"NON"}++;
	}
}


# foreach(sort{lc(my $a) cmp lc (my $b)}keys%True_P_MST_Non_True)
# {
	# print"RRRRRRRRRR $_\n";
# }







# @{$SSTrue_P_MST_Non_True{"SS"}}[0] = $Hash_Real_match{"SS"};
# $CMASTrue_P_MST_Non_True{"CMAS"} = $Hash_Real_match{"CMAS"};
# $CMBSTrue_P_MST_Non_True{"CMBS"} = $Hash_Real_match{"CMBS"};
# $CMCSTrue_P_MST_Non_True{"CMCS"} = $Hash_Real_match{"CMCS"};
# $CMRSTrue_P_MST_Non_True{"CMRS"} = $Hash_Real_match{"CMRS"};
# $SCTrue_P_MST_Non_True{"SC"} = $Hash_Real_match{"SC"};
# $OCTrue_P_MST_Non_True{"OC"} = $Hash_Real_match{"OC"};
# $PCTrue_P_MST_Non_True{"PC"} = $Hash_Real_match{"PC"};
# $ACTrue_P_MST_Non_True{"SC"} = $Hash_Real_match{"AC"};
# $XATCTrue_P_MST_Non_True{"XATC"} = $Hash_Real_match{"XATC"};
# $NXATCTrue_P_MST_Non_True{"NXATC"} = $Hash_Real_match{"NXATC"};
# $TADVCTrue_P_MST_Non_True{"TADVC"} = $Hash_Real_match{"TADVC"};
# $WADVCTrue_P_MST_Non_True{"WADVC"} = $Hash_Real_match{"WADVC"};
# $RADVCTrue_P_MST_Non_True{"RADVC"} = $Hash_Real_match{"RADVC"};
# $CADVCTrue_P_MST_Non_True{"CADVC"} = $Hash_Real_match{"CADVC"};
# $PADVCTrue_P_MST_Non_True{"PADVC"} = $Hash_Real_match{"PADVC"};
# $CCSADVCTrue_P_MST_Non_True{"CCSADVC"} = $Hash_Real_match{"CCSADVC"};
# $CMPADVCTrue_P_MST_Non_True{"CMPADVC"} = $Hash_Real_match{"CMPADVC"};

@{$SSTrue_P_MST_Non_True{"SS"}}[0]	   = $Hash_Real_match{"SS"};
@{$CMASTrue_P_MST_Non_True{"CMAS"}}[1]= $Hash_Real_match{"CMAS"};
@{$CMBSTrue_P_MST_Non_True{"CMBS"}}[2]= $Hash_Real_match{"CMBS"};
@{$CMCSTrue_P_MST_Non_True{"CMCS"}}[3] = $Hash_Real_match{"CMCS"};
@{$CMRSTrue_P_MST_Non_True{"CMRS"}}[4]= $Hash_Real_match{"CMRS"};
@{$SCTrue_P_MST_Non_True{"SC"}}[5]= $Hash_Real_match{"SC"};
@{$OCTrue_P_MST_Non_True{"OC"}}[6]= $Hash_Real_match{"OC"};
@{$PCTrue_P_MST_Non_True{"PC"}}[7] 	  = $Hash_Real_match{"PC"};
@{$ACTrue_P_MST_Non_True{"AC"}}[8] 	  = $Hash_Real_match{"AC"};
@{$XATCTrue_P_MST_Non_True{"XATC"}	}[9] 	   = $Hash_Real_match{"XATC"};
@{$NXATCTrue_P_MST_Non_True{"NXATC"}}[10] 	  	 = $Hash_Real_match{"NXATC"};
@{$TADVCTrue_P_MST_Non_True{"TADVC"}}[11]  = $Hash_Real_match{"TADVC"};
@{$WADVCTrue_P_MST_Non_True{"WADVC"}}[12]  = $Hash_Real_match{"WADVC"};
@{$RADVCTrue_P_MST_Non_True{"RADVC"}}[13]  = $Hash_Real_match{"RADVC"};
@{$CADVCTrue_P_MST_Non_True{"CADVC"}}[14]  = $Hash_Real_match{"CADVC"};
@{$PADVCTrue_P_MST_Non_True{"PADVC"}}[15]  = $Hash_Real_match{"PADVC"};
@{$CCSADVCTrue_P_MST_Non_True{"CCSADVC"}}[16]  = $Hash_Real_match{"CCSADVC"};
@{$CMPADVCTrue_P_MST_Non_True{"CMPADVC"}}[17]  =  $Hash_Real_match{"CMPADVC"};
@{$RSLADVCTrue_P_MST_Non_True{"RSLADVC"}}[18]  =  $Hash_Real_match{"RSLADVC"};
@{$MNRADVCTrue_P_MST_Non_True{"MNRADVC"}}[19]  =  $Hash_Real_match{"MNRADVC"};








Print();
sub Print
{
	my @Out = ("SS","CMAS","CMBS","CMCS","CMRS","SC","OC","PC","AC","XATC","NXATC","TADVC","WADVC","RADVC","CADVC","PADVC","CCSADVC","CMPADVC","RSLADVC","MNRADVC","NON");
	my @Out_out = ("SS","CMS_A","CMS_B","CMS_C","CMS_R","C_S","C_O","C_P","C_A","ATC_X","ATC_NX","ADVC_T","ADVC_W","ADVC_R","ADVC_C","ADVC_P","ADVC_CCS","ADVC_CMP","ADVC_RSL","ADVC_MNR","NON");
	#print scalar(@Out);
	for(my $i = 0;$i <=$#Out_out;$i++)
	{
		$worksheet->write(0,    $i+1, $Out_out[$i]);
	}
	#print "\n";
	for(my $i = 0;$i <scalar(@Out);$i++)
	{
		#printf "%-8s", $_;
		$worksheet->write($i+1,    0, $Out_out[$i]);
		#my @tmparr = $Out[$i]
		if($Out[$i] eq "SS")		{for(my $j = 0;$j <scalar(@{$SSTrue_P_MST_Non_True{"$Out[$i]"}})  	 ;$j++) {$worksheet->write($i+1,    $j+1, @{$SSTrue_P_MST_Non_True{"$Out[$i]"}}[$j]     	,$format);}        }#print"\n"; 
		if($Out[$i] eq "CMAS")	{for(my $j = 0;$j <scalar(@{$CMASTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$CMASTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}    }#print"\n";                                   	                                                                      print"\n";
		if($Out[$i] eq "CMBS")	{for(my $j = 0;$j <scalar(@{$CMBSTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$CMBSTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}  }#print"\n";              	
		if($Out[$i] eq "CMCS")	{for(my $j = 0;$j <scalar(@{$CMCSTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$CMCSTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}  }#print"\n";              		    
		if($Out[$i] eq "NXATC")	{for(my $j = 0;$j <scalar(@{$NXATCTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$NXATCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}   }#print"\n"; 
		if($Out[$i] eq "TADVC")	{for(my $j = 0;$j <scalar(@{$TADVCTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$TADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}   }#print"\n"; 
		if($Out[$i] eq "WADVC")	{for(my $j = 0;$j <scalar(@{$WADVCTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$WADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}   }#print"\n"; 
		if($Out[$i] eq "RADVC")	{for(my $j = 0;$j <scalar(@{$RADVCTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$RADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}   }#print"\n"; 
		if($Out[$i] eq "CADVC")	{for(my $j = 0;$j <scalar(@{$CADVCTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$CADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}   }#print"\n"; 
		if($Out[$i] eq "PADVC")	{for(my $j = 0;$j <scalar(@{$PADVCTrue_P_MST_Non_True{"$Out[$i]"}})	 ;$j++) 	{$worksheet->write($i+1,    $j+1, @{$PADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}   }#print"\n"; 
		if($Out[$i] eq "CCSADVC") {for(my $j = 0;$j <scalar(@{$CCSADVCTrue_P_MST_Non_True{"$Out[$i]"}});$j++)	{$worksheet->write($i+1,    $j+1, @{$CCSADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j] 	,$format);} }#print"\n"; 
		if($Out[$i] eq "CMPADVC")    {for(my $j = 0;$j <scalar(@{$CMPADVCTrue_P_MST_Non_True{"$Out[$i]"}})   ;$j++)	{$worksheet->write($i+1,    $j+1, @{$CMPADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}}#print"\n";   
		if($Out[$i] eq "NON")		{for(my $j = 0;$j <scalar(@{$NONTrue_P_MST_Non_True{"$Out[$i]"}})    ;$j++) {$worksheet->write($i+1,    $j+1, @{$NONTrue_P_MST_Non_True{"$Out[$i]"}}[$j]		,$format);}     }	#print"\n";}
		if($Out[$i] eq "CMRS")	{for(my $j = 0;$j <scalar(@{$CMRSTrue_P_MST_Non_True{"$Out[$i]"}})   ;$j++)		{$worksheet->write($i+1,    $j+1, @{$CMRSTrue_P_MST_Non_True{"$Out[$i]"}}[$j]  		,$format);} }#print"\n"; 
		if($Out[$i] eq "SC")		{for(my $j = 0;$j <scalar(@{$SCTrue_P_MST_Non_True{"$Out[$i]"}})     ;$j++) {$worksheet->write($i+1,    $j+1, @{$SCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]			,$format);}      }#print"\n"; 
		if($Out[$i] eq "OC")		{for(my $j = 0;$j <scalar(@{$OCTrue_P_MST_Non_True{"$Out[$i]"}})     ;$j++) {$worksheet->write($i+1,    $j+1, @{$OCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]			,$format);}      }#print"\n"; 
		if($Out[$i] eq "PC")		{for(my $j = 0;$j <scalar(@{$PCTrue_P_MST_Non_True{"$Out[$i]"}})     ;$j++) {$worksheet->write($i+1,    $j+1, @{$PCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]			,$format);}      }#print"\n"; 
		if($Out[$i] eq "AC")		{for(my $j = 0;$j <scalar(@{$ACTrue_P_MST_Non_True{"$Out[$i]"}})     ;$j++) {$worksheet->write($i+1,    $j+1, @{$ACTrue_P_MST_Non_True{"$Out[$i]"}}[$j]     	,$format);}      }#print"\n"; 
		if($Out[$i] eq "XATC")	{for(my $j = 0;$j <scalar(@{$XATCTrue_P_MST_Non_True{"$Out[$i]"}})   ;$j++)   	{$worksheet->write($i+1,    $j+1, @{$XATCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]   	,$format);} }#print"\n"; 
		if($Out[$i] eq "RSLADVC")	{for(my $j = 0;$j <scalar(@{$RSLADVCTrue_P_MST_Non_True{"$Out[$i]"}})   ;$j++)   	{$worksheet->write($i+1,    $j+1, @{$RSLADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]   	,$format);} }#print"\n"; 
		if($Out[$i] eq "MNRADVC")	{for(my $j = 0;$j <scalar(@{$MNRADVCTrue_P_MST_Non_True{"$Out[$i]"}})   ;$j++)   	{$worksheet->write($i+1,    $j+1, @{$MNRADVCTrue_P_MST_Non_True{"$Out[$i]"}}[$j]   	,$format);} }#print"\n"; 
		if($Out[$i] eq "NON")	{for(my $j = 0;$j <scalar(@{$NONTrue_P_MST_Non_True{"$Out[$i]"}})   ;$j++)   	{$worksheet->write($i+1,    $j+1, @{$NONTrue_P_MST_Non_True{"$Out[$i]"}}[$j]   	,$format);} }#print"\n"; 
		#print"\n";                                                                                    #
		
	}
		

}


#print scalar(@stdfilearr);

precition_print();
########################################
 sub precition_print
 {
	 #my @Out = ("SS","CMAS","CMBS","CMCS","CMRS","SC","OC","PC","AC","XATC","NXATC","TADVC","WADVC","RADVC","CADVC","PADVC","CCSADVC","CMPADVC","NON");
	 #my @Out_out = ("SS","CMS_A","CMS_B","CMS_C","CMS_R","C_S","C_O","C_P","C_A","ATC_X","ATC_NX","ADVC_T","ADVC_W","ADVC_R","ADVC_C","ADVC_P","ADVC_CCS","ADVC_CMP","NON");
	 my @Out = ("SS","CMAS","CMBS","CMCS","CMRS","SC","OC","PC","AC","XATC","NXATC","TADVC","WADVC","RADVC","CADVC","PADVC","CCSADVC","CMPADVC","RSLADVC","MNRADVC","NON");
	 my @Out_out = ("SS","CMS_A","CMS_B","CMS_C","CMS_R","C_S","C_O","C_P","C_A","ATC_X","ATC_NX","ADVC_T","ADVC_W","ADVC_R","ADVC_C","ADVC_P","ADVC_CCS","ADVC_CMP","ADVC_RSL","ADVC_MNR","NON");
	 foreach(@Out)
	 {
		 if($Hash_Real_match{$_} != 0 or $One_Type_RLt_TrueNoRlt{$_} != 0)
		 {
			$Precition_Rate{$_} = $Hash_Real_match{$_}/($Hash_Real_match{$_} + $One_Type_RLt_TrueNoRlt{$_});
		 }
		 
	 }
	$worksheet->write(25,   0, "Precition_Rate"  	,$Black_Format);
	#print"P       ";
	for(my $i=0;$i<=$#Out_out;$i++)
	{
		$worksheet->write(25,    $i+1, $Out_out[$i]   	,$Black_Format);
		#printf "%-8s", $_;
	}
	#print "\n";
	#print"        ";
	for(my $i=0;$i<=$#Out;$i++)
	{
		my $PRate = sprintf( "%.2f", $Precition_Rate{$Out[$i]} ) * 100 . '%';
		$worksheet->write(26,    $i+1, $PRate   	,$format);
		#printf "%-8s", 
	}
	#print"\n";
 }

 
recall_print();
########################################
 sub recall_print
 {
	 #my @Out = ("SS","CMAS","CMBS","CMCS","CMRS","SC","OC","PC","AC","XATC","NXATC","TADVC","WADVC","RADVC","CADVC","PADVC","CCSADVC","CMPADVC","NON");
	 #my @Out_out = ("SS","CMS_A","CMS_B","CMS_C","CMS_R","C_S","C_O","C_P","C_A","ATC_X","ATC_NX","ADVC_T","ADVC_W","ADVC_R","ADVC_C","ADVC_P","ADVC_CCS","ADVC_CMP","NON");
	 my @Out = ("SS","CMAS","CMBS","CMCS","CMRS","SC","OC","PC","AC","XATC","NXATC","TADVC","WADVC","RADVC","CADVC","PADVC","CCSADVC","CMPADVC","RSLADVC","MNRADVC","NON");
	 my @Out_out = ("SS","CMS_A","CMS_B","CMS_C","CMS_R","C_S","C_O","C_P","C_A","ATC_X","ATC_NX","ADVC_T","ADVC_W","ADVC_R","ADVC_C","ADVC_P","ADVC_CCS","ADVC_CMP","ADVC_RSL","ADVC_MNR","NON");
	 foreach(@Out)
	 {
		 if($Hash_Real_match{$_} != 0 or $One_Type_NoRLt_TrueRlt{$_} != 0)
		 {
			$Recall_Rate{$_} = $Hash_Real_match{$_}/($Hash_Real_match{$_} + $One_Type_NoRLt_TrueRlt{$_});
		 }
		 
	 }
	$worksheet->write(28,   0, "Recall_Rate"  	,$Black_Format);
	#print"P       ";
	for(my $i=0;$i<=$#Out_out;$i++)
	{
		$worksheet->write(28,    $i+1, $Out_out[$i]   	,$Black_Format);
		#printf "%-8s", $_;
	}
	#print "\n";
	#print"        ";
	for(my $i=0;$i<=$#Out;$i++)
	{
		my $PRate = sprintf( "%.2f", $Recall_Rate{$Out[$i]} ) * 100 . '%';
		$worksheet->write(29,    $i+1, $PRate   	,$format);
		#printf "%-8s", 
	}
 }
#print scalar(@stdfilearr);




















