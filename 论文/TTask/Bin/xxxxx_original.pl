#print "AAAKKKK";
use strict;
use Cwd;
use utf8;
use Algorithm::Diff qw(traverse_sequences);
use open ":encoding(gbk)", ":std";
#use lib 'E:/cht/sent/Lib';
use FindBin qw($Bin); 
use lib "$Bin/../lib";
use File::Find;
use TmWhe qw(DealTmWheFile);
use MulTree qw(TestTraverse SbarNumber SbarSAllWord ThSAllWord ThCCAllWord SbarPPWord SbarSChild  SbarAllword ThreeRlatSbar MainTruck SbarLeftSibling SbarAllFather SbarAllChildren SbarRightSibling SbarFather);
use WPosParse_TypeDependent qw(Sentence_PriVerb_Locate WordsAndPos_Penn_TypedDependt TextPath Pos Word Penn TypeDpdt Verb SentenceKinds Predivate_Verb_and_Location Sentence_Sub_Locate);

my ($usage) = "perl .pl fullpathtext";
@ARGV || die $usage;
my ($tfff) = @ARGV;
my $file_parse_handle;
my $local_direc = getcwd();
#$local_direc =~ s/\//\\/g;
my ($dirname, $outName) = $local_direc =~ /(.*)\/(.*)/;
my ($nerpath) = DealTmWheFile($tfff);
#my @NerSent = TmWhe_Sentence();
TextPath("$nerpath");
#print "$tfff"."RRRRRRRRRRRRR\n";

#print $ENV{'PWD'};
#TextPath("$dirname/data/sample.txt");

# my @rrr = Verb();
# foreach(@rrr)
# {
	# print "@{@$_[0]}\n";
# }
 my @correct_rate = ();
 my @result = ();
 ###########################################评价系统
my @store_class = ();
# my $evalue;
 # open($evalue,"< $evaluetext") || die "can not open $evaluetext\n";
 # my $line = 0;
 # my $matchflag = 1;
# while(<$evalue>)
# {
	# chomp;
	# my  @store_class = split(/:/,$_);
	
# } 
# close($evalue);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 #########################################################################################Main
#print "$local_direc\n";
#GGG($TT);
 my @SThirdCls = StateThrBigCls();
 my @Kinds = SentenceKinds();
 my @SDeclNumSS =Subject();
 my @Word = Word();
 my @sbarnumber = Sbarnumber();
 my @PENN = Penn();

 for(my $i = 0;$i<=$#SDeclNumSS;$i++)
 {
	 SubClause("@{$PENN[$i]}",$i);
	 PredicativeClause("@{$PENN[$i]}",$i);
	 ObjectClause("@{$PENN[$i]}",$i);
	 ApposClauseAndAttributiveClause("@{$PENN[$i]}",$i);
	 Reason_Adv_Clasuse("@{$PENN[$i]}",$i);
	 Time_ADV_Clause("@{$PENN[$i]}",$i);
	 PreADVC("@{$PENN[$i]}",$i);
	 NONAttributive_Clauses("@{$PENN[$i]}",$i);
	 MNRadvc("@{$PENN[$i]}",$i);
	 Attributive_Clauses("@{$PENN[$i]}",$i);
	# my @tmp = @{$SDeclNumSS[$i]};
	# if($Kinds[$i] == 0)
	# {
		# if(${$SThirdCls[$i]}{'Flag'} == 1)
		# {
				# print "第",$i+1,"句是简单句 : @{$Word[$i]}\n";
				# $result[$i] = "SS";
		# }
		# elsif(${$SThirdCls[$i]}{'Flag'} == 2)
		# {
			# my $ThSFlag = ThSComplex("@{$PENN[$i]}",$i);
			# if($ThSFlag == 2)
			# {
				# print "第",$i+1,"句是XC XXXX: @{$Word[$i]}\n";
				# next;
			# }
			# my $CMFlagNumber = 0;
			# $CMFlagNumber = CMAS("@{$PENN[$i]}",$i);
			# next if ($CMFlagNumber == 2);
			# $CMFlagNumber = CMBS("@{$PENN[$i]}",$i);
			# next if ($CMFlagNumber == 2);
			# $CMFlagNumber = CMCS("@{$PENN[$i]}",$i);
			# next if ($CMFlagNumber == 2);
			# $CMFlagNumber = CMother("@{$PENN[$i]}",$i);
			# next if ($CMFlagNumber == 2);
			# if($CMFlagNumber != 2){$result[$i] = "CMAS";print "第",$i+1,"句是并列句XNONX : @{$Word[$i]}\n";}
		# }
		# elsif(${$SThirdCls[$i]}{'Flag'} == 3)
		# {
			# #CMS($i);
			# my $FlagNumber;
			# #print"\n";
			
			# $FlagNumber = NONAttributive_Clauses("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = PreADVC("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = Time_ADV_Clause("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = Reason_Adv_Clasuse("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = WhereADVC("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = ConditionADVC("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = ConcessionADVC("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = RslADVC("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = When("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = Where("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = SoForCp("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = As("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = SinceIf("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = While("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = SbarCM("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = CmpAdvc("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = MNRadvc("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = SubClause("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = ObjectClause("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = PredicativeClause("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = ApposClauseAndAttributiveClause("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# $FlagNumber = Attributive_Clauses("@{$PENN[$i]}",$i);
			# next if ($FlagNumber == 2);
			# if($FlagNumber != 2){$result[$i] = "NON";print "第",$i+1,"句是复杂句 : @{$Word[$i]}\n";}
			
			
			
			# #print "第",$i+1,"句是复杂句 : @{$Word[$i]}\n";
		# }
		# else
		# {
			# print "不是陈述句\n";
			# $result[$i] = "NON";
		# }
		
	# }
	# elsif($Kinds[$i] == 1)
	# {
		# if(${$tmp[$i]}{'SDeclaNumber'} == 1)
		# {
			# print $i+1," Question Sentence is Simple : @{$Word[$i]}\n";
			# $result[$i] = "SS";
		# }
		# else
		# {
			# print $i+1," Question Sentence Two Subject: @{$Word[$i]}\n";
			# $result[$i] = "SS";
		# }
	# }
	# elsif($Kinds[$i] == 2)
	# {
		# print $i+1," 感叹句 Simple : @{$Word[$i]}\n";
		# $result[$i] = "SS";
	# }
	# elsif($Kinds[$i] == 3)
	# {
		# print "Please use NONSSTOSS.pl\n";
		
	# }
	# else
	# {
		# print $i+1,"Now  Not  Sure :  @{$Word[$i]}\n";$result[$i] = "NON";;
	# }
 }
 # sub SubClause
# {
	# my ($tmpstring,$nums) = @_;
	# my @sbarallword = SbarAllword($tmpstring);
	# my @intro = introducer($tmpstring);
	# my @wOrd = Word();
	# my @worD = @{$wOrd[$nums]};
	# my @pOs = Pos();
	# my @poS = @{$pOs[$nums]};
	# my $sBarnumber = SbarNumber($tmpstring);
	# my $maintruck = MainTruck($tmpstring);
	# $maintruck =~ s/SBAR(.*?)VP.*/$1/;
	# my @maintruck1 = split(/-/,$maintruck);
	# my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	# my ($part1,$part2,$part3);
	# my @sub_num = Sentence_Sub_Locate();
	# my $tmp = qr/^(seem|seemed|happen|happened)$/;
	# my $be = qr/^(are|been|am|is|be|were|was|'s)$/;
	# my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	# my $sub_introducer = qr/\b(that|whether|who|whoever|what|whatever|which|whichever|whom|whose|how|why)\b/i;
	# my $sub_introducerflag;
	# for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	# {
		# if($worD[$i] =~ /$sub_introducer/ or $worD[$i-1] =~ /$sub_introducer/)
		# {
			# $sub_introducerflag = 1;
		# }
	# }
	# #if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
	# if($sub_introducerflag == 1){$n_v[2] = 1;}
	# #if($maintruck !~ /NP/){$n_v[4] = 1;$n_v[12] = 1;}
	# if($sbarallword[0] =~ /$sub_introducer/){$n_v[3] = 1;}
	# if($sbarallword[0] =~ /^(when|where)$/i){$n_v[11] = 1;}
	# if($worD[0] =~ /^it$/i and $worD[1] =~ /$be/ and ($worD[$sbarallword[0]-1] =~ /\b(that|whether|what)\b/i or scalar(@intro) == 0) and $poS[$sbarallword[0]-2] =~ /JJ|VBN|VBD|NN/i){$n_v[11] = 1;$n_v[12] = 1;}
	# if(($worD[$sbarallword[0]-1] =~ /\b(that|whether)\b/i or scalar(@intro) == 0) and $worD[1] =~ /$Vi/i and $worD[0] =~ /^it$/i){$n_v[11] = 1;$n_v[12] = 1;}
	# if($worD[0] =~ /^it$/i and $worD[$sbarallword[0]-3] and ($worD[$sbarallword[0]-1] =~ /\b(that|whether|what)\b/i or scalar(@intro) == 0) and $poS[$sbarallword[0]-2] =~ /JJ|VBN|VBD|NN/i){$n_v[11] = 1;$n_v[12] = 1;}
	# foreach(@n_v){print"$_ OOOOOOOO\n";}
# }


##############
sub introducer
{
	#my ($tmpstring) = @_;
	my $tmpstring = shift;
	my @sbarallchild = SbarAllChildren($tmpstring);
    my @sbarallword = SbarAllword($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	#foreach(@sbarallword){print"$_ KKKK\n";}
	#print"DDD\n";
	my $length = scalar(@sbarallword)-scalar(@sbarsallword);
	my $index;
	if($length > 0.2)
	{
		for(my $i =0; $i <=$#sbarallword; $i++)
		{
			my $brk;
			for(my $j = 0; $j <=$#sbarsallword; $j++)
			{
				if($sbarallword[$i] == $sbarsallword[$j]){$index = $i;$brk = 1;last;}
			}
			if($brk == 1){last;}
		}
	}
	else
	{
		@sbarallword = ();
	}
	if ($index > 0.1){splice(@sbarallword,$index);}
	my @void = ();
	#foreach(@sbarallword){print "$_ CCCC\n";}
	if(scalar(@sbarallword) > 0.1)
	{
		return @sbarallword;
	}
	else
	{
		return @void;
	}
	
}
 ############################################################################################################
 sub del_false_sub
 {
	my ($refarr,$sentence_number,$refaux) = @_;
	my @tmparr = @$refarr;
	my @aux = @$refaux;
	my $binge = qr/^(me|us|her|him|them)$/;
	my @wOrd = Word();
	my @worD = @{$wOrd[$sentence_number]};
	my @pOs = Pos();
	my @poS = @{$pOs[$sentence_number]};
	# foreach(@poS)
	# {
		# print"$_\n";
	# }
	my @store_del_index_locate;
	my @endarr = ();
	#my $RRR1 = scalar(@tmparr);
	#print "$RRR1  ";
	
	if(scalar(@tmparr) > 1.9)
	{
		for(my $i = 0;$i<=$#tmparr;$i++)
		{
			my $str = $tmparr[$i];
			$str =~ s/.*?([0-9])/$1/;
			$str =~ s/\)//g;
			my ($ed,$bg) = split(/,.*?\-/,$str);
			my $xunhuancount = 0;
			for(my $j = $bg-1;$j<$ed;$j++)
			{
				#print $poS[$j]."DDD\n";
				if($poS[$j] =~ /VB.*/)
				{
					$xunhuancount++;
				}	
			}
			if($xunhuancount < 0.9)
			{
				#print "$tmparr[$i] FFFF\n";
				splice(@tmparr,$i,1);
				$i=$i-1;	
			}
		}
		#####
		for(my $i = 0;$i<=$#tmparr;$i++)
		{
			my $str = $tmparr[$i];
			$str =~ s/.*?([0-9])/$1/;
			$str =~ s/\)//g;
			my ($ed,$bg) = split(/,.*?\-/,$str);
			if($worD[$bg-1] =~ /$binge/)
			{
				#print "$tmparr[$i] FFFF\n";
				splice(@tmparr,$i,1);
				$i=$i-1;
			}
		}
		###同主
		for(my $i = 0;$i<=$#tmparr;$i++)
		{
			my $str = $tmparr[$i];
			$str =~ s/.*?([0-9])/$1/;
			$str =~ s/\)//g;
			my ($ed,$bg) = split(/,.*?\-/,$str);
			for(my $j=$i+1;$j<=$#tmparr;$j++)
			{
				my $str1 = $tmparr[$j];
				$str1 =~ s/.*?([0-9])/$1/;
				$str1 =~ s/\)//g;
				my ($ed1,$bg1) = split(/,.*?\-/,$str1);
				if($ed == $ed1 or $bg == $bg1)
				{
					splice(@tmparr,$j,1);
					#print "$tmparr[$j]##+++$bg1+$bg+\n";
					$j--;
					$i--;
					last;
				}
			}
		}
		# my @edarr = ();
		# my @bgarr = ();
		# for(my $i = 0;$i<=$#tmparr;$i++)
		# {
			# my $str = $tmparr[$i];
			# $str =~ s/.*?\-//;
			# $str =~ s/\)//g;
			# $str =~ s/\s+//g;
			
			# my ($ed,$bg) = split(/,.*?\-/,$str);
			# #print "$bg==$ed=OOOO\n";
			# push(@bgarr,$bg);
			# push(@edarr,$ed);
		# }
		# #my $edcount = 0;
		# my %count;
		# #my %count1;
		# my @double_bgarr = grep {$count{$_} == 2}grep{ ++$count{$_} > 1.1 } @bgarr;
		# my @double_edarr = grep {$count{$_} == 2}grep{++$count{$_} > 1.1 } @edarr;
		# #@print scalar(@uniue_bgarr)."UUU\n";
		# #print scalar(@uniue_edarr);
		# my $delcount =  (2*(scalar(@double_bgarr))+ 2*(scalar(@double_edarr)))/2;
		# splice(@tmparr,0,$delcount);
		 for(my $i = 0;$i<=$#tmparr;$i++)
		 {
			 my $str = $tmparr[$i];
			 $str =~ s/.*?([0-9])/$1/;
			 $str =~ s/\)//g;
			 $str =~ s/\s+//g;
			
			 my ($ed,$bg) = split(/,.*?\-/,$str);
			 #print "$bg==$ed=OOOO\n";
			 push(@endarr,$ed);
		 }

		
	 }
	if(scalar(@aux) > 0.3)
	{
		my @edaux;
		my @location;
		my $auxeqsubverbcount = 0;
		 for(my $i = 0;$i<=$#aux;$i++)
		 {
			 my $str = $_;
			 $str =~ s/.*?([0-9])/$1/;
			 $str =~ s/\)//g;
			 my ($ed,$bg) = split(/,.*?\-/,$str);
			 if($worD[$bg-1] !~ /^going$/i and $poS[$ed-1] =~ /VB/)
			 {
				 push(@edaux,$ed);
				 push(@location,$i);
			 }

		 }
		 for(my $i = 0;$i<=$#edaux;$i++)
		 {
			 for(my $j = 0;$j<=$#endarr;$j++)
			 {
				 if($edaux[$i] == $endarr[$j])
				 {
					 #print $edaux[$i];
					 splice(@tmparr,$location[$i],1);
				 }
			 }
		 }
	}
	 
	
	
	return @tmparr;
 }
 
 #一句话真正的主语个数
 sub Subject
 {
	my @TypeDpdt = TypeDpdt();
	#my my @Arr = ();
	my @pos = Pos();
	my @Arr = ();
	my @sbarnumber = Sbarnumber();
	#my $RRR = scalar(@TypeDpdt);
	#print "  $RRR";
	for(my $i = 0;$i<scalar(@TypeDpdt);++$i)
	{
		#print "@{$TypeDpdt[$i]}\n";
		my @tmparr = "@{$TypeDpdt[$i]}" =~ /nsubj.*?\)|nsubjpass.*?\)/g;
		my @aux = "@{$TypeDpdt[$i]}" =~ /aux.*?\)/g;
		@aux = grep{$_ =~ / to\-/} @aux;
		
		if($sbarnumber[$i] < 0.9)
		{
			@tmparr = del_false_sub(\@tmparr,$i,\@aux);
		}
		
		
		my @tmpnumber = "@tmparr" =~ /[0-9]+/g;
		my @wword = "@tmparr" =~ /\(.*?\-|,\s.*?\-/g;
		foreach(@wword)
		{
			s/^\(|\-$|,//g;
		}
		if((scalar(@tmparr)) == 0)
		{
			my %hash = ('word' => undef,'number' => undef,'flag' => 0);
			
			push(@{$Arr[$i]},\%hash);
		}
		else
		{
			for(my $j = 0;$j<=$#tmpnumber ; $j++)
			{
				if(($j&1))
				{
					my %hash = ('word' => $wword[$j],'number' => $tmpnumber[$j],'flag' => 1);
					
					#print $hash{'flag'};
					#print "AAA";
					push(@{$Arr[$i]},\%hash);
					
				}
				else
				{
					my %hash = ('word' => $wword[$j],'number' => $tmpnumber[$j],'flag' => 1);
					#$hash('word' => $wword[$j],'number' => $tmpnumber[$j],'flag' => 1);错误的使用
					#print $hash{'flag'};
					push(@{$Arr[$i]},\%hash);
				}
			}
		}
		
	}
	for(my $i = 0;$i<=$#Arr ; $i++)
	{
		my @tmpArr = @{$Arr[$i]};
		my @tmpPos = @{$pos[$i]};
		for(my $j = 0;$j<=$#tmpArr ; $j++)
		{
			if(${$tmpArr[$j]}{'flag'} == 1)
			{
				${$tmpArr[$j]}{'pos'} = $tmpPos[${$tmpArr[$j]}{'number'}-1];
			}
		}
	}
	@pos = ();
	for(my $i = 0;$i<=$#Arr ; $i++)
	{
		my @tmpArr = @{$Arr[$i]};
		#print scalar(@tmpArr)."  $i  MMM\n";
		my $count = 0;
		my $len = ();
		if(scalar(@tmpArr) == 1)
		{
			$len = 0;
		}
		else
		{
			$len = scalar(@tmpArr)/2;
		}
		my $SDeclaNum = 0;
		for(my $j = 0;$j<=$#tmpArr ; $j++)
		{
			
			if(($j&1) and $j != 1)
			{
				if(${$tmpArr[1]}{'number'} == ${$tmpArr[$j]}{'number'})
				{
					$count++;
				}
			}
				if($count > 0.9)
			{
				$SDeclaNum = scalar(@tmpArr)/2;
				$SDeclaNum -= 1;
				$count = 0;
			}
		}
		if($SDeclaNum > 0)
		{
			${$tmpArr[0]}{'SDeclaNumber'} = $SDeclaNum;
			#print "SSSSSSS\n";
		}
		elsif($len == 0)
		{
			${$tmpArr[0]}{"SDeclaNumber"} = 0;
		}
		else
		{
			${$tmpArr[0]}{"SDeclaNumber"} = $len;
		}
	}
	return @Arr;
 }
 
 

 

 sub Sbarnumber
 {
	my @penn = Penn();
	my @ARR = ();
	for(my $j =0; $j<=$#penn; $j++)
	{
		my @tmp = "@{$penn[$j]}" =~ /\bSBAR\b/g;
		my $number = scalar(@tmp);
		push(@ARR,$number);
	}
	return @ARR;
 }
 
 #NominalClauses();
 sub NominalClauses
 {
	my @penn = Penn();
	my @Monial_Clause = ();
	my @ArrMainTruck = ();
	for(my $i =0; $i<=$#penn; $i++)
	{
		my $MTruck = MainTruck("@{$penn[$i]}");
		my @tmp = split(/\-/,$MTruck);
		push(@ArrMainTruck,\@tmp);
	}
###########################################################################################
	





##############################################################################################	
	
	
	
	
	
	
	
 }
 
 
 
  #Pridate();
 sub Pridate
 {
	my @Qs = Verb();
	for(my $i = 0;$i<=$#Qs;$i++)
	{
		
	}
 }
 
 #StateThrBigCls();
 sub StateThrBigCls
 {
	my @SentKind = SentenceKinds();
	my @SubjectNumberDecl =Subject();
	my @sBarnumber = Sbarnumber();	
	my @Arr = ();
	for(my $i = 0;$i<=$#SubjectNumberDecl;$i++)
	{
		my %hash = ();
		my @tmp = @{$SubjectNumberDecl[$i]};
		if($SentKind[$i] == 0)
		{
			if(${$tmp[0]}{'SDeclaNumber'} == 1)
			{
				if($sBarnumber[$i] == 0)
				{
					$hash{'Simple'} += 1;
					$hash{'Compound'} += 0;
					$hash{'Complex'} += 0;
				}
				else
				{
					$hash{'Simple'} += 0;
					$hash{'Compound'} += 0;
					$hash{'Complex'} += 1;
				}
			}
			else
			{
				if($sBarnumber[$i] == 0)
				{
					$hash{'Simple'} += 0;
					$hash{'Compound'} += 1;
					$hash{'Complex'} += 0;
				}
				else
				{
					$hash{'Simple'} += 0;
					$hash{'Compound'} += 0;
					$hash{'Complex'} += 1;
				}
			}
		}
		elsif($SentKind[$i] == 2)
		{
			# if(${$tmp[0]}{'SDeclaNumber'} == 0)
			# {
				# if($sBarnumber[$i] == 0)
				# {
					# $hash{'Simple'} += 1;
					# $hash{'Compound'} += 0;
					# $hash{'Complex'} += 0;
				# }
				# else
				# {
					# $hash{'Simple'} += 0;
					# $hash{'Compound'} += 0;
					# $hash{'Complex'} += 1;
				# }
			# }
			# else
			# {
				# if($sBarnumber[$i] == 0)
				# {
					# $hash{'Simple'} += 0;
					# $hash{'Compound'} += 1;
					# $hash{'Complex'} += 0;
					# #print "GGGGG\n";
				# }
				# else
				# {
					# $hash{'Simple'} += 0;
					# $hash{'Compound'} += 0;
					# $hash{'Complex'} += 1;
				# }
			# }
		}
		elsif($SentKind[$i] == 3)
		{
			
			if(${$tmp[0]}{'SDeclaNumber'} == 0)
			{
				if($sBarnumber[$i] == 0)
				{
					$hash{'Simple'} += 1;
					$hash{'Compound'} += 0;
					$hash{'Complex'} += 0;
				}
				else
				{
					$hash{'Simple'} += 0;
					$hash{'Compound'} += 0;
					$hash{'Complex'} += 1;
				}
			}
			else
			{
				if($sBarnumber[$i] == 0)
				{
					$hash{'Simple'} += 0;
					$hash{'Compound'} += 1;
					$hash{'Complex'} += 0;
					#print "GGGGG\n";
				}
				else
				{
					$hash{'Simple'} += 0;
					$hash{'Compound'} += 0;
					$hash{'Complex'} += 1;
				}
			}
		}
		else
		{
			$hash{'Simple'} += 0;
			$hash{'Compound'} += 0;
			$hash{'Complex'} += 0;
		}
		push(@Arr,\%hash);
	}
	foreach(@Arr)
	{
		if($$_{'Simple'} > $$_{'Compound'} and $$_{'Simple'} > $$_{'Complex'})
		{
			$$_{'Flag'} = 1;
		}
		elsif($$_{'Compound'} > $$_{'Simple'} and $$_{'Compound'} > $$_{'Complex'})
		{
			$$_{'Flag'} = 2;
		}
		elsif($$_{'Complex'} > $$_{'Simple'} and $$_{'Compound'} < $$_{'Complex'})
		{
			$$_{'Flag'} = 3;
		}
		else
		{
			$$_{'Flag'} = 0;
		}
		#print $$_{'Simple'}>$$_{'Compound'}?($$_{'Compound'}>$$_{'Complex'}?$$_{'Compound'})
		#print "\n";
	}
	return @Arr;
 }
 
 
 
 sub StateCompound
 {
	my @SNumber = Subject();
	
	
	
	
	
 }
 #特殊的句子同位语
 #A warm thought suddenly came to me that I might use the pocket money to buy some flowers for my mother's birthday
 
 ###############################################################并列部分#################################################################
 sub Judge_Compound
 {
	my $text = shift;
	my $and = Compound_apposition($text);
	my $cause = Compound_cause($text);
	my $but = Compound_but($text);
	my $choice = Compound_choise($text);
	my $mix = Compound_mix($text);
	my @arr = ();
	push(@arr,($and,$but,$choice,$cause));
	my $SubIndex = 0;
	my $tmp = 0.3;
	for(my $i=0;$i<=$#arr;$i++)
	{
		if($tmp < $arr[$i])
		{
			$tmp = $arr[$i];
			$SubIndex = $i;
		}
	}
	if($mix == 1 or $mix == 2)
	{
		$mix = "and";
	}
	if($mix == 3)
	{
		$mix = "but";
	}
	my @rtn = ();
	push(@rtn,($SubIndex,$mix));
	#my $cause = Compound_cause();
	#my 
	return \@rtn;
 }
 sub Compound_apposition
{
	my $text = shift;
	my @apposition = ("then");#then 不确定
	#my $appo = qr/and/;
	my @rsl = ();
	foreach(@apposition)
	{
		push(@rsl,&compare($_,$text));
	}
	my $Best = 0;
	for(my $i=0;$i<=$#rsl;$i++)
	{
		if($Best < $rsl[$i])
		{
			$Best = $rsl[$i];
		}
	}
	return $Best;	
}
 ##############################
   sub Compound_cause
{
	my $text = shift;
	my @apposition = ("so",", so","therefore",", for","for");#then 不确定
	#my $appo = qr/and/;
	my @rsl = ();
	foreach(@apposition)
	{
		push(@rsl,&compare($_,$text));
	}
	my $Best = 0;
	for(my $i=0;$i<=$#rsl;$i++)
	{
		if($Best < $rsl[$i])
		{
			$Best = $rsl[$i];
		}
	}
	return $Best;	
}
 
 
  sub Compound_choise
{
	my $text = shift;
	my @apposition = ("otherwise","either or");#then 不确定
	#my $appo = qr/and/;
	my @rsl = ();
	foreach(@apposition)
	{
		push(@rsl,&compare($_,$text));
	}
	my $Best = 0;
	for(my $i=0;$i<=$#rsl;$i++)
	{
		if($Best < $rsl[$i])
		{
			$Best = $rsl[$i];
		}
	}
	return $Best;	
}
 
 
  sub Compound_but
{
	my $text = shift;
	my @apposition = ("yet","still","however","nevertheless");#then 不确定
	#my $appo = qr/and/;
	my @rsl = ();
	foreach(@apposition)
	{
		push(@rsl,&compare($_,$text));
	}
	my $Best = 0;
	for(my $i=0;$i<=$#rsl;$i++)
	{
		if($Best < $rsl[$i])
		{
			$Best = $rsl[$i];
		}
	}
	return $Best;	
}
  sub Compound_mix
{
	my $text = shift;
	my @apposition = ("not only","not but","but");#then 不确定
	#my $appo = qr/and/;
	my @rsl = ();
	my $flag = 0.01;
	foreach(@apposition)
	{
		push(@rsl,&compare($_,$text));
	}
	
	if($rsl[0] == 1)
	{
			$flag = 1;
	}
	elsif($rsl[1] == 1)
	{
		$flag = 2;
	}
	elsif($rsl[2] == 1)
	{
		$flag = 3;
	}
	else
	{
		$flag = 0;
	}
	
	return $flag;	
}
 
 
 #sub 
 
 
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
    $str =~ s/[^A-Za-z0-9,; ]+//g;
	$str =~ s/[,;]/ ,/g;
    # lowercase
    $str = lc $str;
    # return array ref
  return [split ' ', $str];
}
 
#主语从句
sub SubClause
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	$maintruck =~ s/SBAR(.*?)VP.*/$1/;
	my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	#my $tmp = qr/^(seem|seemed|happen|happened)$/;
	my $be = qr/^(are|been|am|is|be|were|was|'s)$/;
	my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $sub_introducer = qr/\b(that|whether|who|whoever|what|whatever|which|whichever|whom|whose|how|why)\b/i;
	my $sub_introducerflag;
	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$sub_introducer/ or $worD[$i-1] =~ /$sub_introducer/)
		{
			$sub_introducerflag = 1;
		}
	}
	#my $word = "@worD";
	if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
	if($sub_introducerflag == 1 and $worD[0] =~ /$sub_introducer/){$n_v[2] = 1;$n_v[3] = 1;}
	if($maintruck !~ /NP/){$n_v[4] = 1;}
	if(scalar(@{$sub_num[$nums]}) == 1) {$n_v[5] = 1;}
	#if($worD[0] =~ /$sub_introducer/){}
	if($worD[0] =~ /^(when|where)$/i and $maintruck !~ /NP/){$n_v[11] = 1;$n_v[12] = 1;}
	if($worD[0] =~ /^it$/i and $worD[1] =~ /$be/ and ($worD[$sbarallword[0]-1] =~ /\b(that|whether|what)\b/i or scalar(@intro) == 0) and $poS[$sbarallword[0]-2] =~ /JJ|VBN|VBD|NN/i){$n_v[11] = 1;$n_v[12] = 1;}
	if(($worD[$sbarallword[0]-1] =~ /\b(that|whether)\b/i or scalar(@intro) == 0) and $worD[1] =~ /$Vi/i and $worD[0] =~ /^it$/i){$n_v[11] = 1;$n_v[12] = 1;}
	if($worD[0] =~ /^it$/i and $worD[$sbarallword[0]-3] and ($worD[$sbarallword[0]-1] =~ /\b(that|whether|what)\b/i or scalar(@intro) == 0) and $poS[$sbarallword[0]-2] =~ /JJ|VBN|VBD|NN/i){$n_v[11] = 1;$n_v[12] = 1;}
	#foreach(@n_v){print"$_ OOOOOOOO\n";}
	print"SubClause ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}
#宾语从句
sub ObjectClause
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	$maintruck =~ s/SBAR(.*?)VP.*/$1/;
	my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my $nonattr_intro = qr/\b(now_that|in_that|so_that|as_if|as_though)\b/i;
	my $o_introducer = qr/\b(that|whether|what|who|which|whose|how|why|whom|if|whose|whoever|whomever|whosever|whatever|whichever|why|how|however|when|where|whenever|wherever)\b/;
	my $o_introducerflag;
	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$o_introducer/)
		{
			$o_introducerflag = 1;
		}
	}
	for(my $i = $intro[0]-2;$i<+$intro[scalar(@intro)-1];$i++)
	{
		my $tmp = "$worD[$i]"."_"."$worD[$i+1]";
		if($tmp =~ /\b$nonattr_intro\b/i)
		{
			$o_introducerflag = 0;
		}
	}
	if(scalar(@intro) == 0 and $sBarnumber > 0.1){$o_introducerflag = 1;}
	my $Non_OC_Verb = qr/^(provided|suppose|supposing|providing|seeing|given|considering|granted|granting|admitting)$/i;
	my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $Ving = qr/^(agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my $special_verb = qr/^(leave|put|discuss|doubt|left|discussed|doubted).s$/;
	my $special_verbing = qr/^(leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my $Link_appos = qr/^(news|demand|impression|truth|idea|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)s?$/;
	my $Link_Verbing = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)ing$/;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked
|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mail
ed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|pre
pared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|stea
l|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
#my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sounds|taste|smell|remain|keep|stay|become|get|grow|turn|go|fall|prove|was|were|felt||seemed|looked|appeared|sounded|tasted|smelled|remained|kept|stayed|became|got|grew|turned|gone|fell|proved)s?$/;
	my $adjObClauseWord = qr/^(sure|certain|glad|please|happy|sorry|afraid|satisfied|surprised)$/;
	
	
	
	#########################
	
	if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
	if($o_introducerflag == 1 and $worD[$sbarallword[0]-1] !~ /$Link_Verb|$Non_OC_Verb|$special_verb/ and $poS[$sbarallword[0]-1] =~ /VB/){$n_v[2] = 1;$n_v[3] = 1;}
	my $adj_o_C;
	if($worD[0] !~ /\bit\b/i){for(my $i=$sbarallword[0];$i>=$sbarallword[0]-5;$i--){if($worD[$i] =~ /$Link_Verb/i){for(my $j=$i+1;$j<$sbarallword[0];$j++){if($worD[$j] =~ /$adjObClauseWord/i){$adj_o_C =1;}}}}}
	if($adj_o_C == 1){$n_v[11] = 1;$n_v[12] = 1;}
	my $VB_it;
	for(my $i=$sbarallword[0];$i>=$sbarallword[0]-5;$i--){if($worD[$i]=~/\bit\b/ and $poS[$i-1] =~ /^VB/ and $o_introducerflag == 1) {for(my $j=$i+1;$j<=$sbarallword[0];$j++){if($poS[$j] !~ /VB/){$VB_it = 1;}}}}
	if($VB_it == 1){$n_v[11] = 1;$n_v[12] = 1;}
	my $VB_Dbl_Ob;
	for(my $i=$sbarallword[0]-1;$i>=$sbarallword[0]-5;$i--){if($worD[$i]=~/$double_object/ and $o_introducerflag == 1) {for(my $j=$i+1;$j<$sbarallword[0];$j++){if($poS[$j] =~ /NN|PRP|DT/){$VB_Dbl_Ob = 1;}}}}
	if($VB_Dbl_Ob == 1 and $o_introducerflag == 1){$n_v[11] = 1;$n_v[12] = 1;}
	my $VB_Prop;
	for(my $i=$sbarallword[0]-1;$i>=$sbarallword[0]-4;$i--){if($worD[$i]=~/$double_object/ and $o_introducerflag == 1) {for(my $j=$i+1;$j<$sbarallword[0];$j++){if($poS[$j] =~ /^RP|^IN/){$VB_Prop = 1;}}}}
	if($VB_Prop == 1 and $o_introducerflag == 1){$n_v[11] = 1;$n_v[12] = 1;}
	my $spcl_BEB;
	for(my $i=1;$i<=$sbarallword[0];$i++){if($worD[$i]=~/\b(but|except|besides)\b/ and $worD[$i+1] =~ /\bthat\b/i and $o_introducerflag == 1) {$spcl_BEB = 1;}}
	if($VB_Prop == 1 and $o_introducerflag == 1){$n_v[11] = 1;$n_v[12] = 2;}
	print"ObjectClause ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}
#表语从句
  
sub PredicativeClause
{
	
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	$maintruck =~ s/SBAR(.*?)VP.*/$1/;
	my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|appear|sound|stay|become|grow|was|were|felt||seemed|looked|appeared|sounded|stayed|became|grew)s?$/;
	my $prd = qr/\b(that|whether|who|whoever|whom|whose|what|whatever|which|whichever|when|where|how|why|as_if|as_though|when|where)\b/i;
	my $prd_introducerflag;
	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	{
		my $tmp_indcer = "$worD[$i]"."_"."$worD[$i+1]";
		if($worD[$i] =~ /$prd/ || $tmp_indcer =~ /$prd/)
		{
			$prd_introducerflag = 1;
		}
	}
	if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
	my $xian_X_C;
	if(($poS[$sbarallword[0]-2] =~ /RB/ and $worD[$sbarallword[0]-3] =~ /$Link_Verb/) or ($worD[$sbarallword[0]-2] =~ /$Link_Verb/)){$xian_X_C = 1;}
	if($prd_introducerflag ==1 and $xian_X_C == 1){$n_v[2] = 1;	$n_v[3] = 1;}
	print"PredicativeClause ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}
#同位语从句
sub ApposClauseAndAttributiveClause
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my $appos_introducer = qr/\b(that|whether|what|which|who|how|why|when|where)\b/i;
	#my $nonattr_intro = qr/\b(now_that|in_that|so_that|as_if|as_though)\b/i;
	my $Link_appos = qr/^(statement|desire|order|possibility|plan|doubt|rumor|news|eagerness|question|demand|impression|truth|idea|words||resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|problem|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $appos_introducerflag;
	
	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$appos_introducer/)
		{
			$appos_introducerflag = 1;
		}
	}
	######
	#print "$worD[@{$sub_num[$nums]}[0]-1] HHHHHHHHH\n";
	if($worD[@{$sub_num[$nums]}[0]-1] =~ /$Link_appos/ and $appos_introducerflag == 1){$n_v[11] = 1;	$n_v[12] = 1;}
	if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
	my $appos_intro;
	if($worD[$sbarallword[0]-2] =~ /$Link_appos/){$appos_intro=1;}
	if($appos_intro ==1 and $appos_introducerflag == 1){$n_v[2] = 1;$n_v[3] = 1;$n_v[4]=1;}
	print"ApposClauseAndAttributiveClause ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}
#定语从句
sub Attributive_Clauses
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @pub_num = Sentence_PriVerb_Locate();
	my @sub_num = Sentence_Sub_Locate();
	my @sbarsschild = SbarSChild($tmpstring);
	my $attr_intro = qr/\b(that|how|whose|whom|who|which|why)\b/i;
	my $nonattr_intro = qr/\b(now_that|in_that|so_that|as_if|as_though)\b/i;
	my $attr_introflag;
	my $spcl_attr_introflag;
	my @dpdt = TypeDpdt();
	my $prop_bfore_xxc;
	my @acl = "@{$dpdt[$nums]}" =~ /acl:relcl\(.*?\)/g;
	my ($wheN,$wherE,$aS);
	for(my $i = $intro[0]-2;$i<$intro[scalar(@intro)-1];$i++)
	{
		my $tmp_nonattr_intro = "$worD[$i]"."$worD[$i+1]";
		if($worD[$i] =~ /$attr_intro/)
		{
			$attr_introflag = 1;
		}
		if($tmp_nonattr_intro =~ /$nonattr_intro/){$spcl_attr_introflag = 1;}
		if($worD[$i] =~ /\b(when)\b/){$wheN = 1;}
		if($worD[$i] =~ /\b(where)\b/){$wherE = 1;}
		if($worD[$i] =~ /\bas\b/i){$aS = 1;}
	}
	my $comma;
	for(my $i = $sbarallword[0] - 4;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] !~ /,/){$comma = 1;}
	}
	if(scalar(@intro) == 0 and $sBarnumber > 0.1){$attr_introflag = 1;}
	my $No_Sbar_NP;
	foreach(@sbarsschild){if($_ !~ /^NP/){$No_Sbar_NP = 1}}
	
	#####as
	my $Xatt_featre;
	for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++)
	{
		if(($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bsame\b/) or ($worD[$i] =~ /\b(as|such)\b/ and $poS[$sbarallword[0]-2] =~ /^(NN|DT|PRP)/)){$Xatt_featre = 1;}
	}
	my $place_noun = qr/(camp|building|school|bank|factory|classroom|station|mall|airport|cinema|hospital|river|lake|hotel|market|square|plaza|Forum|piazza|place|palace|palace|alcazar|city|country|countyrside|village|area|town|mountain|province|municipality|region|desert|sea|forest|house|home|university|school|street)s?/i;
	my $time_noun = qr/(year|month|day|hour|minute|second|century|ago|period|today|stage|tonight|morning|time|afternoon|noon|midday|noonday|afternoon|forenoon|moment|dawn|dark|night|nightfall|present|sunrise|past|now|future)s?/i;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked
|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mail
ed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|pre
pared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|stea
l|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
	my $Link_appos = qr/^(news|eagerness|question|demand|impression|truth|idea|words|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	###################
	if($comma == 1)
	{
		if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
		if($spcl_attr_introflag != 1 and $attr_introflag == 1 and $worD[$sbarallword[0]-2] !~ /$Link_appos/ and $poS[$sbarallword[0]-2] =~ /^(NN|PRP|DT)/ and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/){$n_v[2] = 1;$n_v[3] = 1;$n_v[4] = 1;}
		if($spcl_attr_introflag != 1 and $attr_introflag == 1 and $No_Sbar_NP == 1){$n_v[4] = 1;$n_v[5] =1;}
		if($worD[$sbarallword[0]-2] !~ /$Link_appos/ and scalar(@acl) > 0.1 and $poS[$sbarallword[0]-2] =~ /^(NN|PRP|DT)/ and $attr_introflag == 1 and $spcl_attr_introflag != 1){$n_v[4] = 1; $n_v[5] = 1;}
		if($worD[$sbarallword[0]-2] !~ /$Link_appos/ and scalar(@acl) > 0.1 and $aS == 1 and $attr_introflag == 1 and $spcl_attr_introflag != 1){$n_v[4] = 1; $n_v[5] = 1;}
		if($wheN == 1 and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/ and $worD[$sbarallword[0]-2] =~ /$time_noun/){$n_v[11] = 1;$n_v[12] = 1;}
		if($wheN == 1 and $poS[$sbarallword[0]-2] =~ /^(NN|PRP|DT)/ and $worD[$sbarallword[0]-2] !~ /$Link_appos/ and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/ and  scalar(@acl) > 0.1){$n_v[11] = 1;$n_v[12] = 1;}
		if($wheN == 1 and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/ and $worD[$sbarallword[0]-2] =~ /$time_noun/ and scalar(@acl) > 0.1){$n_v[11] = 1;$n_v[12] = 1;$n_v[13] = 1;}
		if($wherE == 1 and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/ and $worD[$sbarallword[0]-2] =~ /$place_noun/){$n_v[11] = 1;$n_v[12] = 1;}
		if($wherE == 1 and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/ and $worD[$sbarallword[0]-2] =~ /$place_noun/ and scalar(@acl) > 0.1){$n_v[11] = 1;$n_v[12] = 1;$n_v[13] = 1;}
		if($wherE == 1 and $poS[$sbarallword[0]-2] =~ /^(NN|PRP|DT)/ and $worD[$sbarallword[0]-2] !~ /$Link_appos/ and $worD[@{$pub_num[$nums]}[0]-1] !~ /$double_object/ and scalar(@acl) > 0.1){$n_v[11] = 1;$n_v[12] = 1;}
		if($aS == 1 and $Xatt_featre == 1) {$n_v[11] = 1;$n_v[12] = 1;}
	}
	print"Attributive_Clauses ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}

###########################################################################
####################################
sub MNRadvc
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my $MD = qr/^(can|may|will|could|might|would|should)$/i;
	my $prd = qr/\b(as_if|as_though)\b/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|appear|sound|stay|become|grow|was|were|felt||seemed|looked|appeared|sounded|stayed|became|grew)s?$/;
	my $prd_introducerflag;
	for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++)
	{
		my $tmp_indcer = "$worD[$i]"."_"."$worD[$i+1]";
		if($tmp_indcer =~ /\b$prd\b/i)
		{
			$prd_introducerflag = 1;
		}
	}
	my @spcl_loc = @{$sub_num[$nums]};
	my $the_way;
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bway\b/){$the_way = 1;}}}
	if($the_way == 1) {$n_v[11]=1;$n_v[12]=1;}
	if($sbarallword[0] > 2.1 and $worD[$sbarallword[0]-1] =~ /\bas\b/i){$n_v[11]=1;}
	if($prd_introducerflag == 1 and $worD[$sbarallword[0]-2] !~ /\b$Link_Verb\b/) {$n_v[2]=1;$n_v[3]=1;}
	print"MNRadvc ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
	
}
 
#######################################################################
 
 #非定语从句
sub NONAttributive_Clauses
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @pub_num = Sentence_PriVerb_Locate();
	my @sub_num = Sentence_Sub_Locate();
	my @sbarsschild = SbarSChild($tmpstring);
	my $attr_intro = qr/\b(how|whose|whom|who|which)\b/i;
	my $place_noun = qr/(camp|building|school|bank|factory|classroom|station|mall|airport|cinema|hospital|river|lake|hotel|market|square|plaza|Forum|piazza|place|palace|palace|alcazar|city|country|countyrside|village|area|town|mountain|province|municipality|region|desert|sea|forest|house|home|university|school|street)s?/i;
	my $time_noun = qr/(year|month|day|hour|minute|second|century|ago|period|today|stage|tonight|morning|time|afternoon|noon|midday|noonday|afternoon|forenoon|moment|dawn|dark|night|nightfall|present|sunrise|past|now|future)s?/i;
	my $as_vb = qr/\b(know|known|see|saw|say|said|expect|expected|imagine|imagined|hope|hoped|believe|believed|announce|announced|suggest|suggested|report|reported)?s\b/i;
	my $attr_introflag;
	my $spcl_attr_introflag;
	my @dpdt = TypeDpdt();
	my $prop_bfore_xxc;
	my $as_vb_loc;
	my @verb = @{$pub_num[$nums]};
	for(my $i = 0;$i<=$#verb;$i++){if($sbarallword[0] < $verb[$i] and $verb[$i] < $sbarallword[scalar[@sbarallword]-1]){$as_vb_loc = $verb[$i]}}
	my @acl = "@{$dpdt[$nums]}" =~ /acl:relcl\(.*?\)/g;
	my ($wheN,$wherE,$aS);
	for(my $i = $intro[0]-2;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$attr_intro/)
		{
			$attr_introflag = 1;
		}
		if($worD[$i] =~ /\b(when)\b/){$wheN = 1;}
		if($worD[$i] =~ /\b(where)\b/){$wherE = 1;}
		if($worD[$i] =~ /\bas\b/i){$aS = 1;}
	}
	my $comma;
	my $loc_xxc;
	for(my $i = $sbarallword[0] - 4;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /,/){$comma = 1;$loc_xxc = $i-1;}
	}
	
	if(scalar(@intro) == 0 and $sBarnumber > 0.1){$attr_introflag = 1;}
	if($comma == 1 and $attr_introflag == 1){$n_v[2] = 1;}
	my $No_Sbar_NP;
	foreach(@sbarsschild){if($_ !~ /^NP/){$No_Sbar_NP = 1}}
	#####as
	my $Xatt_featre;
	for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++)
	{
		if(($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bsame\b/) or ($worD[$i] =~ /\b(as|such)\b/ and $poS[$sbarallword[0]-2] =~ /^(NN|DT|PRP)/)){$Xatt_featre = 1;}
	}
	my $Xxc;
	for(my $i = $sbarallword[0] - 4;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /,/ and $poS[$i-1] =~ /^(NN|DT|PRP)/){$Xxc= 1;}
	}
	my $prop_bfore_ydc;
	for(my $i = $intro[0]-2;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$attr_intro/ and $poS[$i-1] =~ /^(IN|PR)$/)
		{
			$prop_bfore_ydc = 1;
		}
	}
	if($comma == 1)
	{
		if($sBarnumber > 0.1 and scalar(@{$sub_num[$nums]}) > 0.1){$n_v[0] = 0;	$n_v[1] = 0;}
		if($attr_introflag == 1 and $Xxc == 1) {$n_v[2] = 1;$n_v[3] = 1;;$n_v[4]=1;}
		if($attr_introflag == 1 and $Xxc == 1 and $No_Sbar_NP == 1) {$n_v[2] = 1;$n_v[3] = 1;;$n_v[4]=1;$n_v[5] = 1}
		if($prop_bfore_ydc == 1 and $Xxc == 1) {$n_v[2] = 1;$n_v[3] = 1;;$n_v[4]=1;$n_v[5] = 1;}
		if($wheN == 1 and $worD[$loc_xxc] =~ /$time_noun/i){$n_v[2] = 1;$n_v[3] = 1;}
		if($wherE == 1 and $worD[$loc_xxc] =~ /$place_noun/i){$n_v[2] = 1;$n_v[3] = 1;}
		if($aS == 1 and $No_Sbar_NP == 1){$n_v[2] = 1;$n_v[3] = 1;$n_v[4] = 1;}
		if($aS == 1 and ($worD[$as_vb_loc - 1] =~ /$as_vb/ or $poS[$as_vb_loc - 1] !~ /^VB/)){$n_v[2] = 1;$n_v[3] = 1;$n_v[4] = 1;}
	}
	print"NONAttributive_Clauses ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}
##############################################################################################################
 
 #目的状语从句
######################################################################################################################################################################
 sub PreADVC
 {
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	my $MD = qr/^(can|may|will|could|might|would|should)$/i;
	my $prd = qr/(lest|so_that)/i;
	my $prd_introducerflag;
	my $prd_so_that;
	for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++)
	{
		my $tmp_indcer = "$worD[$i]"."_"."$worD[$i+1]";
		if($worD[$i] =~ /\b$prd\b/i)
		{
			$prd_introducerflag = 1;
		}
		if($tmp_indcer =~ /\b$prd\b/i and $worD[$i-1] !~ /,/)
		{
			$prd_so_that = 1;
		}
	}
	my $spcl_cls;
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bfor\b/ and $worD[$i+1] =~ /\bfear\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bhope\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bto\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bend\b/){$spcl_cls = 1;}}}
	if($spcl_cls == 1){$n_v[11]=1;$n_v[12]=1;}
	if($prd_introducerflag == 1 or $prd_so_that == 1){$n_v[2]=1;$n_v[3] = 1;}
	for(my $i = $sbarallword[0];$i<=$sbarallword[scalar(@sbarallword)-1];$i++){if($worD[$i] =~ /\b$MD\b/ and $prd_so_that == 1){$n_v[2]=1;$n_v[3] = 1;$n_v[4] = 1;}}
	my $in_case;
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bin\b/ and $worD[$i+1] =~ /\bcase\b/){$in_case = 1;}}}
	if($in_case == 1){$n_v[2] = 1;$n_v[3] = 1;}
	print"PreADVC ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
 }
#########################################################################################################################################
 
 
 #时间状语从句
 sub Time_ADV_Clause
 {
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my $time_idc = qr/^(before|after|till|until)$/i;
	my $tm_idc_flag;
	for(my $i = $intro[0]-2;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\b$time_idc\b/){$tm_idc_flag = 1;}}
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	my $as_soon;
	if($worD[$sbarallword[0]-1] =~ /\bwhile\b/i){$n_v[2]=1;}
	if($worD[$sbarallword[0]-1] =~ /\bsince\b/i and $worD[$spcl_loc[0]-1] =~ /\bit\b/i){$n_v[12]=1;$n_v[11]=1;}
	if($worD[$sbarallword[0]-1] =~ /\bsince\b/i){$n_v[2]=1;for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(has|had|have)\b/ and "@[$i+1 .. $spcl_loc[1]]" =~ /VB/){$n_v[3]=1;}}}
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bas\b/ and $worD[$i+1] =~ /\bsoon\b/ and $worD[$i+2] =~ /\bas\b/){$as_soon = 1;}}}
	if($as_soon == 1){$n_v[11]=1;$n_v[12]=1;}
	if($tm_idc_flag == 1){$n_v[2]=1;$n_v[3]=1;}
	my $sooner_than;
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bsooner\b/){$sooner_than = 1;}if($sooner_than == 1 and $worD[$i] =~ /\bthan\b/) {$sooner_than++;}}}
	if($sooner_than == 2){$n_v[11] = 1;$n_v[12] = 1;}
	my ($the_two,$by_the_time,$immediately,$the_thr,$evey_time);
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(moment|minute|insant|second)\b/ and ($i <= $spcl_loc[0] or ($spcl_loc[0] < ($i) and ($i) < $spcl_loc[1]))){$the_two = 1;}if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(first|last|next)\b/ and $worD[$i+2] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$the_thr = 1;}if($worD[$i] =~ /\b(every|each)\b/i and $worD[$i+1] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$evey_time = 1;}if($worD[$i] =~ /\bby\b/i and $worD[$i+1] =~ /\b(the)\b/ and $worD[$i+2] =~ /\b(time)\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$by_the_time = 1;}if($worD[$i] =~ /\b(immediately|directly)\b/i and (($i) < $spcl_loc[0] and ($i+1) < $spcl_loc[1])){$immediately = 1;}}}
	if($the_two==1 || $by_the_time==1 || $immediately==1 || $the_thr==1 || $evey_time==1){$n_v[11] = 1;$n_v[12] = 1;}
	if($worD[0] =~ /\b(when|whenever|while)\b/ || ($worD[$sbarallword[0]-1] =~ /\b(when|whenever|while)\b/ and $worD[$sbarallword[0]-2] =~ /,/)){$n_v[2] = 1;}
	print"Time_ADV_Clause ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
 }
 
#######################################################################################################################################
sub Reason_Adv_Clasuse
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	if($worD[$sbarallword[0]-1] =~ /\bsince\b/i){$n_v[2]=1;if($worD[0] =~ /since/){$n_v[4]=1;}for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] !~ /\b(has|had|have)\b/ and "@[$i+1 .. $spcl_loc[1]]" !~ /VB/){$n_v[3]=1;}}}
	if($worD[$sbarallword[0]-1] =~ /\bthat\b/ and $worD[$sbarallword[0]-2] =~ /\b(Seeing|considering|now|given)\b/i){$n_v[11] =1;$n_v[12] = 1;}
	if($worD[$sbarallword[0]-1] =~ /\because\b/i){$n_v[2] = 1;$n_v[3] = 1;}
	print"Reason_Adv_Clasuse ";foreach(@n_v){print "$_ ";}print "\n\n";
	return @n_v;
}
######################################################################################
 sub WhereADVC
 {
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	if($worD[0] =~ /\b(where|anywhere|everywhere|wherever)\b/ || ($worD[$sbarallword[0]-1] =~ /\b(where|anywhere|everywhere|wherever)\b/ and $worD[$sbarallword[0]-2] =~ /,/)){$n_v[2] = 1;}
	return @n_v;
 }
#############################################################################################################
sub ConditionADVC
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	#my @maintruck1 = split(/-/,$maintruck);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	if($worD[$sbarallword[0]-1] =~ /\bif\b/i and scalar(@intro) == 1){$n_v[2] = 1;$n_v[3] = 1;}
	if($worD[$sbarallword[0]-1] =~ /\bunless\b/i){$n_v[2] = 1;$n_v[3] = 1;}
	my $prvd;
	if($worD[$sbarallword[0]-1] =~ /\bwhile\b/i){$n_v[2]=1;}
	#if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\bassuming\b/i){$n_v[11] =1;$n_v[12]=1;}}for(my $i = $spcl_loc[1]-3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bassuming\b/i){$n_v[11] =1;$n_v[12]=1;}}}
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(assuming|providing|provided|suppose|supposing)\b/i){$prvd = 1;}}for(my $i = $spcl_loc[1] - 3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(assuming|providing|provided|suppose|supposing)\b/i){$prvd = 1;}}}
	if($prvd == 1){$n_v[11] = 1;$n_v[12] = 1;}	
	return @n_v;
}
#######################################################################################让步状语从句
sub ConcessionADVC
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	my $idc_Css = qr/\b(though|although)\b/i;
	my $qstword = qr/(what|who|which|whose|when|where|how|why|whose|whoever|whomever|whosever|whatever|whichever|why|how|however)/i;
	my $qstwordever = qr/(whoever|whomever|whosever|whatever|whichever|however)/i;
	my ($Css,$as_though,$even_though,$ass);
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++){my $tmp = "$worD[$i]"."_"."$worD[$i+1]";if($worD[$i] =~ /\b$idc_Css\b/){$Css = 1;} if($tmp !~ /\bas_though\b/i){$as_though=1;}if($tmp =~ /\b(even_if|even_though)\b/i){$even_though=1;}if($ass =~ /\bas\b/ and $i > 0.9){$ass =1;}}
	if($worD[$sbarallword[0]-1] =~ /\bwhile\b/i){$n_v[2]=1;}
	if($even_though == 1){$n_v[2]=1;$n_v[3]=1;}
	if($as_though==1 and $Css==1){$n_v[2]=1;$n_v[3]=1;}
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$n_v[11] =1;$n_v[12]=1;}}for(my $i = $spcl_loc[1]-3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$n_v[11] =1;$n_v[12]=1;}}}
	for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bmatter\b/ and $worD[$i+2] =~ /\b$qstword\b/){$n_v[2]=1;$n_v[3]=1;$n_v[4]=1;}}
	for(my $i = $intro[scalar(@intro)-1];$i<=$sbarallword[scalar(@sbarallword)-1];$i++){if($worD[$i] =~ /\bwhether\b/i){for(my $j = $i;$j<=$sbarallword[scalar(@sbarallword)-1];$j++){if($worD[$j] =~ /\bor\b/i){$n_v[11]=1;$n_v[12]=1;}}}}
	for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\b$qstwordever\b/i and $i < 2.1){$n_v[2]=1;$n_v[3]=1;}if($worD[$i] =~ /\b$qstwordever\b/i and $worD[$i-1] =~ /,|;/){$n_v[2]=1;$n_v[3]=1;}}
	if(($poS[0] =~ /^(NN|VB|JJ|RB)/ or ($poS[1] =~ /^(NN|VB|JJ|RB)/ and $worD[0] =~ /\bas\b/i)) and $ass ==1 and $sbarallword[0] < 5){$n_v[11] =1;$n_v[12] =1;$n_v[13] =1;}
	return @n_v;
}
############################################
sub RslADVC
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my $sBarnumber = SbarNumber($tmpstring);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	my $prd_so_that;
	my $idc_loc;
	for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++)
	{
		my $tmp_indcer = "$worD[$i]"."_"."$worD[$i+1]";
		if($tmp_indcer =~ /\bso_that\b/i and $worD[$i-1] =~ /,/)
		{
			$prd_so_that = 1;
		}
		if($worD[$i] = ~ /\bthat\b/i){$idc_loc = $i;}
	}
	for(my $i = 0;$i<=$idc_loc;$i++){if($worD[$i] =~ /\bso\b/ and $poS[$i+1] =~ /^(JJ|RB)/){$n_v[11] =1;$n_v[12] =1;}if($worD[$i] =~ /\bsuch\b/ and ($poS[$i+1] =~ /^JJ/ or $poS[$i+2] =~ /^JJ/)){$n_v[11] =1;$n_v[12] =1;}}
	return @n_v;
}
#####################################################################################

######################################################################################
=pod1
sub ThSComplex
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @sub_location = Sentence_Sub_Locate();
	if($maintrck[0] eq "S" and $maintrck[1] eq ",")
	{
		#print"@{$Word[$nums]}  $nums\n\n";
		
		#in case
		if($worD[$thsallword[0]-1] =~ /^(in)$/i and $worD[$thsallword[0]] =~ /^(case)$/)
		
	}
	
		}
	}
	if($worD[0] =~ /anywhere|everywhere|wherever/i)
	{
		print"Ths	地点状语从句";
		$result[$nums] = "PADVC";
		print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
		return 2;
	}
	
	
	
}






=cut;
#######################################################################################
#Out_Result();




#####################################################While


######################################################################################################



#############################################################################


#######################################################################################
		
#######################################################


#############################################################################################
sub CmpAdvc
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\bthan\b/i){$n_v[2];}}
	for(my $i = 1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$sbarallword[0]-1] =~ /\bas\b/ and $worD[$i] =~ /\bas\b/ and $poS[$i+1] =~ /(RB|JJ)/){$n_v[2]=1;$n_v[11] = 1;}}
	if($sBarnumber < 1){for(my $i = 0;$i<$spcl_loc[0];$i++){if($poS[$i] =~ /JJ(R)/){for(my $j = $spcl_loc[0];$j<$spcl_loc[1];$j++){if($poS[$j] =~ /^JJ(R)/){$n_v[11]=1;$n_v[12]=1;}}}}}
	return @n_v;
	
}




#########################################################################################
my $datapath;
my $dataFpath;
my $jarpath;
my $modelpath;
sub wanted 
{
		if ($_ =~ /^data$/i and -d $_)
		{
			$datapath = $File::Find::name;
			$dataFpath = $File::Find::dir;
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


OutputRsl();
sub OutputRsl
{
	my $dirpath = getcwd();
	my $count_sprit;
	my @wOrd = Word();
	# foreach(@wOrd)
	# {
		# print;
		# print"\n\n";
	# }
	#my @worD = @{$wOrd[$nums]};
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
	if((-d "$dataFpath/Result"))
	{
		#print"FFFFF\n";
	}
	else
	{mkdir "$dataFpath/Result";}
	
	my $file_handle;
	my $ref_handle;
	my $Rsl_handle;
	my $AAAA = "AAAA";
	#my $count = 0;
	#my @Ref;
	#print "$datapath $dataFpath HHHHHHHHHHH\n";
	#open($ref_handle,"< $datapath/Ref_Test") || die "can not open vvvvv $datapath\n";
	#open($file_handle,"> $dataFpath/Result/HypRSl") || die "can not open  can not open \n";
	open($Rsl_handle,"> $dataFpath/Result/RefRsl.rsl") || die "can not open it\n";
	# while(<$ref_handle>)
	# {
		# chomp;
		# s/AAAA.*//;
		# s/\s+//g;
		# push(@Ref,$_);
	# }
	for(my $i = 0;$i<=$#wOrd;$i++)
	{
		$result[$i] =~ s/\s+//g;
		#my $sttr = @{$wOrd[$i]};
		#print $file_handle "$Ref[$i] $AAAA";
		#print $file_handle "@{$wOrd[$i]}\n";
		print $Rsl_handle "$result[$i] $AAAA @{$wOrd[$i]}\n";
		#$count++;
	}
	#close($file_handle);
}


sub Out_Result
{
	my @wOrd = Word();
	my $local_out_direc = getcwd();
	my ($dirnam1, $outNam2) = $local_out_direc =~ /(.*)\/(.*)/;
	my $FilHandle;
	#print "$dirnam1\n";
	if(-e "$dirnam1/Bin" or -e "$dirnam1/bin")
	{
		mkdir "$dirnam1/Result";
		open($FilHandle,"> $dirnam1/Result/RSL") || die "can't open it 1\n";
	}
	elsif(-e "$local_out_direc/Bin" or -e "$local_out_direc/bin")
	{
		mkdir "$local_out_direc/Result";
		open($FilHandle,"> $local_out_direc/Result/RSL") || die "can't open it 2\n";
	}
	else
	{
		print "can not fint dir\n";
	}
	
	for(my $i = 0;$i<$#wOrd;$i++)
	{
		#print"$result[$i] @{$wOrd[$i]}\n";
		my $strarr = "@{$wOrd[$i]}";
		my $link = join("AAAA",$result[$i],$strarr);
		if(defined($FilHandle))
		{print $FilHandle "$link\n";}
	}
}
########################################################################
sub CMAS
{
	my ($tmpstring,$nums) = @_;
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $sBarnumber = SbarNumber($tmpstring);
	my @sub_num = Sentence_Sub_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	my @thccall = ThCCAllWord($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my $cc= 0;
	my @n_v = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	#foreach(@maintrck){print"$_\n";}
	grep{$cc =1 if /^CC$/} @maintrck;
	#foreach(@thfstsallword){print"$_ PPPP\n";}
	#print "$worD[$thfstsallword[scalar(@thfstsallword)-1]-1]  LLL\n";
	if($sBarnumber < 0.9 and scalar(@sub_num) > 1.9){$n_v[1] = 1;}
	for(my $i = $spcl_loc[1]-3;$i<$spcl_loc[1];$i++){if($worD[$i] =~ /(,|;|and)/i){$worD[2] =1;}}
	for(my $i = 0;$i<$spcl_loc[1];$i++){if($worD[$i] =~ /^(not|'t)$/i and $worD[$i+1] =~ /\bonly\b/){for(my $j = $spcl_loc[1]-2;$j<$spcl_loc[1];$j++){if($worD[$j] =~ /\bbut\b/i){$worD[2] =1;$worD[3]=1;$worD[4]=1;}}}}
	#for(my $i = 0;$i<$spcl_loc[1];$i++){if()}
}
sub CMBS
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my @thfstsallword = ThSAllWord($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @thccall = ThCCAllWord($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my $cc= 0;
	#foreach(@maintrck){print"$_\n";}
	grep{$cc =1 if /^CC$/} @maintrck;
	#foreach(@thfstsallword){print"$_ PPPP\n";}
	#print "$worD[$thfstsallword[scalar(@thfstsallword)-1]-2]  LLL\n";
	if($cc == 1)
	{
		if($worD[$thccall[0]-1] =~ /yet/i and $poS[$thccall[0]] ne $poS[$thccall[0]-2])
		{
			print "并列句转折  yet";
			$result[$nums] = "CMBS";
			print "第",$nums+1,"句是并列句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$thccall[0]-1] =~ /but/i)
		{
			for(my $i = 0;$i<=$thccall[0];$i++)
			{
				if($worD[$i] !~ /^(not|'t)$/i and $worD[$i+1] !~ /^(only)$/i)
				{print "并列句转折  but";
				$result[$nums] = "CMBS";
				print "第",$nums+1,"句是并列句 : @{$Word[$nums]}\n";
				return 2;}
			}
		}
	}
}

sub CMCS
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	#print"$tmpstring \n\n";
	my @thfstsallword = ThSAllWord($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @thccall = ThCCAllWord($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my $cc= 0;
	#foreach(@maintrck){print"DDD $_\n";}
	#foreach(@thccall){print"$_ LLLL\n";}
	grep{$cc =1 if /^CC$/} @maintrck;
	#foreach(@thfstsallword)
	#{print "$_ PPPP\n";}
	#print "$worD[$thfstsallword[scalar(@thfstsallword)-1]-2]  LLL\n";
	if($cc == 1)
	{
		if($worD[$thccall[0]-1] =~ /or|either/i)
		{
			print "并列句选择  or";
			$result[$nums] = "CMCS";
			print "第",$nums+1,"句是并列句 : @{$Word[$nums]}\n";
			return 2;
		}

	}
}

sub CMother
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my @thfstsallword = ThSAllWord($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @thccall = ThCCAllWord($tmpstring);

	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	#my $cc= 0;
	#foreach(@maintrck){print"$_\n";}
	foreach(my $i = 0;$i<=$#worD;$i++)
	{
		if($worD[$i] eq "otherwise")
		{
			print "并列句选择  otherwise";
			$result[$nums] = "CMCS";
			print "第",$nums+1,"句是并列句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$i] =~/^(nevertheless|however|still)$/i)
		{ 
			print "并列句转折 ";
			$result[$nums] = "CMBS";
			print "第",$nums+1,"句是并列句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$i] =~ /^(so|therefore)$/)
		{
			print "并列句因果  ";
			$result[$nums] = "CMRS";
			print "第",$nums+1,"句是并列句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	#if()
}


sub SbarCM
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring);
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my @intro = introducer($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	
	if(scalar(@intro) == 1)
	{
		if($worD[$intro[0]-1] =~ /\bwhereas\b/i)
		{
			print "并列句转折  3";
			$result[$nums] = "CMBS";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	if(scalar(@intro) == 0)
	{
		if($worD[$sbarallword[0]-2] =~ /\belse\b/i and $worD[$sbarallword[0]-3] =~ /\bor\b/i)
		{
			print "并列句转折  3";
			$result[$nums] = "CMBS";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	if(($poS[$sbarallword[0]-1] =~ /JJR|JJS|RBR|RBS/ or $poS[$sbarallword[0]] =~ /JJR|JJS|RBR|RBS/) and $worD[$sbarallword[scalar(@sbarallword)-1]] =~ /;|,/)
	{
		for(my $i = $worD[$sbarallword[scalar(@sbarallword)-1]-1];$i<=$#worD;$i++){
		if($poS[$i] =~ /JJR|JJS|RBR|RBS/){print "比较状语从句  ";$result[$nums] = "CMPADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}}
	}
	#print "比较状语从句  1";$result[$nums] = "CMPADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;} }
	
	
	
}

 
 
 
 sub SoForCp
{
	my ($tmpstring,$nums) = @_;
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	#print "\n\n DDDDD JJJJJJ \n\n";
	if(scalar(@intro) == 1)
	{
		#print "$worD[$intro[0]-1]\n\n";
		if($worD[$intro[0]-1] =~ /^(for|so)$/i and $worD[$intro[0]-2] =~ /,/)
		{
			print "并列表因果  1";
			$result[$nums] = "CMRS";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	
}
 
 
 my @sub_location = Sentence_Sub_Locate();
 foreach(@sub_location){my @ttt = @{$_};
 print "@ttt\n";
print  "__DDDDDDD\n";}
 
 
 
 
 
 
 
 
 
 