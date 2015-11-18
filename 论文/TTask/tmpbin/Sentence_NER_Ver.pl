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
use MulTree qw(SbarNumber SbarSAllWord ThSAllWord ThCCAllWord SbarPPWord SbarSChild  SbarAllword ThreeRlatSbar MainTruck SbarLeftSibling SbarAllFather SbarAllChildren SbarRightSibling SbarFather);
use WPosParse_TypeDependent qw(WordsAndPos_Penn_TypedDependt TextPath Pos Word Penn TypeDpdt Verb SentenceKinds Predivate_Verb_and_Location Sentence_Sub_Locate);

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
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 #########################################################################################
#print "$local_direc\n";
#GGG($TT);
 my @SThirdCls = StateThrBigCls();
 my @Kinds = SentenceKinds();

 # for(my $i = 0;$i<=$#Kinds;$i++)
 # {
	# #print $Kinds[$i];
	# #print"\n";
 # }
 
 
 my @SDeclNumSS =Subject();
 my @Word = Word();

 my @sbarnumber = Sbarnumber();
 my @PENN = Penn();

 for(my $i = 0;$i<=$#SDeclNumSS;$i++)
 {
	 
	my @tmp = @{$SDeclNumSS[$i]};
	if($Kinds[$i] == 0)
	{
		if(${$SThirdCls[$i]}{'Flag'} == 1)
		{
				print "第",$i+1,"句是简单句 : @{$Word[$i]}\n";
				$result[$i] = "SS";
		}
		elsif(${$SThirdCls[$i]}{'Flag'} == 2)
		{
			
			my $arrref  = Judge_Compound("@{$Word[$i]}");
			my @arr = @$arrref;
			CMAS("@{$PENN[$i]}",$i);
			my $ThSFlag = ThSComplex("@{$PENN[$i]}",$i);
			if($ThSFlag == 2)
			{
				print "第",$i+1,"句是XC XXXX: @{$Word[$i]}\n";
				next;
			}
			elsif($arr[1] eq "and")
			{print "第",$i+1,"句是并列句 AND: @{$Word[$i]}\n";$result[$i] = "CMAS";}
			elsif($arr[1] eq "but")
			{print "第",$i+1,"句是转折句 BUT: @{$Word[$i]}\n";$result[$i] = "CMBS";}
			elsif($arr[0] == 0)
			{print "第",$i+1,"句是并列句 AND: @{$Word[$i]}\n";$result[$i] = "CMAS";}
			elsif($arr[0] == 1)
			{print "第",$i+1,"句是转折句 BUT: @{$Word[$i]}\n";$result[$i] = "CMBS";}
			elsif($arr[0] == 2)
			{print "第",$i+1,"句是并列选择句 CHIOCE: @{$Word[$i]}\n";$result[$i] = "CMCS";}
			else
			{print "第",$i+1,"句是并列句 AND: @{$Word[$i]}\n";$result[$i] = "CMAS";}
		}
		elsif(${$SThirdCls[$i]}{'Flag'} == 3)
		{
			#CMS($i);
			my $FlagNumber;
			#print"\n";
			$FlagNumber = SubClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ObjectClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = PredicativeClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ApposClauseAndAttributiveClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Attributive_Clauses("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = NONAttributive_Clauses("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = PreADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Time_ADV_Clause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Reason_Adv_Clasuse("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = WhereADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ConditionADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ConcessionADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = RslADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = When("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Where("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = SoForCp("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = As("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = SinceIf("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = While("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			if($FlagNumber != 2){$result[$i] = "NON";print "第",$i+1,"句是复杂句 : @{$Word[$i]}\n";}
			
			
			
			#print "第",$i+1,"句是复杂句 : @{$Word[$i]}\n";
		}
		else
		{
			print "不是陈述句\n";
			$result[$i] = "NON";
		}
		
	}
	elsif($Kinds[$i] == 1)
	{
		if(${$tmp[$i]}{'SDeclaNumber'} == 1)
		{
			print $i+1," Question Sentence is Simple : @{$Word[$i]}\n";
			$result[$i] = "SS";
		}
		else
		{
			print $i+1," Question Sentence Two Subject: @{$Word[$i]}\n";
			$result[$i] = "SS";
		}
	}
	elsif($Kinds[$i] == 2)
	{
		print $i+1," 感叹句 Simple : @{$Word[$i]}\n";
		$result[$i] = "SS";
	}
	elsif($Kinds[$i] == 3)
	{
		#print "@{$Word[$i]} KKKKKKK\n";
		if(${$SThirdCls[$i]}{'Flag'} == 1)
		{
				print "第",$i+1,"句  ${$SThirdCls[$i]}{'Flag'}  是祈使简单句 : @{$Word[$i]}\n";
				$result[$i] = "SS";
		}
		elsif(${$SThirdCls[$i]}{'Flag'} == 2)
		{
			
			my $arrref  = Judge_Compound("@{$Word[$i]}");
			my @arr = @$arrref;
			my $ThSFlag = ThSComplex("@{$PENN[$i]}",$i);
			if($ThSFlag == 2)
			{
				print "第",$i+1,"句是XC: @{$Word[$i]}\n";
				next;
			}
			if($arr[1] eq "and")
			{print "第",$i+1,"句是并列句 AND: @{$Word[$i]}\n";$result[$i] = "CMAS";}
			elsif($arr[1] eq "but")
			{print "第",$i+1,"句是转折句 BUT: @{$Word[$i]}\n";$result[$i] = "CMBS";}
			elsif($arr[0] == 0)
			{print "第",$i+1,"句是并列句 AND: @{$Word[$i]}\n";$result[$i] = "CMAS";}
			elsif($arr[0] == 1)
			{print "第",$i+1,"句是转折句 BUT: @{$Word[$i]}\n";$result[$i] = "CMBS";}
			elsif($arr[0] == 2)
			{print "第",$i+1,"句是并列选择句 CHIOCE: @{$Word[$i]}\n";$result[$i] = "CMCS";}
			else
			{print "第",$i+1,"句是并列选择句 AND: @{$Word[$i]}\n";$result[$i] = "CMCS";}
		}
		elsif(${$SThirdCls[$i]}{'Flag'} == 3)
		{
			#CMS($i);
			my $FlagNumber;
			#print"\n";
			$FlagNumber = SubClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ObjectClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = PredicativeClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ApposClauseAndAttributiveClause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Attributive_Clauses("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = NONAttributive_Clauses("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = PreADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Time_ADV_Clause("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Reason_Adv_Clasuse("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = WhereADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ConditionADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = ConcessionADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = RslADVC("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = When("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = Where("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = SoForCp("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = As("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			$FlagNumber = SinceIf("@{$PENN[$i]}",$i);
			next if ($FlagNumber == 2);
			if($FlagNumber != 2){$result[$i] = "NON";print "第",$i+1,"句是复杂句 : @{$Word[$i]}\n";}
		}
		else
		{
			print "不是陈述句\n";
			$result[$i] = "NON";
		}
		#print $i+1," ${$tmp[0]}{'SDeclaNumber'} 祈使句: @{$Word[$i]}\n";
	}
	# elsif($Kinds[$i] == 1)
	# {
		# if(${$tmp[0]}{'SDeclaNumber'} == 1)
		# {
			# print $i+1,"Sentence is Simple\n"
		# }
	# }
	else
	{
		print $i+1,"Now  Not  Sure :  @{$Word[$i]}\n";$result[$i] = "NON";;
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
 
 
 #SbarAll();
 ##############################################################
 sub SbarAll
 {
	my @penn = Penn();
	my @Sbarall = ();
	for(my $i = 0;$i<=$#penn;$i++)
	{
		my $tmpstring = "@{$penn[$i]}";
		#print "$tmpstring \n";
		my $tmpsbarnumber = SbarNumber();
		if($tmpsbarnumber > 0.1)
		{
			my $tmpsfather = SbarFather($tmpstring);
			my @tmpslsiling = SbarLeftSibling($tmpstring);
			my @tmpsrsiling = SbarRightSibling($tmpstring);
			my @tmpsfasiling = SbarAllFather($tmpstring);
			my @tmpslchind = SbarAllChildren($tmpstring);
			my %hash = ();
			$hash{'SFather'} = $tmpsfather;
			$hash{'SLSiling'} = @tmpslsiling;
			#$hash{'SRSiling'} = @tmp;
		}
		else
		{
			
		}
		
		 
	}
 }
 
 
 
 #################################
 #ComplexMainSentence
 #CMS();
 sub CMS
 {
	my $index = shift;
	my @penn = Penn();
	#my @Sbarall = ();
	
	
	my $tmpstring = "@{$penn[$index]}";
	#print "PPP $tmpstring \n";
	my $Maintruck = MainTruck($tmpstring);
	my @tmpsbarfather = SbarFather($tmpstring);
	my @tmpallfather = SbarAllFather($tmpstring);
	my @tmpallsiling = SbarLeftSibling($tmpstring);
	my $ThRlaSbar = ThreeRlatSbar($tmpstring);
	my $sbarsilingnumber = scalar(@tmpallsiling);
	my $sbarfathername = shift(@tmpsbarfather);
	my $sbarfatherlayer = shift(@tmpsbarfather);
	
		#print "$sbarfathername  EEE $sbarfatherlayer \n";
		print "$ThRlaSbar GGGG\n";
	
	
 }
 
 
###########################################################################
#&CLS();
sub CLS
{
	my @penn = Penn();
	my $tmpstring = "(ROOT (S (NP (EX There)) (VP (VBP are) (NP (NP (NNS occasions)) (SBAR (WHADVP (WRB when)) (S (NP (PRP one)) (VP (MD must) (VP (VB yield))))))) (. .)))";
	my $ThRlaSbar = ThreeRlatSbar($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @tmpsbarfather = SbarFather($tmpstring);
	my @tmpallsiling = SbarLeftSibling($tmpstring);
	my @tmpallfather = SbarAllFather($tmpstring);
	my @tmpright = SbarRightSibling($tmpstring);
	SbarAllChildren($tmpstring);
	print "$ThRlaSbar  RRRRRRRR \n";
	foreach(@tmpallsiling)
	{
		print @$_;
		print"MMM\n";
	}
	# foreach(@penn)
	# {
		# my $text = "@{$_}";
		# my $maintruck = MainTruck($text);
		# print " $maintruck \n";
	# }
	
}

sub SubC
{
	my $tmpstring = shift;
	my $maintruck = MainTruck($tmpstring);
	my @maintruck = split(/-/,$maintruck);
	my $maintruckflag = 0;
	foreach(@maintruck)
	{
		if($_ eq "NP" or $_ eq "VP")
		{
			$maintruckflag++;
		}
	}
	if($maintruckflag >= 1.9)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}


#状语从句
sub AdC
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintruck1 = split(/-/,$maintruck);
	if($tmpmaintruck == 1)
	{
			for(my $i=0; $i<=$#maintruck1; $i++)
			{
				if($maintruck1[$i] eq "SBAR" and $maintruck1[$i+1] eq "," and $maintruck1[$i+2] =~/NP|VP/)
				{
					print "状语从句 Adverbial Clause		";
					$result[$nums] = "AC";
					return 2;
				}
			}

	}
}
#主语从句
#Whichever (of you) comes in first will receive a prize. 
sub SubClause
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarLchild = SbarAllChildren($tmpstring);
	my $SString = $sbarLchild[scalar(@sbarLchild)-1];
	my @lastarr = split(/\-/,$SString);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $tmp = qr/^(seem|seemed|happen|happened)$/;
	my $be = qr/^(are|been|am|is|be|were|was|'s)$/;
	#print $maintruck;
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
	
	my @maintruck1 = split(/-/,$maintruck);
	if($tmpmaintruck == 0 and $sub_introducerflag == 1)
	{
			for(my $i=0; $i<=$#maintruck1; $i++){
			if($maintruck1[$i] eq "SBAR" and $maintruck1[$i+1] eq "VP"){
				print "主语从句 1";
				$result[$nums] = "SC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
				}
			#if($maintruck1[$i] eq "SBAR" and $maintruck1[$i+2] eq "VP" and $maintruck1[$i+1] eq "NP")
			}

	}
	if($tmpmaintruck == 1 and $sub_introducerflag == 1)
	{
		for(my $i=0; $i<=$#maintruck1; $i++){
			if($maintruck1[$i] eq "SBAR" and $maintruck1[$i+2] eq "VP" and $maintruck1[$i+1] eq "NP"){
				if(scalar(@lastarr) >0.1 and $lastarr[scalar(@lastarr)-2] =~ /^VB/){			
				print "主语从句 22222";
				$result[$nums] = "SC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
				}
				}
			}
	}
	if($worD[0] =~ /^it$/i and $worD[1] =~ /$be/ and $sub_introducerflag == 1)
	{
		if($worD[$sbarallword[0]-1] =~ /^that$/ and $poS[$sbarallword[0]-2] =~ /JJ|NN/)
		{
			print "主语从句 3";
			$result[$nums] = "SC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	
	if($worD[0] =~ /^it$/i and $worD[1] =~ /$be/ and $sub_introducerflag == 1)
	{
		if($worD[$sbarallword[0]-1] =~ /^that$/ and $poS[$sbarallword[0]-2] =~ /VBN|VBD/)
		{
			print "主语从句 4";
			$result[$nums] = "SC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
		if($worD[0] =~ /^it$/i and $sub_introducerflag == 1)
	{
		if($worD[$sbarallword[0]-1] =~ /^that$/ and ($worD[$sbarallword[0]-2] =~ /$Vi|$tmp/))
		{
			print "主语从句 5";
			$result[$nums] = "SC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
		if($worD[0] =~ /^it$/i and $sub_introducerflag == 1)
	{
		if($worD[$sbarallword[0]-1] =~ /^that$/ and $worD[$sbarallword[0]-2] =~ /^out$/ and $worD[$sbarallword[0]-3] =~ /^(turn|turned)$/)
		{
			print "主语从句 6";
			$result[$nums] = "SC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	if($worD[0] =~ /^it$/i and $sub_introducerflag == 1)
	{
		if($worD[$sbarallword[0]-1] =~ /^whether$/ and $worD[$sbarallword[0]-2] =~ /^matter$/ and $poS[$sbarallword[0]-2] =~ /^VB/)
		{
			print "主语从句 6";
			$result[$nums] = "SC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	#if($worD[0] =~ /^that$/)
}
#宾语从句
sub ObjectClause
{
	
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my $o_introducer = qr/\b(that|if|whether|what|who|which|whose|how|why|whom|whose|whoever|whomever|whosever|whatever|whichever|why|how|however)\b/;
	my $o_introducerflag;

	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$o_introducer/)
		{
			$o_introducerflag = 1;
		}
	}
	my $Non_OC_Verb = qr/^(provided|suppose|supposing|providing|seeing|given|considering|granted|granting|admitting)$/i;
	my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $Ving = qr/^(agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my $special_verb = qr/^(leave|put|discuss|doubt|left|discussed|doubted).s$/;
	my $special_verbing = qr/^(leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my $Link_appos = qr/^(news|demand|impression|truth|idea|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)s?$/;
	my $Link_Verbing = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)ing$/;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked
|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mail
ed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|pre
pared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|stea
l|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
#my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sounds|taste|smell|remain|keep|stay|become|get|grow|turn|go|fall|prove|was|were|felt||seemed|looked|appeared|sounded|tasted|smelled|remained|kept|stayed|became|got|grew|turned|gone|fell|proved)s?$/;
my $adjObClauseWord = qr/^(sure|certain|glad|please|happy|sorry|afraid|satisfied|surprised)$/;
	#print $maintruck;
	my @maintruck1 = split(/-/,$maintruck);
	if($o_introducerflag == 1 and ($sbarallword[0]) > 2.1 and $worD[0] !~ /^it$/i)
	{	
		   # print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}HHHHHHHHHHHHHHHHHHHHH\n";
			if(scalar(@sbarallword) > 0.3)
			{
				#print "第",$nums+1,"句是复杂句   $poS[$sbarallword[0]-2]: @{$Word[$nums]}HHHHHHHHHHHHHHHHHHHHH\n";
				#my $tmpstring  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
				#my @tmparr = split(/\s/,$tmpstring);
				if($poS[$sbarallword[0]-2] =~ /^VB/ and $worD[$sbarallword[0]-2] !~ /$Link_Verb|$Vi|$Non_OC_Verb/ and $worD[$sbarallword[0]-3] !~ /^(are|been|am|is|be|were|was)$/)
				{
					print "宾语从句 1";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($worD[$sbarallword[0]-2] =~ /^VBG/ and $worD[$sbarallword[0]-2] !~ /$Link_Verbing/ and $worD[$sbarallword[0]-2] !~ /$Ving/ and $worD[$sbarallword[0]-2] != /^(are|am|is|be|were|was)$/)
				{
					print "宾语从句 1X";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				#if()
				for(my $i=0; $i<$sbarallword[0]; $i++)
				{
					if($worD[$i] =~ /^it$/ and $poS[$i-1] =~ /^VB/)
					{
						print "it 宾语从句 2";
						$result[$nums] = "OC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
				}
				if($poS[$sbarallword[0]-2] =~ /^JJ/ and $worD[$sbarallword[0]-2] =~ /$adjObClauseWord/ and $poS[$sbarallword[0]-3] =~ /^VB/)
				{
					print"ADJ 宾语从句 3";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro)==1 and  $worD[$intro[0]-1] =~/whether/ and $poS[$intro[0]-2] =~ /RB|IN|RP/ and $poS[$intro[0]-3] =~ /^VB/)
				{
					print "介词宾语的宾语从句 4";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro)==1 and  $worD[$intro[0]-1] =~/^that$/ and $worD[$intro[0]-2] =~ /^(but|besides|in|except)$/ and $poS[$intro[0]-3] =~ /^VB/)
				{
					print "介词宾语的宾语从句 4";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if(scalar(@sbarleftsiling) == 2 and scalar(@sbarleftsiling) > 0.1)
			{
				my $tmpstringlast  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
				my $tmpstringfirst  = @{$sbarleftsiling[0]}[0];
				my @tmparr = split(/\s/,$tmpstringlast);
				my @tmparrfirst = split(/\s/,$tmpstringfirst);
				if($tmparr[0] =~ /^NP/ and ($tmparr[scalar(@tmparr) - 2] =~/PRP|NN/) and $tmparrfirst[scalar(@tmparrfirst)-1] =~ /$double_object/ and $tmparr[scalar(@tmparr) -1] !~ /$Link_appos/)
				{
					print "双宾语的宾语从句 5";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro)==1 and  $worD[$intro[0]-1] =~/whether/ and $poS[$intro[0]-2] =~ /RB|IN|RP/ and $poS[$intro[0]-3] =~ /^VB/)
				{
					print "介词宾语的宾语从句 6";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				for(my $i=0; $i<$sbarallword[0]; $i++)
				{
					if(($worD[$i] =~ /^it$/ and $poS[$i-1] =~ /^VB/ and $poS[$i+1] !~ /^RB$/) or ($worD[$i] =~ /^it$/ and $poS[$i-2] =~ /^VB/ and $poS[$i-1] =~ /^(IN|RB|RP)$/ and $poS[$i+1] !~ /^RB$/))
					{
						print "it 宾语从句 7";
						$result[$nums] = "OC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
				}
				
			}
			if(scalar(@intro) == 1 and $intro[0] != 1)
			{
				my $i = $intro[0]-2;
				my $j;
				while((($poS[$i] =~ /^(IN|TO|RB|RP)/)))
				{
					$i--;
					$j = $i;
				}
				# if()
				# {
					
				# }
				#print "$worD[$j] FFFF\n";
				if($poS[$j] =~ /^VB|^JJ/ and defined $j and $worD[$j] !~ /$Link_Verb|$special_verb|$Vi/)
				{
					print "宾语从句 12";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
			}
			if(scalar(@intro) == 1 and $intro[0] != 1 and $worD[$intro[0]-1] =~ /\bthat\b/)
			{
				if(($poS[$intro[0]-2] =~ /IN/ and $worD[$intro[0]-2] =~ /^except$/) or $worD[$intro[0]-2] =~ /^but$/)
				{
					print "宾语从句 13";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
			}
			if($worD[($sbarallword[0]-2)] =~ /$special_verb/ and $poS[($sbarallword[0]-2)] =~ /^VB/ and $worD[($sbarallword[0]-1)] =~ /^whether/)
			{
				print "宾语从句 14";
				$result[$nums] = "OC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
			#if(scalar(@sbarleftsiling) == 2 and @{$sbarleftsiling[0]}[0] =~ /^VB/ and @{$sbarleftsiling[0]}[scalar(@{$sbarleftsiling[0]})-1] =~ )
			# {
				
			# }

	}
	if($tmpmaintruck == 0 and $o_introducerflag == 1 and ($sbarallword[0]) > 2.1)
			{
				#print"FFFFFFFFFFFFFFFF\n";
				if(scalar(@sbarleftsiling) == 2 and scalar(@sbarleftsiling) > 0.1)
				{
					my $tmpstringlast  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
					my $tmpstringfirst  = @{$sbarleftsiling[0]}[0];
					my @tmparr = split(/\s/,$tmpstringlast);
					my @tmparrfirst = split(/\s/,$tmpstringfirst);
					if($tmparr[0] =~ /^NP/ and ($tmparr[scalar(@tmparr) - 2] =~/PRP|NN/) and $tmparrfirst[scalar(@tmparrfirst)-1] =~ /$double_object/ and $tmparr[scalar(@tmparr) -1] !~ /$Link_appos/)
					{
						print "双宾语的宾语从句 8";
						$result[$nums] = "OC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
					if(scalar(@intro)==1 and  $worD[$intro[0]-1] =~/whether/ and $poS[$intro[0]-2] =~ /RB|IN|RP/ and $poS[$intro[0]-3] =~ /^VB/)
					{
						print "介词宾语的宾语从句 9";
						$result[$nums] = "OC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
					for(my $i=0; $i<$sbarallword[0]; $i++)
					{
						if($worD[$i] =~ /^it$/ and $poS[$i-1] =~ /^VB/ and $poS[$i+1] !~ /^RB$/)
						{
							print "it 宾语从句 10";
							$result[$nums] = "OC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
					}
					if($poS[$sbarallword[0]-2] =~ /^JJ/ and $worD[$sbarallword[0]-2] =~ /$adjObClauseWord/ and $poS[$sbarallword[0]-3] =~ /^VB/)
					{
						print"ADJ 宾语从句 11";
						$result[$nums] = "OC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
						for(my $i=0; $i<$sbarallword[0]; $i++)
					{
						if(($worD[$i] =~ /^it$/ and $poS[$i-1] =~ /^VB/ and $poS[$i+1] !~ /^RB$/) or ($worD[$i] =~ /^it$/ and $poS[$i-2] =~ /^VB/ and $poS[$i-1] =~ /^(IN|RB|RP)$/ and $poS[$i+1] !~ /^RB$/))
						{
							print "it 宾语从句 13";
							$result[$nums] = "OC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
					}
					
				}
				if($worD[($sbarallword[0]-2)] =~ /$special_verb/ and $poS[($sbarallword[0]-2)] =~ /^VB/ and $worD[($sbarallword[0]-1)] =~ /^whether/)
				{
					print "宾语从句 14";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
}
#表语从句
  
sub PredicativeClause
{
	
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|grow|was|were|felt||seemed|looked|appeared|sounded|stayed|became|grew)s?$/;
	#print $maintruck;
	my @sbarallword = SbarAllword($tmpstring);
	#my @sbarallword = SbarAllword($tmpstring);
	#my @sbarppword = SbarPPWord($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	#my @lastarr = @{$sbarleftsiling[0]};
	
	#my $tmpmatch = "@tmparr";
	my @maintruck1 = split(/-/,$maintruck);
	if($tmpmaintruck == 1)
	{
			if(scalar(@sbarleftsiling) == 1 and scalar(@sbarleftsiling) > 0.1)
			{
				my $tmpstring  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
				my @tmparr = split(/\s/,$tmpstring);
				
				if($tmparr[0] =~ /^VB/ and $tmparr[1] =~ /$Link_Verb/)
				{
					print "表语从句 1";
					$result[$nums] = "PC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($tmparr[0] =~ /ADVP/)
				{
					#print "$tmparr[2] \n";
					for(my $i=0; $i<$#worD; $i++)
					{
						if($worD[$i] =~ /^$tmparr[2]$/ and $worD[$i-1] =~ /$Link_Verb/)
						{
							print "表语从句 2";
							$result[$nums] = "PC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
						if($worD[$i] =~ /^$tmparr[2]$/ and $worD[$i-1] !~ /$Link_Verb/)
						{
							my $j = $i;
							until($poS[$j] !~ /RB/)
							{
								$j--;
							}
							if($worD[$j] =~ /$Link_Verb/)
							{
								print "表语从句 3";
								$result[$nums] = "PC";
								print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
								return 2;
							}
						}
					}
				}
				
			}
			if($worD[$sbarallword[0]-2] =~ /^'t|^n't|not/ and $worD[$sbarallword[0]-3] =~ /$Link_Verb/)
			{
				print "表语从句 4";
				$result[$nums] = "PC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
			#if(scalar(@sbarleftsiling) == 1 and @{$sbarleftsiling[0]}[0] =~ /^VB/ and @{$sbarleftsiling[0]}[scalar(@{$sbarleftsiling[0]})-1] =~ )
			# {
				
			# }

	}
}
#同位语从句
sub ApposClauseAndAttributiveClause
{
	#if不引导同位语
	my ($tmpstring,$nums) = @_;
	#print"$tmpstring \n";
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	#my @sbarleftsiling = SbarLeftSibling($tmpstring);
	#my $tmpstring  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
	my @sbarightchild = SbarSChild($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	#my @sbarallword = SbarAllword($tmpstring);
	my @sbarppword = SbarPPWord($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @lastelement = ();
	my @sbarschild = SbarSChild($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @sbarallword = SbarAllword($tmpstring);

	my $appos_introducer = qr/\b(that|whether|what|which|who|how|why)\b/;
	my $appos_introducerflag;
	if(scalar(@intro) == 0)
	{
		$appos_introducerflag = 1;
	}
	else
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /$appos_introducer/)
			{
				$appos_introducerflag = 1;
			}
		}
	}
	#my @lastelement = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
	my @match = split(/\s/,"@lastelement");
	#my $NPstring = "@lastelement";
	my $Vi = qr/^(studied|speak|talk|XXX|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved)s?$/;
	my $Ving = qr/^(studied|speak|talk|XXX|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved)ing$/;
	my $Link_appos = qr/^(rumor|news|eagerness|question|demand|impression|truth|idea|words||resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	#print $maintruck;
	my @maintruck1 = split(/-/,$maintruck);
	if($tmpmaintruck == 1 and $appos_introducerflag == 1)
	{
			my $Vp = ();
			my $Np = ();
			foreach(@sbarsschild)
			{
				#print;
				if($_ eq "NP")
				{
					$Np = "NP";
				}
				if($_ eq "VP")
				{
					$Vp = "VP";
				}
			}
			#print $NPstring;
			if(scalar(@intro) == 1 and $worD[$intro[0]-2] =~ /$Link_appos/ and defined($Np))
			{
					print"同位语	1";
					$result[$nums] = "AC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
			
				
			}
			if(scalar(@intro) == 1 and $worD[$intro[0]-2] =~ /$Link_appos/ and !defined($Np))
			{
				
					print"同位语	1";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
			
				
			}

	}
}
#定语从句
sub Attributive_Clauses
{
	#if不引导同位语
	my ($tmpstring,$nums) = @_;
	#print"$tmpstring \n";
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my @sbarchild = SbarAllChildren($tmpstring);
	my @sbarBeforePpYN = SbarPPWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	#my @sbarallword = SbarAllword($tmpstring);
	my @sbarppword = SbarPPWord($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @intro = introducer($tmpstring);
	#print "FFFFFFFFFFFFFFF\n";
	#my $tmpstring  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
	my @sbarsschild = SbarSChild($tmpstring);
	my @lastelement = ();
	#my @sbarschild = SbarSChild($tmpstring);
	 # foreach(@sbarsschild)
	 # {
		 # print"$_   GGG";
	 # }
	my $Sbarleftsilinglast;
	if(scalar(@sbarleftsiling) > 0.3)
	{
		$Sbarleftsilinglast = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
	}
	my @sbarleftsilinglast1 = split(/\s/,$Sbarleftsilinglast);
	foreach(@sbarleftsiling)
	{	
		
		if("@$_" =~ /NP/)
		{	
			#print"@$_";
			@lastelement = @$_;
		}
	}
	my $attr_intro = qr/\b(that|how|whose|whom|who|which|why|as)\b/i;
	my $nonattr_intro = qr/\b(now|in|so)\b/i;
	my $attr_introflag;
	for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
	{
		if($worD[$i] =~ /$attr_intro/ and $worD[$i] !~ /$nonattr_intro/)
		{
			$attr_introflag = 1;
		}
	}

	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked
|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mail
ed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|pre
pared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|stea
l|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
	
	my $Vi = qr/^(studied|speak|talk|XXX|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved)?s$/;
	my $Ving = qr/^(studied|speak|talk|XXX|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved)ing$/;
	#my @lastelement = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]};
	my @match = split(/\s/,"@lastelement");
	#my $NPstring = "@lastelement";
	my $Link_appos = qr/^(news|eagerness|question|demand|impression|truth|idea|words|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	#print $maintruck;
	my @maintruck1 = split(/-/,$maintruck);
	if(($worD[$sbarallword[0] -2] !~ /\,/ and  $worD[$sbarallword[0]-2] !~ /$Link_appos/ and scalar(@sbarallword) > 0.3) and $attr_introflag == 1 and ($worD[$sbarallword[0] -3] !~ /\,/) and  ($sbarallword[0]-1) != 0)
	{
			#print $sbarallword[0]."HHHHH";
			if(scalar(@sbarsschild) > 0.3 and $poS[$sbarallword[0] -2] =~ /^NN/)
			{
				my $Vp = ();
				my $Np = ();
				foreach(@sbarsschild)
				{
					#print;
					if($_ eq "NP")
					{
						$Np = "NP";
					}
					if($_ eq "VP")
					{
						$Vp = "VP";
					}
				}
				if($Np ne "NP" or !defined($Np))
				{
					 print"定语从句	1";
					 $result[$nums] = "XATC";
					 print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					 return 2;
				}

			}
			if($worD[$intro[0]-1] =~ /which|whom/ and $poS[$intro[0]-2] =~ /^NN/ and ($poS[$intro[0]-3] !~ /$double_object/ or $poS[$intro[0]-4] !~ /$double_object/))
			{
				print"定语从句	16";
				$result[$nums] = "XATC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
			if(scalar(@intro) == 2 and scalar(@sbarleftsilinglast1) > 0.3 and ($sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/ or $poS[$sbarallword[0]-2] =~ /^NN/))
			{
				my $intrOducer = qr/(whom|which|whose)/;
				if($poS[($intro[0]-1)] =~ /IN|RB/ and $worD[$intro[0]] =~ /$intrOducer/)
				{
					print"定语从句	2";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			######
			if(scalar(@intro) == 2 and scalar(@sbarleftsilinglast1) > 0.3 and ($sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/ or $poS[$sbarallword[0]-2] =~ /^NN/))
			{
				my $intrOducer = qr/(whom|which|whose)/;
				if($poS[($intro[0]-1)] =~ /IN|RB/ and $worD[$intro[0]] =~ /$intrOducer/)
				{
					print"定语从句	2";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if(scalar(@intro) == 1 and scalar(@sbarleftsilinglast1) > 0.3)
			{
				my $intrOducer = qr/(whom|which|whose)/;
				if($poS[($intro[0]-2)] =~ /IN|RB/ and $poS[($intro[0]-3)] =~ /^NN/ and $worD[$intro[0] -1 ] =~ /$intrOducer/)
				{
					print"定语从句	3";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if(scalar(@sbarppword) > 0.3 and $poS[$sbarallword[0]-2] =~ /^NN/)
			{
				if($poS[$sbarppword[0]-2] =~ /^(RB|TO|IN|RP)$/ and $poS[$sbarppword[0]-3] =~ /^VB/)
				{
					 print"定语从句	14";
					 $result[$nums] = "XATC";
					 print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					 return 2;
				}
			}
			if(scalar(@sbarleftsilinglast1) > 0.3 and ($sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/ or $poS[$sbarallword[0]-2] =~ /^NN/) and $sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-1] !~ /$Link_appos/)
			{
				if($poS[$sbarallword[scalar(@sbarallword) -1] -1] =~ /IN/ and  $poS[$sbarallword[scalar(@sbarallword) -2] -1] =~ /^VB/)
				{
					print"定语从句	4";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($poS[$sbarallword[scalar(@sbarallword) -1] -1] =~ /^VB/ and $worD[$sbarallword[scalar(@sbarallword) -1] -1] !~ /$Vi/)
				{
					print"定语从句	5";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if(@sbarallword > 0.3 and @match > 0.3 and ($sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/ or $poS[$sbarallword[0]-2] =~ /^NN/) and $sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-1] !~ /$Link_appos/)
			{
				#print"FFFFF".$worD[$sbarppword[0]-1];
				if($worD[($sbarallword[scalar(@sbarallword)-1]) -1] !~ /$Vi/ and $poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^VB*[^G]$/ and $worD[($sbarallword[scalar(@sbarallword)-1]) -2] !~ /^(am|is|are|was|were|been|be)$/)
				{
					print"定语从句	6";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				# if($worD[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /$Vi/ and $poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^VB/ and scalar(@intro) == 1)
				# {
					# print"定语从句	Test1";
					# $result[$nums] = "XATC";
				# }
				if($poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^RP$|IN|RB/ and $worD[($sbarallword[scalar(@sbarallword)-1]) -2] =~ /$Vi/)
				{
					print"定语从句	7";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
				if($poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^IN$|^RB$/ and $poS[($sbarallword[scalar(@sbarallword)-1]) -2] =~ /^VB/)
				{
					print"定语从句8";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
				
					#my @SubSbarBeforePpYN = @{$sbarBeforePpYN[scalar(@sbarBeforePpYN) - 1]};
				if($worD[$sbarppword[0]-2] !~ /$Vi/ and $poS[$sbarppword[0]-2] =~ /^VB/ and @sbarppword > 0.3)
				{	
					print"定语从句	9";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($worD[$sbarppword[0]-2] =~ /$Vi/ and $poS[$sbarppword[0]-2] =~ /^VB/ and scalar(@intro)==1 and $worD[$intro[0]-1] =~ /that|who|whom/ and @sbarppword > 0.3)
				{
					print"定语从句	10";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($worD[$sbarppword[0]-3] =~ /$Vi/ and $poS[$sbarppword[0]-2] =~ /RP|IN|RB/ and scalar(@intro)==1 and $worD[$intro[0]-1] eq "that" and @sbarppword > 0.3)
				{
					print"定语从句	11";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				# if($worD[0] =~ /it/i and ($worD[$sbarallword[0]-1] =~ /^that$/ or scalar(@intro) == 0))
				# {
					# print"It is	Sentence ";
					# $result[$nums] = "ITIS";
					# print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					# return 2;
				# }
					# for(my $i = $sbarallword[0];$i<$sbarallword[scalar(@sbarallword) - 1];$i++)
					# {
						# if( ($worD[$i] eq "$SubSbarBeforePpYN[scalar(@SubSbarBeforePpYN)-1]" and $poS[$i] =~ /^IN/ and $poS[$i-1] =~ /^VB/) or ($worD[$i] eq "$SubSbarBeforePpYN[scalar(@SubSbarBeforePpYN)-1]" and $poS[$i] =~ /^VB*G$/))
						# {
							# print"定语从句	Test4";
							# $result[$nums] = "XATC";
						# }
					# }
				
				
				
				
			}
			if(scalar(@sbarallword) > 0.3 and $worD[$sbarallword[0]-1] =~ /^NN/ or $poS[$sbarallword[0]-2] =~ /^NN/ and $worD[$sbarallword[0]-2] !~ /$Link_appos/)
			{
				if(scalar(@intro)==1 and $worD[$intro[0]-1] =~ /why$/ and $worD[$intro[0]-2] =~ /reason/)
				{
					print"定语从句	12";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro)== 0 and $worD[$sbarallword[0]-1] =~ /^NN/)
				{
					print"定语从句	13";
					$result[$nums] = "XATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			#if()
			#if(scalar(@sbarleftsiling) == 1 and @{$sbarleftsiling[0]}[0] =~ /^VB/ and @{$sbarleftsiling[0]}[scalar(@{$sbarleftsiling[0]})-1] =~ )
			# {
				
			# }

	}
	#return 0;
}

sub CRate
{
	my ($arrnumref,$arrresultref) = @_;
	my @arrnum = @$arrnumref;
	my @arrresult = @$arrresultref;
	for(my $i=0; $i<$#arrresult; $i++)
	{
		if($i<20 and $arrresult[$i] eq "OC")
		{
			
		}
	}
}
###########################################################################
#PingJia();
 sub PingJia
 {
	my $Sstring = <STDIN>;
	chomp($Sstring);
	my $BLine = <STDIN>;
	chomp($BLine);
	my $ELine = <STDIN>;
	chomp($ELine);
	my $correct_count = 0;
	#my $Rate = 0;
	my $Summary = $ELine - $BLine + 1; 
	for(my $i = $BLine - 1; $i < $ELine; $i++)
	{
		#print "$Sstring FFF";
		if($result[$i] eq "$Sstring")
		{
			$correct_count++;
		}
	}
	my $Rate = ($correct_count)/($Summary);
	print "$Sstring 的准确率为:\n";
	print flt_to_pct($Rate);
 }
 sub flt_to_pct {
    sprintf( "%.2f", shift ) * 100 . '%';
}

######################################################################
sub introducer
{
	#my ($tmpstring) = @_;
	my $tmpstring = shift;
	my @sbarallchild = SbarAllChildren($tmpstring);
    my @sbarallword = SbarAllword($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	my $length = scalar(@sbarallword)-scalar(@sbarsallword);
	if($length > 0.2)
	{
		splice(@sbarallword,$length);
	}
	else
	{
		@sbarallword = ();
	}
	my @void = ();
	if(scalar(@sbarallword) > 0.1)
	{
		return @sbarallword;
	}
	else
	{
		return @void;
	}
	
}
sub YinDaoXianxing
{
	my ($tmpstring,$nums) = @_;
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	if(scalar(@intro) == 0)
	{
		print"That 省略";
	}
	# if(scalar(@intro) == 1)
	# {
		# if()
	# }
	
	
}
 
#######################################################################
 
 #非定语从句
sub NONAttributive_Clauses
{
	#if不引导同位语
	my ($tmpstring,$nums) = @_;
	#print"$tmpstring \n";
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my @sbarchild = SbarAllChildren($tmpstring);
	my @sbarBeforePpYN = SbarPPWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	#my @sbarallword = SbarAllword($tmpstring);
	my @sbarppword = SbarPPWord($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @intro = introducer($tmpstring);
	#print "FFFFFFFFFFFFFFF\n";
	#my $tmpstring  = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
	my @sbarsschild = SbarSChild($tmpstring);
	my @lastelement = ();
	my $Sbarleftsilinglast;
	if(scalar(@sbarleftsiling) > 0.3)
	{
		$Sbarleftsilinglast = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]}[0];
	}
	my @sbarleftsilinglast1 = split(/\s/,$Sbarleftsilinglast);
	
	my $attr_intro = qr/\b(whose|whom|who|which)\b/i;
	my $nattr_introflag;
	if(scalar(@intro) == 0)
	{
		$nattr_introflag = 1;
	}
	else
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /$attr_intro/)
			{
				$nattr_introflag = 1;
			}
		}
	}
	
	
	foreach(@sbarleftsilinglast1 )
	{
		#print;
		#print"SSSS";
	}
	foreach(@sbarleftsiling)
	{	
		
		if("@$_" =~ /NP/)
		{	
			#print"@$_";
			@lastelement = @$_;
		}
	}
	my $Vi = qr/^(studied|speak|talk|XXX|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved)$/;
	#my @lastelement = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]};
	my @match = split(/\s/,"@lastelement");
	#my $NPstring = "@lastelement";
	my $Link_appos = qr/^(news|eagerness|question|demand|impression|truth|idea|words|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	#print $maintruck;
	my @maintruck1 = split(/-/,$maintruck);
	if($nattr_introflag == 1 and $tmpmaintruck == 1 and scalar(@sbarallword) > 0.3 and ($worD[$sbarallword[0] -2] =~ /,/ or $worD[$sbarallword[0] -3] =~ /,/))
	{
			#print $sbarallword[0]."AAAAAAA";
			if( scalar(@sbarsschild) > 0.3)
			{
				my $Vp = ();
				my $Np = ();
				foreach(@sbarsschild)
				{
					#print;
					if($_ eq "NP")
					{
						$Np = "NP";
					}
					if($_ eq "VP")
					{
						$Vp = "VP";
					}
				}
				if($Np ne "NP" or undef($Np))
				{
					 print"非定语从句	1";
					 $result[$nums] = "NXATC";
					 print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					 return 2;
				}

			}
			
			
			
			if(scalar(@intro) == 2 and scalar(@sbarleftsilinglast1) > 0.3 and $sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/)
			{
				my $intrOducer = qr/(whom|which|whose)/;
				if($poS[($intro[0]-1)] =~ /IN|RB/ and $worD[$intro[0]] =~ /$intrOducer/)
				{
					print"非定语从句	2";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if($worD[$sbarallword[0] -3] =~ /,/ and $poS[$sbarallword[0] -2] =~ /IN|RB|TO/ )
			{
				print"非定语从句	3";
				$result[$nums] = "NXATC";
			}
			if(scalar(@intro) == 1 and scalar(@sbarleftsilinglast1) > 0.3)
			{
				my $intrOducer = qr/(whom|which|whose)/;
				if($worD[$intro[0] -1 ] =~ /$intrOducer/)
				{
					print"非定语从句	4";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if(scalar(@sbarleftsilinglast1) > 0.3 and $sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/)
			{
				if($poS[$sbarallword[scalar(@sbarallword) -1] -1] =~ /IN/ and  $poS[$sbarallword[scalar(@sbarallword) -2] -1] =~ /^VB/)
				{
					print"非定语从句	5";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($poS[$sbarallword[scalar(@sbarallword) -1] -1] =~ /^VB/ and $worD[$sbarallword[scalar(@sbarallword) -1] -1] !~ /$Vi/)
				{
					print"非定语从句	6";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			
			
			
			#if()
			if(scalar(@sbarchild) == 2)
			{
				my $SString = $sbarchild[0];
				my @tmp = split(/\-/,$SString);
				my $tmpflag = 0;
				my $numberflag = ();
				for(my $i=0; $i<$#tmp; $i++)
				{
					if($tmp[$i] =~ /[A-Za-z][a-z]+|[0-9]+/ and $tmpflag == 0)
					{
						$numberflag = $i;
						$tmpflag = 1;
					}
					#if()
				}
				#print"$tmp[$numberflag]";
				for(my $i=0; $i<$#worD; $i++)
				{
					if($tmp[$numberflag] eq "$worD[$i]" and $poS[$i] =~ /IN/ and scalar(@match) > 0.3 and $match[0] eq "NP" and scalar(@match) > 0.5)
					{
						print"非定语从句	7";
						$result[$nums] = "NXATC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
				}
				
			}
			if(@sbarallword > 0.3 and @match > 0.3 and $sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/)
			{
				#print"FFFFF".$worD[$sbarppword[0]-1];
				if($worD[($sbarallword[scalar(@sbarallword)-1]) -1] !~ /$Vi/ and $poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^VB/)
				{
					print"非定语从句	8";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				# if($worD[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /$Vi/ and $poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^VB/ and scalar(@intro) == 1)
				# {
					# print"定语从句	Test1";
					# $result[$nums] = "XATC";
				# }
				if($poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /RP|IN|RB/ and $worD[($sbarallword[scalar(@sbarallword)-1]) -2] =~ /$Vi/)
				{
					print"非定语从句	9";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
				if($poS[($sbarallword[scalar(@sbarallword)-1]) -1] =~ /^IN$|^RB$/ and $poS[($sbarallword[scalar(@sbarallword)-1]) -2] =~ /^VB/)
				{
					print"非定语从句	10";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
				
					#my @SubSbarBeforePpYN = @{$sbarBeforePpYN[scalar(@sbarBeforePpYN) - 1]};
				if($worD[$sbarppword[0]-2] !~ /$Vi/ and $poS[$sbarppword[0]-2] =~ /^VB*[^G]$/ and @sbarppword > 0.3)
				{	
					print"非定语从句	11";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($worD[$sbarppword[0]-2] =~ /$Vi/ and $poS[$sbarppword[0]-2] =~ /^VB/ and scalar(@intro)==1 and $worD[$intro[0]-1] eq "that" and @sbarppword > 0.3)
				{
					print"非定语从句	12";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($worD[$sbarppword[0]-3] =~ /$Vi/ and $poS[$sbarppword[0]-2] =~ /RP|IN|RB/ and scalar(@intro)==1 and $worD[$intro[0]-1] eq "that" and @sbarppword > 0.3)
				{
					print"非定语从句	13";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
					# for(my $i = $sbarallword[0];$i<$sbarallword[scalar(@sbarallword) - 1];$i++)
					# {
						# if( ($worD[$i] eq "$SubSbarBeforePpYN[scalar(@SubSbarBeforePpYN)-1]" and $poS[$i] =~ /^IN/ and $poS[$i-1] =~ /^VB/) or ($worD[$i] eq "$SubSbarBeforePpYN[scalar(@SubSbarBeforePpYN)-1]" and $poS[$i] =~ /^VB*G$/))
						# {
							# print"定语从句	Test4";
							# $result[$nums] = "XATC";
						# }
					# }
				
				
				
				
			}
			if(@sbarallword > 0.3 and @match > 0.3 and $sbarleftsilinglast1[scalar(@sbarleftsilinglast1)-2] =~ /^NN/)
			{
				if(scalar(@intro)==1 and $worD[$intro[0]-1] =~ /why$|whom$/)
				{
					print"非定语从句	14";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro)== 0)
				{
					print"非定语从句	15";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if(($worD[$sbarallword[0] -2] =~ /,/ or $worD[$sbarallword[0] -3] =~ /,/) and $worD[$sbarallword[scalar(@sbarallword)-1] - 1] !~ /$Vi/ and $poS[$sbarallword[scalar(@sbarallword)-1] - 1] =~ /^VB/)
				{
					print"非定语从句	16";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			#if()
			#if(scalar(@sbarleftsiling) == 1 and @{$sbarleftsiling[0]}[0] =~ /^VB/ and @{$sbarleftsiling[0]}[scalar(@{$sbarleftsiling[0]})-1] =~ )
			# {
				
			# }

	}
	if(($sbarallword[0]-1) == 0 and $worD[$sbarallword[scalar(@sbarallword) - 1]] =~ /,/ and $nattr_introflag == 1)
	{
		my $jj;
		#print "GGGGG\n";
			my $ii = scalar(@sbarallword)-1;
				while($poS[$ii] =~ /IN|RB/)
				{
					$jj = $ii;
					$ii--;
				}				
			if(defined $jj)
			{
				if($worD[$jj-1] !~ /$Vi/ and $poS[$jj-1] =~/^VB/)
				{
					print"非定语从句	17";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			else
			{
				if($worD[$sbarallword[scalar(@sbarallword)-1] - 1] !~ /$Vi/ and $poS[$sbarallword[scalar(@sbarallword)-1] - 1] =~ /^VB/)
				{
					print"非定语从句	18";
					$result[$nums] = "NXATC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			
			if( scalar(@sbarsschild) > 0.3)
			{
				my $Vp = ();
				my $Np = ();
				foreach(@sbarsschild)
				{
					#print;
					if($_ eq "NP")
					{
						$Np = "NP";
					}
					if($_ eq "VP")
					{
						$Vp = "VP";
					}
				}
				if($Np ne "NP" or undef($Np))
				{
					 print"非定语从句	19";
					 $result[$nums] = "NXATC";
					 print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					 return 2;
				}

			}
			if( scalar(@sbarsschild) > 0.3)
			{
				my $Vp = ();
				my $Np = ();
				foreach(@sbarsschild)
				{
					#print;
					if($_ eq "NP")
					{
						$Np = "NP";
					}
					if($_ eq "VP")
					{
						$Vp = "VP";
					}
				}
				if($Np ne "NP" or undef($Np))
				{
					 print"非定语从句	20";
					 $result[$nums] = "NXATC";
					 print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					 return 2;
				}

			}
	}
	#return 0;
}
##############################################################################################################
 
 #目的状语从句
######################################################################################################################################################################
 sub PreADVC
 {
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my $purpose = qr/lest/;
	my $MD = qr/^(can|may|will|could|might|would|should)$/;
	#my @sbarallword = SbarAllword($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	
	if(scalar(@intro) == 1)
	{
		if($worD[$intro[0] - 1] =~ /^lest$|^that$/)
		{
			if($worD[$intro[0] - 1] =~ /^lest$/){print"目的状语从句	1";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
			if($worD[$intro[0] -2] =~ /\bfear\b/ and $worD[$intro[0] - 3] =~ /for/){print"目的状语从句	2";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
			if($worD[$intro[0] -2] =~ /\border\b/ and $worD[$intro[0] - 3] =~ /in/){print"目的状语从句	3";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
			if($worD[$intro[0] -2] =~ /\bso\b/i)
			{
				for(my $i = $sbarallword[0] -1;$i<$sbarallword[scalar[@sbarallword]-1];$i++)
				{
					if($worD[$i] =~ /$MD/)
					{
						print"目的状语从句 	4";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
					}
					
				}
			}
			if($worD[$intro[0] -2] =~ /\bhope\b/ and $worD[$intro[0] - 3] =~ /the/ and $worD[$intro[0] - 4] =~ /in/){print"目的状语从句	5";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
			if($worD[$intro[0] -2] =~ /\bend\b/ and $worD[$intro[0] - 3] =~ /the/ and $worD[$intro[0] - 4] =~ /to/){print"目的状语从句	6";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
			
		}
	}
	if(scalar(@intro) == 2)
	{
		if($worD[$intro[0] - 1] =~ /^lest$/ or $worD[$intro[0]] =~ /^lest$/){print"目的状语从句	7";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
		if($worD[$intro[0] -1] =~ /\bso\b/ and $worD[$intro[0]] =~ /^that$/)
		{
			for(my $i = $sbarallword[0] -1;$i<$sbarallword[scalar[@sbarallword]-1];$i++)
			{
				if($worD[$i] =~ /$MD/)
				{
					print"目的状语从句 	7";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
				}
				
			}
			print"目的状语从句	8";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
		}
	}
	if(scalar(@intro) == 0)
	{
		if($worD[$sbarallword[0]-2] =~ /case/ and $worD[$sbarallword[0]-3] =~/in/i)
		{
			print"目的或条件状语从句	9";$result[$nums] = "PADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
		}
	}
	
 }
#########################################################################################################################################
 
 
 #时间状语从句
 sub Time_ADV_Clause
 {
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	if( scalar(@sbarsschild) > 0.3 and $tmpmaintruck == 1)
		{
			my $Vp = ();
			my $Np = ();
			foreach(@sbarsschild)
			{
				#print;
				if($_ eq "NP")
				{
					$Np = "NP";
					#print "FFFF\n";
				}
				if($_ eq "VP")
				{
					$Vp = "VP";
				}
			}
			#print "SSSS\n";
			if(defined($Np))
			{
				#$worD[$sbarsallword[scalar(@sbarsallword)-1]] =~ /,/ and 
				if($worD[$sbarallword[0] - 1] =~ /^as$/ and $worD[$sbarallword[0] - 2] =~ /^soon$/i and $worD[$sbarallword[0] - 3] =~ /as/i)
				{
					print"时间状语从句	1";$result[$nums] = "TADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
				}
				if(scalar(@intro) > 0.3)
				{
					#print "$intro[0] DDD\n";
					for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
					{
						if($worD[$i] =~ /^(before|after|till|until)$/i){print"时间状语从句	2";$result[$nums] = "TADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;}
						#print"$worD[$i] \n";
					}
					if($poS[$intro[0]-1] =~ /^VB|^MD/ and $worD[$intro[0]-2] =~ /Sooner/i and $worD[$intro[0]-3] =~ /no/i)
					{
						print"时间状语从句	3";
						$result[$nums] = "TADVC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
					if($worD[$intro[0]-1] =~ /\bthan\b/)
					{
						#print "GDDD\n";
						for(my $i = 0;$i<$intro[0];$i++)
						{
							if($worD[$i] =~ /no/i and $worD[$i+1] =~ /sooner/i)
							{
								print"时间状语从句	4";
								$result[$nums] = "TADVC";
								print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
								return 2;
							}
						}
					}
				}
				if(scalar(@intro) == 0 and $worD[$sbarallword[0]-2] =~ /moment|minute|insant|second/ and $worD[$sbarallword[0]-3] =~ /^the$/i)
				{
					print"时间状语从句	5";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro) == 0 and $worD[$sbarallword[0]-2] =~ /time$/ and $worD[$sbarallword[0]-3] =~ /^(first|last|next)$/i and $worD[$sbarallword[0]-4] =~ /the$/i)
				{
					print"时间状语从句	6";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro) == 0 and $worD[$sbarallword[0]-2] =~ /^time$/ and $worD[$sbarallword[0]-3] =~ /^(every|each)$/i)
				{
					print"时间状语从句	7";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro) == 0 and $worD[$sbarallword[0]-2] =~ /time$/ and $worD[$sbarallword[0]-3] =~ /^(the)$/i and $worD[$sbarallword[0]-4] =~ /^by$/i)
				{
					print"时间状语从句	8";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if(scalar(@intro) == 0 and $worD[$sbarallword[0]-2] =~ /^(immediately|directly)$/i)
				{
					print"时间状语从句	9";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				if($worD[$intro[0]-1] =~ /^whenever$/i and $poS[$sbarallword[scalar(@sbarallword)-1]-1] !~ /^VB/)
				{
					
				}
				
			}
			
			

		}
 }
 
#######################################################################################################################################
sub Reason_Adv_Clasuse
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	
	if(scalar(@intro) == 1 or scalar(@intro) == 2)
	{
		if($worD[$intro[0]-1] =~ /^because$/ or $worD[$intro[0]-2] =~ /because/)
		{
			print"原因状语从句	1";$result[$nums] = "RADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
		}
		if($worD[$intro[0]] =~ /^that$/ and $worD[$intro[0]-1] =~ /^Seeing$|^considering$|^now$|^given$/i)
		{
			print"原因状语从句	1";$result[$nums] = "RADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
		}
	}

	
}
######################################################################################
sub WhereADVC
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	if( scalar(@sbarsschild) > 0.3 and $tmpmaintruck == 1)
	{
		if(scalar(@intro) == 0)
		{
			if($worD[$sbarallword[0]-2] =~ /^(anywhere|everywhere|wherever)$/ or $worD[$sbarallword[0]-1] =~ /^(anywhere|everywhere|wherever)$/)
			{
				print"地点状语从句	1";
				$result[$nums] = "WADVC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
		}
	}
}
#############################################################################################################
sub ConditionADVC
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $ifflag;
	if(scalar(@intro) > 0.3)
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /^if$/i)
			{
				$ifflag = 1;
			}
		}
	}
	my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved)$/;
	#my @lastelement = @{$sbarleftsiling[scalar(@sbarleftsiling)-1]};
	if(scalar(@sbarsschild) > 0.3 and $tmpmaintruck == 1)
	{
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /^if$/i and $poS[$intro[0]-2] !~ /^VB/ and $worD[$intro[0]-2] !~ /^(even|as)$/)
		{
			print"条件状语从句	1";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /^if$/i and $poS[$intro[0]-2] =~ /^VB/ and $worD[$intro[0]-2] !~ /$Vi/ and $worD[$intro[0]-2] !~ /even/)
		{
			print"条件状语从句	2";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if((scalar(@intro) == 1) and $worD[$intro[0]-1] =~ /^that$/ and $worD[$intro[0]-2] =~ /^(providing|provided|suppose|supposing)$/i and ($sbarallword[0] == 2 or $worD[$sbarallword[0]-2] =~ /,/))
		{
			print"条件状语从句	3";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if((scalar(@intro) == 0) and $worD[$sbarallword[0]-2] =~ /^(providing|provided|suppose|supposing)$/i )
		{
			print"条件状语从句	3";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if((scalar(@intro) == 1) and $worD[$sbarallword[0]-1] =~ /^(providing|provided|suppose|supposing)$/i )
		{
			print"条件状语从句	3";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /^that$/ and $worD[$intro[0]-2] =~ /^condition$/ and $worD[$intro[0]-3] =~ /^on$/i)
		{
			print"条件状语从句	4";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /^that$/ and $worD[$intro[0]-2] =~ /^event$/ and $worD[$intro[0]-3] =~ /^the$/i and $worD[$intro[0]-4] =~ /^in$/)
		{
			print"条件状语从句	4";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if((scalar(@intro) == 1) and $worD[$intro[0]-1] =~ /^unless$/i)
		{
			print"条件状语从句	3";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
	}
	if($ifflag ==1)
	{
		if($worD[$intro[0]-1] =~ /^if$/i)
		{
			print"条件状语从句	5";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
}
######################################################################################
sub ConcessionADVC
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @sbarsallword = SbarSAllWord($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $qstword = qr/(what|who|which|whose|when|where|how|why|whose|whoever|whomever|whosever|whatever|whichever|why|how|however)/i;
	my $qstwordever = qr/(whoever|whomever|whosever|whatever|whichever|however)/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|grow|was|were|felt|seemed|looked|appeared|sounded|stayed|became|grew)s?$/;
	#print $maintruck;
	if(scalar(@sbarsschild) )
	{
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /^(Although|Though)$/i and $worD[$intro[0]-2] !~ /^(as)$/i)
		{
			print"让步状语从句	1";
			$result[$nums] = "CCSADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /^(whether)$/i and $worD[$intro[0]-2] !~ /$Link_Verb/)
		{
			for(my $i = $sbarallword[0]-1;$i<$sbarallword[scalar(@sbarallword)-1];$i++)
			{
				if($worD[$i] =~ /^or$/)
				{
					print"让步状语从句	2";
					$result[$nums] = "CCSADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
		}
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /$qstword/i and $worD[$intro[0]-2] =~ /matter/ and $worD[$intro[0]-3] =~ /^no$/i)
		{
					print"让步状语从句	4";
					$result[$nums] = "CCSADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
		}
		if(scalar(@intro) == 1 and $worD[$intro[0]-1] =~ /$qstwordever/i)
		{
					print"让步状语从句	5";
					$result[$nums] = "CCSADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
		}
		if($worD[$sbarallword[0]-2] =~ /^(Granted|Granting|Admitting)$/i)
		{
					print"让步状语从句	";
					$result[$nums] = "CCSADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
		}
		if(scalar(@intro) == 2 and $worD[$intro[0]-1] =~ /^(even)$/i and $worD[$intro[0]] =~ /^(if|though)$/)
		{
			print"让步状语从句	3";
			$result[$nums] = "CCSADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if( $worD[$intro[0]-1] =~ /$qstword/i and $worD[$intro[0]-2] =~ /matter/ and $worD[$intro[0]-3] =~ /^no$/i)
		{
					print"让步状语从句	4";
					$result[$nums] = "CCSADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
		}
		
	}
}
############################################
sub RslADVC
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $MD = qr/^(can|may|will|could|might|would|should)$/;
	if($tmpmaintruck == 1)
	{
		if(scalar(@intro) == 1)
		{
			if($worD[$intro[0] - 1] =~ /^that$/ and $worD[$intro[0] -2] =~ /\bso\b/i)
			{
					for(my $i = $sbarallword[0] -1;$i<$sbarallword[scalar[@sbarallword]-1];$i++)
					{
						if($worD[$i] !~ /$MD/)
						{
							print"结果状语从句 	1";$result[$nums] = "RSLADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
						}
					}
			}
		}
		if(scalar(@intro) == 2)
		{
			if($worD[$intro[0] - 1] =~ /^that$/ and $worD[$intro[0]] =~ /\bso\b/i)
			{
					for(my $i = $sbarallword[0] -1;$i<$sbarallword[scalar[@sbarallword]-1];$i++)
					{
						if($worD[$i] !~ /$MD/)
						{
							print"结果状语从句 	2";$result[$nums] = "RSLADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
						}
					}
			}
		}
		if(scalar(@intro) == 1)
		{
			if($worD[$intro[0] - 1] =~ /^that$/ )
			{
					for(my $i = 0;$i<$sbarallword[0] -2;$i++)
					{
						if($worD[$i] =~ /^(so|such)$/)
						{
							print"结果状语从句 	3";$result[$nums] = "RSLADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
						}
					}
			}
			if($worD[$intro[0] - 1] =~ /^that$/ and $worD[$intro[0] - 2] =~ /^(degree|extent)$/ and $worD[$intro[0] - 3] =~ /^(to)$/ and $worD[$intro[0] - 4] =~ /^(to)$/i)
			{
				print"结果状语从句 	4";$result[$nums] = "RSLADVC";print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";return 2;
			}
		}
		
	}
}
#####################################################################################
sub MNADVC
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	if($tmpmaintruck == 1)
	{
		
	}
}

######################################################################################
sub ThSComplex
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring,$nums);
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
		if(($worD[$thsallword[0]-1] =~ /^(every|each)$/i and $worD[$thsallword[0]] =~ /time/) or ($worD[$thsallword[0]-1] =~ /^(the)$/i and $worD[$thsallword[0]] =~ /moment|minute|insant|second/))
		{
			print"ThS时间状语从句	1";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$thsallword[0]-1] =~ /^(the)$/i and $worD[$thsallword[0]] =~ /^(first|last)$/ and $worD[$thsallword[0]+1] =~ /^time$/)
		{
			print"ThS时间状语从句	2";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$thsallword[0]-1] =~ /^(by)$/i and $worD[$thsallword[0]] =~ /^(the)$/ and $worD[$thsallword[0]+1] =~ /^time$/)
		{
			print"ThS时间状语从句	3";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		#in case
		if($worD[$thsallword[0]-1] =~ /^(in)$/i and $worD[$thsallword[0]] =~ /^(case)$/)
		{
			print"ThS目的或者条件状语从句	4";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$thsallword[0]-1] =~ /^now$/i and $worD[$thsallword[0]] =~ /^(that)$/)
		{
			print"Ths	4";
			$result[$nums] = "RADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
	}
	if(scalar(@{$sub_location[$nums]}) > 1.9)
	{
		if($worD[0] =~ /^(providing|Provided|supposing|suppose)$/i)
		{
			print"Ths	条件状语从句4";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
	}
	if(scalar(@{$sub_location[$nums]}) > 1.9)
	{
		if($worD[0] =~ /^(Admitting|Granting|Granted)$/i)
		{
			print"Ths	让步状语从句4";
			$result[$nums] = "CCSADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
	}
	if(scalar(@{$sub_location[$nums]}) > 1.9)
	{
		for(my $i = @{$sub_location[$nums]}[0];$i < @{$sub_location[$nums]}[1];$i++)
		{
			if($worD[$i] =~ /(Admitting|Granting|Granted)/i and (@{$sub_location[$nums]}[1] - $i < 4))
			{
				print"Ths 让步状语从句	4";
				$result[$nums] = "CADVC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
		}
	}
	if(scalar(@{$sub_location[$nums]}) > 1.9)
	{
		for(my $i = @{$sub_location[$nums]}[0];$i < @{$sub_location[$nums]}[1];$i++)
		{
			if($worD[$i] =~ /(providing|Provided|supposing|suppose)/i and (@{$sub_location[$nums]}[1] - $i < 4))
			{
				print"Ths 条件状语从句	4";
				$result[$nums] = "CADVC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
			if($worD[$i] =~ /^condition$/ and $worD[$i-1] =~ /^on$/)
			{
				print"Ths	条件状语从句4";
				$result[$nums] = "CADVC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
		}
	}
	
	
	
}







#######################################################################################
#Out_Result();


###############################################################
#when引导的让步状语从句已做
sub When
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring,$nums);
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my @intro = introducer($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $whenflag = 0;
	my @maintruck1 = split(/-/,$maintruck);
	my @verb_and_loc = Predivate_Verb_and_Location();
	
	my $time_noun = qr/(year|month|day|hour|minute|second|century|ago|period|today|stage|tonight|morning|time|afternoon|noon|midday|noonday|afternoon|forenoon|moment|dawn|dark|night|nightfall|present|sunrise|past|now|future)s?/i;
	my $Neg_Aux_Verb = qr/^(am|is|are|was|were|be|been)$/;
	my $Vi = qr/^(start|started|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $Ving = qr/^(agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my $special_verb = qr/^(leave|put|discuss|doubt|left|discussed|doubted).s$/;
	my $special_verbing = qr/^(leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my $Link_appos = qr/^(news|demand|impression|truth|idea|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)s?$/;
	my $Link_Verbing = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)ing$/;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked
|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mail
ed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|pre
pared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|stea
l|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
	
	
	
	
	
	
	
	
	
	
	#my $Non_otherType_OnlyTAVCFlag;
	if(scalar(@intro) > 0.3)
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /^when$/i)
			{
				$whenflag = 1;
			}
		}
	}
	if($whenflag == 1)
	{
		#主语从句
		if($tmpmaintruck == 0)
		{
			for(my $i=0; $i<=$#maintruck1; $i++){
			if($maintruck1[$i] eq "SBAR" and $maintruck1[$i+1] eq "VP"){
				print "主语从句 when  1";
				$result[$nums] = "SC";
				#$Non_otherType_OnlyTAVCFlag = 1;
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
				}
			}
		}
		#宾语从句
		#if($tmpmaintruck == 1 and scalar(@intro) == 1)
			if($poS[$sbarallword[0]-2] =~ /^VB*[^G]/ and $worD[$sbarallword[0]-2] !~ /$Vi|$Link_Verb/ and $worD[$sbarallword[0]-3] !~ /$Neg_Aux_Verb/)
			{
				my $veb_loc = $sbarallword[0]-1;
				if(exists($verb_and_loc[$nums]->{$veb_loc}))
				{
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					print "宾语从句 when  11";
					$result[$nums] = "OC";
					
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				else
				{
					print "时间状语从句 when  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
			}
			if($poS[$sbarallword[0]-2] =~ /^VB/ and $worD[$sbarallword[0]-2] =~ /$Neg_Aux_Verb/)
			{
					print "时间状语从句 when  10";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
			}
			if($poS[$sbarallword[0]-2] =~ /^VB*[G]/ and $worD[$sbarallword[0]-2] =~ /$Vi|$Link_Verb/)
			{
					print "时间状语从句 when  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
			}
			if($poS[$sbarallword[0]-2] =~ /^VBG/ and $worD[$sbarallword[0]-2] !~ /$Ving|$Link_Verbing/)
			{
				my $veb_loc = $sbarallword[0]-1;
				if(exists($verb_and_loc[$nums]->{$veb_loc}))
				{
					print "宾语从句 when  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				else
				{
					print "时间状语从句 when  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "TADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if($poS[$sbarallword[0]-2] =~ /PRP|NN/ and $poS[$sbarallword[0]-3] =~ /^VB/ and $worD[$sbarallword[0]-3] =~ /$double_object/)
			{
				print "宾语从句 when  4";
				$result[$nums] = "OC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
			if($poS[$sbarallword[0]-2] =~ /^VB/ and $worD[$sbarallword[0]-2] =~ /$Vi|$Ving/)
			{
				print "时间状语从句 when  4";
				$result[$nums] = "TADVC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
		
		#同位语从句
		if($poS[$sbarallword[0]-2] =~ /^NN/ and $worD[$sbarallword[0]-2] =~ /$Link_appos/)
		{
			print "同位语从句 when  5";
			$result[$nums] = "AC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		#定语从句
		if($poS[$sbarallword[0]-2] =~ /^NN/ and $worD[$sbarallword[0]-2] =~ /$time_noun/)
		{
			print "定语从句 when  6";
			$result[$nums] = "XATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		#非限定定语从句
		if($worD[$sbarallword[0]-2] =~ /,/ and $poS[$sbarallword[0]-3] =~ /^NN/ and $worD[$sbarallword[0]-3] =~ /$time_noun/)
		{
			print "非定语从句 when  7";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$sbarallword[0]-2] =~ /,/ and $poS[$sbarallword[0]-3] =~ /^NN/ and $worD[$sbarallword[0]-3] !~ /$time_noun/)
		{
			print "时间状语从句 when  8";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
		if($worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/ and ($poS[$sbarallword[0]-1] !~ /^RB/ or $worD[$sbarallword[0]-1] =~ /when/i))
		{
			print "时间状语从句 when  9";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$sbarallword[0]-2] !~ /$time_noun/)
		{
			print "时间状语从句 when  8";
			$result[$nums] = "TADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
#####################################################While
sub While
	{
		my ($tmpstring,$nums) = @_;
		my @thsallword = ThSAllWord($tmpstring,$nums);
		my $tmpmaintruck = SubC($tmpstring);
		my $maintruck = MainTruck($tmpstring);
		my @maintrck = split('-',$maintruck);
		my @intro = introducer($tmpstring);
		my @sbarallword = SbarAllword($tmpstring);
		my @wOrd = Word();
		my @worD = @{$wOrd[$nums]};
		my @pOs = Pos();
		my @poS = @{$pOs[$nums]};
		my $whileflag = 0;
		my $continue_verb = /^(am|is|are|was|were|have|keep|know|lie|live|read|sing|sleep|smoke|stand|stay|study|wait|walk|watch|work)?s$/i;
		my $continue_verbed = /^(am|is|are|was|were|ha|keep|kept|knew|known|lay|lie|live|read|sing|sleep|smoke|stand|stay|study|wait|walk|watch|work)?(ed|d)$/i;
		my $continue_verbing = /^(am|is|are|was|were|hav|keep|know|ly|liv|read|sing|sleep|smok|stand|stay|study|wait|walk|watch|work)ing$/i;
		my @maintruck1 = split(/-/,$maintruck);
		my @verb_and_loc = Predivate_Verb_and_Location();
		if(scalar(@intro) > 0.3)
		{
			for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
			{
				if($worD[$i] =~ /^while$/i)
				{
					$whileflag = 1;
				}
			}
		}
		if($whileflag == 1 and $intro[0] > 2.1)
		{
			my ($leftverb,$rightverb);
			my $verb_flag;
			my ($leftstr,$rightstr);
			for(my $i = 0;$i<$intro[0];$i++)
			{
				if($poS[$i] =~ /MD|VB/)
				{
					$verb_flag = $i;
					last;
				}
			}
			#$str = $worD[$verb_flag];
			until($poS[$verb_flag] !~ /MD|VB/)
			{
				$leftstr .=  $poS[$verb_flag];
				$verb_flag++;
				
			}
			for(my $i = $intro[0];$i<$#worD;$i++)
			{
				if($poS[$i] =~ /MD|VB/)
				{
					$verb_flag = $i;
					last;
				}
			}
			#$str = $worD[$verb_flag];
			until($poS[$verb_flag] !~ /MD|VB/)
			{
				$rightstr .=  $poS[$verb_flag];
				$verb_flag++;
				
			}
			if($rightstr eq $leftstr)
			{
				print "并列句表转折 while  1 $rightstr";
				$result[$nums] = "CMBS";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
			if($rightstr ne $leftstr)
			{
				print "时间状语从句 while  1 $rightstr";
				$result[$nums] = "CMBS";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}
		}
		if($whileflag == 1 and $intro[0] == 1)
		{
			my ($leftverb,$rightverb);
			my $verb_flag;
			my ($leftstr,$rightstr);
			for(my $i = 0;$i<$sbarallword[scalar(@sbarallword)-1];$i++)
			{
				if($poS[$i] =~ /VB/)
				{
					$verb_flag = $i;
					last;
				}
			}
			#$str = $worD[$verb_flag];
			until($poS[$verb_flag] !~ /MD|VB/)
			{
				$leftstr .=  $poS[$verb_flag];
				$verb_flag++;
				
			}
			for(my $i = $sbarallword[scalar(@sbarallword)-1];$i<$#worD;$i++)
			{
				if($poS[$i] =~ /MD|VB/)
				{
					$verb_flag = $i;
					last;
				}
			}
			#$str = $worD[$verb_flag];
			until($poS[$verb_flag] !~ /MD|VB/)
			{
				$rightstr .=  $poS[$verb_flag];
				$verb_flag++;
				
			}
			###################句首为while暂时还没想到办法解决（让步和时间）
			# if($rightstr eq $leftstr)
			for(my $i = 0;$i<= $sbarallword[scalar(@sbarallword)-1];$i++)
			{
					#print $verb_and_loc[$nums]->{$i};
					if(exists $verb_and_loc[$nums]->{$i} and $poS[$i-1] !~ /VB/)
					{
						print "时间状语从句 while  1X";
						$result[$nums] = "TADVC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}
					if(exists $verb_and_loc[$nums]->{$i} and  $verb_and_loc[$nums]->{$i} =~ /$continue_verb|$continue_verbed|$continue_verbing/)
					{
						print "时间状语从句 while  2X";
						$result[$nums] = "TADVC";
						print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
						return 2;
					}

			}
			# {
				# print "并列句表转折 while  2 $rightstr";
				# $result[$nums] = "CMBS";
				# print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				# return 2;
			# }
		}

			
		
	}
	

######################################################################################################
sub Where
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring,$nums);
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my @intro = introducer($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $whenflag = 0;
	my @maintruck1 = split(/-/,$maintruck);
	my @verb_and_loc = Predivate_Verb_and_Location();
	
	my $place_noun = qr/(camp|school|bank|factory|classroom|station|mall|airport|cinema|hospital|river|lake|hotel|market|square|plaza|Forum|
piazza|place|palace|palace|alcazar|city|country|countyrside|village|area|town|mountain|province|municipality|region|desert|sea|forest|house|home|university|school|street)s?/i;
	my $Neg_Aux_Verb = qr/^(am|is|are|was|were|be|been)$/;
	my $Vi = qr/^(start|started|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $Ving = qr/^(agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my @sbarleftsiling = SbarLeftSibling($tmpstring);
	my $special_verb = qr/^(leave|put|discuss|doubt|left|discussed|doubted).s$/;
	my $special_verbing = qr/^(leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	my $Link_appos = qr/^(news|demand|impression|truth|idea|resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)s?$/;
	my $Link_Verbing = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)ing$/;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked
|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mail
ed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|pre
pared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|stea
l|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
	
	
	
	
	
	
	
	
	
	
	
	if(scalar(@intro) > 0.3)
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /^where$/i)
			{
				$whenflag = 1;
			}
		}
	}
	if($whenflag == 1)
	{
		#主语从句
		if($tmpmaintruck == 0)
		{
			for(my $i=0; $i<=$#maintruck1; $i++){
			if($maintruck1[$i] eq "SBAR" and $maintruck1[$i+1] eq "VP"){
				print "主语从句 where  1";
				$result[$nums] = "SC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
				}
			}
		}
		#宾语从句

			if($poS[$sbarallword[0]-2] =~ /^VB*[^G]/ and $worD[$sbarallword[0]-2] !~ /$Vi|$Link_Verb/ and $worD[$sbarallword[0]-3] !~ /$Neg_Aux_Verb/)
			{
				my $veb_loc = $sbarallword[0]-1;
				if(exists($verb_and_loc[$nums]->{$veb_loc}))
				{
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					print "宾语从句 where  11";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				else
				{
					print "宾语从句 where  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "WADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				
			}
			if($poS[$sbarallword[0]-2] =~ /^VB/ and $worD[$sbarallword[0]-2] =~ /$$Neg_Aux_Verb/)
			{
					print "时间状语从句 where  10";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "WADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
			}
			if($poS[$sbarallword[0]-2] =~ /^VB*[G]/ and $worD[$sbarallword[0]-2] =~ /$Vi|$Link_Verb/)
			{
					print "时间状语从句 where  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "WADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
			}
			if($poS[$sbarallword[0]-2] =~ /^VBG/ and $worD[$sbarallword[0]-2] !~ /$Ving|$Link_Verbing/)
			{
				my $veb_loc = $sbarallword[0]-1;
				if(exists($verb_and_loc[$nums]->{$veb_loc}))
				{
					print "宾语从句 where  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "OC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
				else
				{
					print "宾语从句 where  2";
					#print "$verb_and_loc[$nums]->{$veb_loc}  LLLLLLLLLLLLLLLLL\n";
					$result[$nums] = "WADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			if($poS[$sbarallword[0]-2] =~ /PRP|NN/ and $poS[$sbarallword[0]-3] =~ /^VB/ and $worD[$sbarallword[0]-3] =~ /$double_object/)
			{
				print "宾语从句 where  4";
				$result[$nums] = "OC";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;
			}

		#同位语从句
		if($poS[$sbarallword[0]-2] =~ /^NN/ and $worD[$sbarallword[0]-2] =~ /$Link_appos/)
		{
			print "同位语从句 where  5";
			$result[$nums] = "AC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		#定语从句
		if($poS[$sbarallword[0]-2] =~ /^NN/ and $worD[$sbarallword[0]-2] =~ /$place_noun/)
		{
			print "定语从句 where  6";
			$result[$nums] = "XATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		#非限定定语从句
		if($worD[$sbarallword[0]-2] =~ /,/ and $poS[$sbarallword[0]-3] =~ /^NN/ and $worD[$sbarallword[0]-3] =~ /$place_noun/)
		{
			print "定语从句 where  7";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$sbarallword[0]-2] =~ /,/ and $poS[$sbarallword[0]-3] =~ /^NN/ and $worD[$sbarallword[0]-3] !~ /$place_noun/)
		{
			print "地点状语从句 where  8";
			$result[$nums] = "WADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/ and ($poS[$sbarallword[0]-1] !~ /^RB/ or $worD[$sbarallword[0]-1] =~ /where/i))
		{
			print "地点状语从句 where  9";
			$result[$nums] = "WADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$sbarallword[0]-2] !~ /$place_noun/)
		{
			print "时间状语从句 when  10";
			$result[$nums] = "WADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
	}
	

	
	
}
#############################################################################
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

#######################################################################################
sub As
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring,$nums);
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my @intro = introducer($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $asflag = 0;
	my @maintruck1 = split(/-/,$maintruck);
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|look|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|sounded|stayed|became)s?$/;
	my $be = qr/^(are|been|am|is|be|were|was)$/;
	my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $Ving = qr/^(rained|rain|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)ing$/;
	if(scalar(@intro) > 0.3)
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /^as$/i)
			{
				$asflag = 1;
			}
		}
	}
	my $Vp = ();
	my $Np = ();
	foreach(@sbarsschild)
	{
		#print;
		if($_ eq "NP")
		{
			$Np = "NP";
			#print "FFFF\n";
		}
		if($_ eq "VP")
		{
			$Vp = "VP";
		}
	}
	if($asflag == 1)
	{
		#非限定定语从句
		if($intro[0]-1 == 0 and $worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/ and !defined($Np))
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  1";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($intro[0]-1 == 0 and $worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/ and $poS[$sbarallword[scalar(@sbarallword)-2]] =~ /^VB*[G]$/ and $worD[$sbarallword[scalar(@sbarallword)-3]] !~ /$be/ and $worD[$sbarallword[scalar(@sbarallword)-2]] !~ /$Vi/)
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  2";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(($worD[$intro[0]-2] =~ /,/ or $worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/) and $poS[$sbarallword[scalar(@sbarallword)-2]] =~ /^(IN|RB)$/ and $poS[$sbarallword[scalar(@sbarallword)-3]] =~ /VB/ and $worD[$sbarallword[scalar(@sbarallword)-2]] =~ /after|against|away/)
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  2";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if( ($worD[$intro[0]-2] =~ /,/ or $worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/) and $poS[$sbarallword[scalar(@sbarallword)-2]] =~ /^(IN|RB)$/ and $worD[$sbarallword[scalar(@sbarallword)-2]] =~ /^(on|in|into|for|to|with|from)$/)
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  2";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if( ($worD[$intro[0]-2] =~ /,/ or $worD[$sbarallword[scalar(@sbarallword)-1]] =~ /,/) and $poS[$sbarallword[scalar(@sbarallword)-2]] =~ /^VB[G]$/ and $worD[$sbarallword[scalar(@sbarallword)-3]] =~ /$be/ and $worD[$sbarallword[scalar(@sbarallword)-2]] !~ /$Vi/)
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  3";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$intro[0]-2] =~ /,/ and !defined($Np))
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  4";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$intro[0]-2] =~ /,/ and $poS[$sbarallword[scalar(@sbarallword)-2]] =~ /^VB[G]$/ and $worD[$sbarallword[scalar(@sbarallword)-3]] =~ /$be/ and $worD[$sbarallword[scalar(@sbarallword)-2]] !~ /$Vi/)
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  5";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$intro[0]-2] =~ /,/ and $poS[$sbarallword[scalar(@sbarallword)-2]] =~ /^VB*[G]$/ and $worD[$sbarallword[scalar(@sbarallword)-3]] !~ /$be/ and $worD[$sbarallword[scalar(@sbarallword)-2]] !~ /$Vi/)
		{
			#print $worD[$sbarallword[scalar(@sbarallword)-1]];
			print "非限定定语从句  6";
			$result[$nums] = "NXATC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($sbarallword[0]-3 > 0.3 and $worD[$sbarallword[0]-2] !~ /^(soon|long)$/)
		{
			for(my $i = 0;$i<$sbarallword[0]-1;$i++)
			{
				if($worD[$i] =~ /$(as|so)$/ and $worD[$i+1] =~ /JJ|RB/)
				{
					print "比较状语从句  7";
					$result[$nums] = "CMPADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;
				}
			}
			
		}
		if(($intro[0]-1 == 0 or $intro[0]-1 == 1) and $poS[0] =~ /RB|JJ|NN|VB/ and $worD[0] !~ /^as$/ and $worD[1] =~ /^as$/)
		{
			print "让步状语从句  8";
			$result[$nums] = "CCSADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(scalar(@intro) == 1 and$worD[$intro[0]-2] =~ /^(long)$/ and $worD[$sbarallword[0]-3] =~ /$(as|so)$/)
		{
			print "比较状语从句  7";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(scalar(@intro) == 2 and$worD[$intro[0]-1] =~ /^(long)$/ and $worD[$sbarallword[0]-2] =~ /$(as|so)$/)
		{
			print "条件状语从句  8";
			$result[$nums] = "CADVC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if(($poS[$intro[0]-2] =~ /RB/ and $worD[$intro[0]-3] =~ /$Link_Verb/) or $worD[$intro[0]-2] =~ /$Link_Verb/)
		{
			print "表语从句  8";
			$result[$nums] = "PC";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		
		
		
		
	}
}

#######################################################
sub SinceIf
{
	my ($tmpstring,$nums) = @_;
	my $tmpmaintruck = SubC($tmpstring);
	my @intro = introducer($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my $sinceflag = 0;
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	if(scalar(@intro) > 0.3)
	{
		for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++)
		{
			if($worD[$i] =~ /^since$/i)
			{
				$sinceflag = 1;
			}
		}
	}
	if($sinceflag == 1)
	{
		if(scalar(@intro) == 1 and $intro[0] >= 2.1)
		{
			for(my $i =0 ;$i<$sbarallword[0];$i++)
			{
				if( ($worD[$i] =~ /^(has|have|had)$/i and $poS[$i+1] =~ /^VB/) or ($worD[$i] =~ /^(has|have|had)$/i and $poS[$i+1] =~ /RB/ and $poS[$i+2] =~ /^VB/))
				{
					for(my $j = $sbarallword[0];$j<$#worD;$j++)
					{
						if( ($worD[$j] =~ /^(has|have|had)$/i and $poS[$j+1] =~ /^VB/) or ($worD[$j] !~ /^(has|have|had)$/i and $poS[$j+1] =~ /RB/ and $poS[$j+2] =~ /^VB/))
						{
							print "原因状语从句  1";
							$result[$nums] = "RADVC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
						else
						{
							print "时间状语从句  1";
							$result[$nums] = "TADVC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
					}

				}
				if( $worD[$i] =~ /^(has|have|had)$/i )
				{
					for(my $j = $sbarallword[0];$j<$#worD;$j++)
					{
						if( $worD[$j] !~ /^(has|have|had)$/i )
						{
							print "原因状语从句  1";
							$result[$nums] = "RADVC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
					}

				}
			}
			for(my $i = $sbarallword[0];$i<$#worD;$i++)
			{
				if( ($worD[$i] =~ /^(has|have|had)$/i and $poS[$i+1] =~ /^VB/) or ($worD[$i] =~ /^(has|have|had)$/i and $poS[$i+1] =~ /RB/ and $poS[$i+2] =~ /^VB/))
				{
					for(my $j = 0;$j<$sbarallword[0];$j++)
					{
						if( ($worD[$j] =~ /^(has|have|had)$/i and $poS[$j+1] =~ /^VB/) or ($worD[$j] !~ /^(has|have|had)$/i and $poS[$j+1] =~ /RB/ and $poS[$j+2] =~ /^VB/))
						{
							print "原因状语从句  1";
							$result[$nums] = "RADVC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
						else
						{
							print "时间状语从句  1";
							$result[$nums] = "TADVC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
					}

				}
				if( $worD[$i] =~ /^(has|have|had)$/i )
				{
					for(my $j = $sbarallword[0];$j<$#worD;$j++)
					{
						if( $worD[$j] !~ /^(has|have|had)$/i )
						{
							print "原因状语从句  1";
							$result[$nums] = "RADVC";
							print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
							return 2;
						}
					}

				}
			}
			
		}
		if(scalar(@intro) == 1 and $intro[0] == 1)
		{
					print "原因状语从句  3";
					$result[$nums] = "RADVC";
					print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
					return 2;

		}
		
	}
}


#############################################################################################
sub CmpAdvc
{
	my ($tmpstring,$nums) = @_;
	my @thsallword = ThSAllWord($tmpstring,$nums);
	my $tmpmaintruck = SubC($tmpstring);
	my $maintruck = MainTruck($tmpstring);
	my @maintrck = split('-',$maintruck);
	my @intro = introducer($tmpstring);
	my @sbarallword = SbarAllword($tmpstring);
	my @sbarsschild = SbarSChild($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my $asflag = 0;
	my @maintruck1 = split(/-/,$maintruck);
	if(scalar(@intro) == 1)
	{
		
	}
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
	foreach(@maintrck){print"$_\n";}
	grep{$cc =1 if /^CC$/} @maintrck;
	#foreach(@thfstsallword){print"$_ PPPP\n";}
	#print "$worD[$thfstsallword[scalar(@thfstsallword)-1]-1]  LLL\n";
	if($cc == 1)
	{
		if($worD[$thccall[0]-1] =~ /and/i and $poS[$thccall[0]] ne $poS[$thccall[0]-2])
		{
			print "并列句  and";
			$result[$nums] = "CMAS";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$thccall[0]-1] =~ /but/i)
		{
			for(my $i = 0;$i<=$thccall[0];$i++)
			{
				if($worD[$i] =~ /^(not|'t)$/i and $worD[$i+1] =~ /^(only)$/i)
				{print "并列句  and";
				$result[$nums] = "CMAS";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;}
			}
		}
	}
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
	foreach(@maintrck){print"$_\n";}
	grep{$cc =1 if /^CC$/} @maintrck;
	#foreach(@thfstsallword){print"$_ PPPP\n";}
	print "$worD[$thfstsallword[scalar(@thfstsallword)-1]-1]  LLL\n";
	if($cc == 1)
	{
		if($worD[$thccall[0]-1] =~ /yet/i and $poS[$thccall[0]] ne $poS[$thccall[0]-2])
		{
			print "并列句  and";
			$result[$nums] = "CMBS";
			print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
			return 2;
		}
		if($worD[$thccall[0]-1] =~ /but/i)
		{
			for(my $i = 0;$i<=$thccall[0];$i++)
			{
				if($worD[$i] !~ /^(not|'t)$/i and $worD[$i+1] !~ /^(only)$/i)
				{print "并列句  and";
				$result[$nums] = "CMBS";
				print "第",$nums+1,"句是复杂句 : @{$Word[$nums]}\n";
				return 2;}
			}
		}
	}
}
#sub Ref
# foreach(@NerSent)
# {
	# print"$_ KKKKK\n"
# }
# ppath($dirname);
# sub ppath
# {
	# my $path = shift;
	# for my $file (glob "$path")
	# {
		# if(-d $file)
		# {
			# my $DIR;
			# opendir($DIR,"..") || die "Can not open this directory";
			# my @filelist = readdir($DIR); 
			# foreach(@filelist)
			# {
				# print $_;
				# print"DDD\n";
			# }
			# #chdir ($file);
			# #print $file."\n";
			
			# # if($file =~ /.*\/Jar$/i)
			# # {
				# # print $file."\n";
				# # my ($dirnam1, $outNam2) = $file =~ /(.*)\/(.*)/;
				# # return $dirnam1;
			# # }
			# # #ppath($file);
			# #chdir("..");
			
		# }
	# }
# }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 