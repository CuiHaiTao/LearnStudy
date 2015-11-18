package MulTree;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(TestTraverse ThSAllWord SbarNumber SbarSAllWord SbarPPWord SbarAllword ThCCAllWord SbarPPWord SbarSChild MainTruck SbarLeftSibling SbarAllFather ThreeRlatSbar SbarAllChildren SbarRightSibling SbarFather);


use strict;

my $Sbarnumber = 0;
my $Sbarfather = ();
my $SbarFatherNumber = 0;
my $SbarFlag = 0;
#@ARGV || die;
#my ($Text) = @ARGV;
# foreach(@Three_Layer)
# {
	# print "$_\n";
# }
 #my $SSS = scalar(@{$$ref{'children'}});
# print "$SSS \n";
# foreach(@{${@{$$ref{'children'}}[0]}{'children'}})
# {
	# #print $$_{'name'};
# }
#print ${'name'};

sub MulTree
{
	my $string = shift;
	$string =~ s/\$//g;
	my $locate = 0;
	my @array = ();
	my @chars = split("",$string);
	
	my $rootref = ();
	my $parentref = ();
	my $name;
	my $layer = 0;
	for(my $i=0; $i<=$#chars; $i++)
	{
		my $c = $chars[$i];
		if($c eq '(')
		{
			$layer++;
			if(scalar(@array) != 0)
			{
				$parentref = pop(@array);
				push(@array,$parentref);
			}
		}
		elsif($c eq ')')
		{
			$layer--;
			if(scalar(@array) != 0)
			{
				pop(@array);
			}
			if($chars[$i-1] =~ /[A-Za-z0-9,';\."]/)############开始计数
			{
				$locate++;
			}
		}
		elsif($c ne ' ')
		{
			#print " $c \n";
			$name .= $c;
			if($chars[$i+1] !~ /[0-9A-Za-z]/)
			{
				
				my $hashref = {'name' => undef ,'children'=> [],'layer' => undef,'locate' => undef};
				$$hashref{'name'} = $name;
				$$hashref{'layer'} = $layer;
				if($chars[$i+1] =~ /\)/)
				{
					$$hashref{'locate'} = $locate+1;
					#print "$name NNAA\n";
				}
				$name =();
				if($parentref eq '')
				{
					
					 $rootref = $hashref;
					 $parentref = $hashref;
				}
				else
				{
					if($chars[$i+1] ne ')')
					{
						push(@{$$parentref{'children'}},$hashref);#
					}
					else
					{
						$$hashref{'layer'} = $layer+1;
						$parentref = pop(@array);
						push(@{$$parentref{'children'}},$hashref);
						
					}
				}
				push(@array,$hashref);
			}
		}
	}
	return $rootref;
}
##############################################################################

sub TestTraverse
{
	my $string = shift;
	my $reff = MulTree($string);
	traverseone($reff);
}
sub traverseone
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	print $$reff{'name'}."   TEST\n";
	
	&traversetwo($reff);
	#my $tmp = ();
	
}
#################################


sub traversetwo
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 # if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $count > 1)
		 # {
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# print @{$$reff1{'children'}}[$i]->{'name'};
			# }
		 # }
		&traverseone(@{$$reff1{'children'}}[$i]);
		 
		
	}
}











########################################################################
my $Maintruck = ();
my @SbarFatherSilingAndSbar = ();
my $Fonce = 0;
my $FFonce = 0;
my $Lonce = 0;
sub traverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	if($$reff{'name'} eq "SBAR")
	{
		#print"$$reff{'name'}\n";
		$Sbarnumber++;
	}
	if($$reff{'layer'} == 3)
	{
		$Maintruck .= $$reff{'name'}."-";
	}
	&traverse2($reff);
	#my $tmp = ();
	
}


sub traverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	#my $count = ;
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&traverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}

sub SbarNumber
{
	my $string = shift;
	my $reff = MulTree($string);
	traverse1($reff);
	my $tmpSbarNumber =$Sbarnumber;
	$Sbarnumber = 0;
	$Maintruck = ();
	return $tmpSbarNumber;
}

sub MainTruck
{
	my $string = shift;
	my $reff = MulTree($string);
	traverse1($reff);
	$Sbarnumber = 0;
	$Maintruck =~ s/\-$//g;
	my $rtn = $Maintruck;
	$Maintruck = ();
	return $rtn;
}

my @arr2;
my $SbarSilingTraverseString = ();
my $SbarRSilingTraverseString = ();
sub SbarSilingTraverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#push(@arr1,$$reff{'name'});
	#print $$reff{'name'}."\n";
	#print @{$$reff{'children'}};
	&SbarSilingTraverse2($reff);
	#my $tmp = ();
	
}
sub SbarSilingTraverse11
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	$SbarSilingTraverseString .= "$$reff{'name'}-";
	#push(@arr1,$$reff{'name'});
	#print "$$reff{'name'}";
	&SbarSilingTraverse22($reff);
	#my $tmp = ();
	
}
sub SbarSilingTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 # if((@{$$reff1{'children'}}[$count-1]->{'name'}) eq "SBAR" and $count > 1)
		 # {
			# our $Flag = 1;
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# &SbarSilingTraverse11(@{$$reff1{'children'}}[$i]);
				
			# }
		 # }
		&SbarSilingTraverse11(@{$$reff1{'children'}}[$i]);
		
	}
}

sub SbarSilingTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $Lonce ==0)
		 {
			 #$SbarFather  =$$reff1{'name'};
			 #$SbarFatherNumber  =$$reff1{'layer'};
			 
				for(my $j=0; $j<$i; $j++)
				{
					#print @{$$reff1{'children'}}[$i]->{'name'}."\n";
					&SbarSilingTraverse11(@{$$reff1{'children'}}[$j]);
					$SbarSilingTraverseString =~ s/\-$//;
					push(@arr2,$SbarSilingTraverseString);
					# foreach(@arr1)
					# {
					# print;
					# }
					# print"\n";
					$SbarSilingTraverseString = ();
					push(@arr2,"0000");
					$Lonce = 1;
				}
			
			#@arr1 = ();
		 }
		&SbarSilingTraverse1(@{$$reff1{'children'}}[$i]);
		#@arr1 = ();
		
	}
}

####################################################################################################################
my $SbarAtPPBefore1To2WordFlag = 0;
my @PPLocate = ();
my $SbarSilingTraverseStringX = ();
my $SbarAttPPBefNumber = 0;

sub SbarPPWord
{
	my $string = shift;
	my $reff = MulTree($string);
	traverse1SbarAtPPBefore1To2Word($reff);
	my @tmp = @PPLocate;
	@PPLocate = ();
	$SbarSilingTraverseStringX = ();
	$SbarAttPPBefNumber = 0;
	$SbarAtPPBefore1To2WordFlag = 0;
	#print " @{$SbarSiblingArr[0]}[0] \n";
	return @tmp;
	
}


sub traverse1SbarAtPPBefore1To2Word
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	if($$reff{'name'} =~ /^SBAR$/ and $SbarAtPPBefore1To2WordFlag == 0)
	{
		$SbarAtPPBefore1To2WordFlag = 1;
		traverse11SbarAtPPBefore1To2Word($reff);
		#print "$$reff{'name'}";
	}
	&traverse2SbarAtPPBefore1To2Word($reff);
	#my $tmp = ();
	
}


sub traverse2SbarAtPPBefore1To2Word
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		# if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $count > 1)
		 # {
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# print @{$$reff1{'children'}}[$i]->{'name'};
			# }
		 # }
		&traverse1SbarAtPPBefore1To2Word(@{$$reff1{'children'}}[$i]);
		 
		
	}
}

sub traverse11SbarAtPPBefore1To2Word
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#$SbarSilingTraverseStringX .= "$$reff{'name'}-";
	#print $SbarSilingTraverseStringX;
	&traverse22SbarAtPPBefore1To2Word($reff);
	#my $tmp = ();
	
}
sub traverse111SbarAtPPBefore1To2Word
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
		if(defined @{$$reff{'children'}}[$i]->{'locate'})
		{
			push(@PPLocate,@{$$reff{'children'}}[$i]->{'locate'});
		}
	}
	

	#print $SbarSilingTraverseStringX;
	&traverse222SbarAtPPBefore1To2Word($reff);
	#my $tmp = ();
	
}


sub traverse222SbarAtPPBefore1To2Word
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		# if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $count > 1)
		 # {
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# print @{$$reff1{'children'}}[$i]->{'name'};
			# }
		 # }
		&traverse111SbarAtPPBefore1To2Word(@{$$reff1{'children'}}[$i]);
		 
		
	}
}
sub traverse22SbarAtPPBefore1To2Word
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 if(($$reff1{'name'}) eq "PP" and $SbarAttPPBefNumber == 0)
		 {
					#print @{$$reff1{'children'}}[$i]->{'name'}."\n";
					&traverse111SbarAtPPBefore1To2Word($reff1);
					$SbarAttPPBefNumber =1;
				
		 }
		 # {
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# print @{$$reff1{'children'}}[$i]->{'name'};
			# }
		 # }
		&traverse11SbarAtPPBefore1To2Word(@{$$reff1{'children'}}[$i]);
		 
		
	}
}
#####################################################################################################################


sub SbarFather
{
	my $string = shift;
	my $reff = MulTree($string);
	SbarFatherSilingTraverse1($reff);
	my $fnmae= $Sbarfather;
	my $flayer = $SbarFatherNumber;
	#print "$fnmae  kkkk";
	$Sbarfather = ();
	$SbarFatherNumber = 0;
	$SbarFlag = 0;
	my @arr = ();
	push(@arr,($fnmae,$flayer));
	return @arr;
}
sub SbarLeftSibling
{
	my $string = shift;
	my $reff = MulTree($string);
	SbarSilingTraverse1($reff);
	my @SbarSiblingArr = ();
	pop(@arr2);
	my $count = 0;
	for(my $i=0; $i<=$#arr2; $i++)
	{
		my @tmp = split(/\-/,$arr2[$i]);
		my $tmparr = "@tmp";
		if($arr2[$i] eq "0000")
		{
			
		}
		else
		{
			push(@{$SbarSiblingArr[$count]},$tmparr);
		}
		if($arr2[$i] eq "0000")
		{
			$count++;
		}
		#shift(@arr2);
	}
	@arr2 = ();
	$Lonce = 0;
	#print " @{$SbarSiblingArr[0]}[0] \n";
	return @SbarSiblingArr;
	
}


sub SbarFatherSilingTraverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	&SbarFatherSilingTraverse2($reff);
	#my $tmp = ();
	
}


sub SbarFatherSilingTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		# print "@{$$reff1{'children'}}[$i]->{'name'} OOO\n";
		  if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $SbarFlag == 0)
		  {
			$Sbarfather = $$reff1{'name'};
			$SbarFatherNumber = $$reff1{'layer'};
			$SbarFlag = 1;
			#print"$Sbarfather DDD\n";
		  }
		&SbarFatherSilingTraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}







################
my @rarr2 = ();
my $Ronce = 0;
sub SbarRSilingTraverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#push(@arr1,$$reff{'name'});
	#print $$reff{'name'}."\n";
	#print @{$$reff{'children'}};
	&SbarRSilingTraverse2($reff);
	#my $tmp = ();
	
}
sub SbarRSilingTraverse11
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	$SbarRSilingTraverseString .= "$$reff{'name'}-";
	#push(@arr1,$$reff{'name'});
	#print "$$reff{'name'}";
	&SbarRSilingTraverse22($reff);
	#my $tmp = ();
	
}
sub SbarRSilingTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 # if((@{$$reff1{'children'}}[$count-1]->{'name'}) eq "SBAR" and $count > 1)
		 # {
			# our $Flag = 1;
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# &SbarSilingTraverse11(@{$$reff1{'children'}}[$i]);
				
			# }
		 # }
		&SbarRSilingTraverse11(@{$$reff1{'children'}}[$i]);
		
	}
}


sub SbarRSilingTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $Ronce ==0)
		 {
			 #$SbarFather  =$$reff1{'name'};
			 #$SbarFatherNumber  =$$reff1{'layer'};
			 my $j = $i+1;
				for(my $i=$j; $i<$count; $i++)
				{
					#print @{$$reff1{'children'}}[$i]->{'name'}."\n";
					&SbarRSilingTraverse11(@{$$reff1{'children'}}[$i]);
					$SbarRSilingTraverseString =~ s/\-$//;
					push(@rarr2,$SbarRSilingTraverseString);
					# foreach(@arr1)
					# {
					# print;
					# }
					 #print"$SbarRSilingTraverseString \n";
					$SbarRSilingTraverseString = ();
					push(@rarr2,"0000");
					$Ronce = 1;
				}
			
			#@arr1 = ();
		 }
		&SbarRSilingTraverse1(@{$$reff1{'children'}}[$i]);
		#@arr1 = ();
		
	}
}
sub SbarRightSibling
{
	my $string = shift;
	my $reff = MulTree($string);
	SbarRSilingTraverse1($reff);
	my @SbarSiblingArr = ();
	pop(@rarr2);
	for(my $i=0; $i<=$#rarr2; $i++)
	{
		my @tmp = split(/\-/,$rarr2[$i]);
		my @tmparr = @tmp;
		#print "$rarr2[$i]\n";
		if($rarr2[$i] eq "0000")
		{
			
		}
		else
		{
			push(@SbarSiblingArr,\@tmp);
		}
		
		#shift(@arr2);
	}
	@rarr2 = ();
	$Ronce = 0;
	return @SbarSiblingArr;
}
#################################
my $text = ();
my @LChild = ();
sub LCSbarTraverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	if($$reff{'name'} eq "SBAR"  and $FFonce == 0)
		  {
			$FFonce =1 ;
			for(my $i=0; $i<$count; $i++)
			{
				#print"AAAAAAAAAAAA\n";
				&LCSbarTraverse11(@{$$reff{'children'}}[$i]);
				$text =~ s/\-$//g;
				push(@LChild,$text);
				$text = ();

			}
			#$SbarFather = $$reff1{'name'};
			#$SbarFatherNumber = $$reff1{'layer'};
			
		  }
	
	&LCSbarTraverse2($reff);
	#my $tmp = ();
	
}


sub LCSbarTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		  
		&LCSbarTraverse1(@{$$reff1{'children'}}[$i]);
	}
	
	
}
sub LCSbarTraverse11
{
	my ($reff) = shift;
	#print "$$reff{'name'} \n";
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	$text .= $$reff{'name'}."-";
	#print "$text \n";
	&LCSbarTraverse22($reff);
	#my $tmp = ();
	
}


sub LCSbarTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		&LCSbarTraverse11(@{$$reff1{'children'}}[$i]);
	}
	
	
}


sub SbarAllChildren
{
	my $string = shift;
	my $reff = MulTree($string);
	LCSbarTraverse1($reff);
	$FFonce = 0;
	my @tmpout = @LChild;
	@LChild = ();
	return @tmpout;
	
}

my $Fallonce == 0;
sub FSbarFatherSilingTraverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
	

		#print"$Sbarfather  \n";
		if((@{$$reff{'children'}}[$i]->{'name'}) eq "$Sbarfather" and @{$$reff{'children'}}[$i]->{'layer'} == $SbarFatherNumber)
		{
			for(my $j=0; $j<$count; $j++)
			{
				push(@SbarFatherSilingAndSbar,@{$$reff{'children'}}[$j]->{'name'});
			}
		}

	}
	
	&FSbarFatherSilingTraverse2($reff);
	#my $tmp = ();
	
}


sub FSbarFatherSilingTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		  if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $Fallonce == 0)
		  {
			#print"$$reff1{'name'}  kkk\n";
			$Sbarfather = $$reff1{'name'};
			$SbarFatherNumber = $$reff1{'layer'};
			$Fallonce = 1;
		  }
		&FSbarFatherSilingTraverse1(@{$$reff1{'children'}}[$i]);
	}
}
sub SbarAllFather
{
	my $string = shift;
	my $reff = MulTree($string);
	FSbarFatherSilingTraverse1($reff);
	FSbarFatherSilingTraverse1($reff);
	$Fallonce = 0;
	$Sbarfather = ();
	#print "FFFF\n";
	$SbarFatherNumber = 0;
	my @tmpout = @SbarFatherSilingAndSbar;
	@SbarFatherSilingAndSbar = ();
	return @tmpout;
	
}
my $ThFlag = 0;
my $FnlRsl = 0;
sub Thtraverse1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#print "\n";
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	
	if($$reff{'layer'} == 3)
	{
		$ThFlag++;
		#print "$$reff{'name'} DDD\n";
	}
	&Thtraverse2($reff);
	#my $tmp = ();
	
}


sub Thtraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		 # if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $count > 1)
		 # {
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# print @{$$reff1{'children'}}[$i]->{'name'};
			# }
		 # }
		 if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $Fonce == 0)
		  {
			$FnlRsl = $ThFlag;
			$Fonce = 1;
		  }
		 
		&Thtraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}

sub ThreeRlatSbar
{
	my $string = shift;
	my $reff = MulTree($string);
	Thtraverse1($reff);
	my $rsl = $FnlRsl;
    $FnlRsl = 0;
	$Fonce = 0;
	$ThFlag = 0;
	return $rsl;
}

######################################################################################
my  $commonref = ();
my  $tmpapposonce = 0;
my @tmpapposarr =();

sub traverseappos1
{
	my ($reff) = shift;
	#print $$reff{'name'};
	#print"\t";
	#print $$reff{'layer'};
	#local $xflag = 0;
	#print "\n";)
	# if( $$reff{'layer'} == 3)
	# {
		# push(@Three_Layer,$$reff{'name'});
	# }
	#print @{$$reff{'children'}};
	if(defined $commonref and $tmpapposonce == 1)
	{
		my $count = scalar(@{$$commonref{'children'}});
		for(my $i=0; $i<$count; $i++)
		{
			push(@tmpapposarr,"@{$$commonref{'children'}}[$i]->{'name'}");
		}
		$tmpapposonce = 2;
	}
	&traverseappos2($reff);
	#my $tmp = ();
	
}


sub traverseappos2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	#local $xflag = 0;
	for(my $i=0; $i<$count; $i++)
	{
		# if((@{$$reff1{'children'}}[$count-1]{'name'} eq "SBAR"))
		 # {
			 # for(my $i=0; $i<$count-1; $i++)
			 # {
				 # print "AAAA\n";
			 # }
		 # }
		  if($$reff1{'name'} eq "SBAR" and (@{$$reff1{'children'}}[$i]->{'name'}) eq "S" and $tmpapposonce == 0)
		  {
				 $commonref = @{$$reff1{'children'}}[$i];
				 $tmpapposonce =1;
				 #print "$commonref \n";
		  }
		 # {
			# for(my $i=0; $i<$count-1; $i++)
			# {
				# print @{$$reff1{'children'}}[$i]->{'name'};
			# }
		 # }
		&traverseappos1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}


sub SbarSChild
{
	my $string = shift;
	my $reff = MulTree($string);
	traverseappos1($reff);
	my @tmp = @tmpapposarr;
	@tmpapposarr = ();
	$tmpapposonce = 0;
	return @tmp;
}


#############################################################################################
my $SbarLastWordTNum = 0;
my $SbarLastWordTNum1 = 0;
my $SbarLastWordTref;
my @SbarLastWordTLocate;

sub SbarAllword
{
	my $string = shift;
	my $reff = MulTree($string);
	SbarLastWordTraverse1($reff);
	my @tmp = @SbarLastWordTLocate;
	@SbarLastWordTLocate = ();
	$SbarLastWordTNum = 0;
    $SbarLastWordTNum1 = 0;
	$SbarLastWordTref = ();
	return @tmp;
}


sub SbarLastWordTraverse1
{
	my ($reff) = shift;
	if((defined $SbarLastWordTref) )
	{
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			if($SbarLastWordTNum1 == 0)
			{
				&SbarLastWordTraverse11($SbarLastWordTref);
				$SbarLastWordTNum1 = 1;
			}	
	}
	&SbarLastWordTraverse2($reff);

	#my $tmp = ();
	
}


sub SbarLastWordTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		  if((@{$$reff1{'children'}}[$i]->{'name'}) eq "SBAR" and $SbarLastWordTNum == 0)
		  {
			$SbarLastWordTref = @{$$reff1{'children'}}[$i];
			$SbarLastWordTNum = 1;
		  }
		&SbarLastWordTraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}


sub SbarLastWordTraverse11
{
	my ($reff) = shift;
	#print $$reff{'name'}."\n";
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
			if((defined @{$$reff{'children'}}[$i]->{'locate'}))
			{
				push(@SbarLastWordTLocate,@{$$reff{'children'}}[$i]->{'locate'});
				#print @{$$reff{'children'}}[$i]->{'name'}."SSSSSSL\n";
			}
			
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			
	}
	&SbarLastWordTraverse22($reff);
	#my $tmp = ();
	
}


sub SbarLastWordTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&SbarLastWordTraverse11(@{$$reff1{'children'}}[$i]);	 
	}
}



###################################################
my $SbarSFirsrRef;
my $SbarSFirsrNum = 0;
my $SbarSFirsrNum1 = 0;
my @SbarSFistLocate = ();
sub SbarSFirstWordTraverse1
{
	my ($reff) = shift;
	if((defined $SbarSFirsrRef) )
	{
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			if($SbarSFirsrNum1 == 0)
			{
				&SbarSFirstWordTraverse11($SbarSFirsrRef);
				$SbarSFirsrNum1 = 1;
			}	
	}
	&SbarSFirstWordTraverse2($reff);

	#my $tmp = ();
	
}


sub SbarSFirstWordTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		  if(($$reff1{'name'}) eq "SBAR" and @{$$reff1{'children'}}[$i]->{'name'} eq "S" and $SbarSFirsrNum == 0)
		  {
			$SbarSFirsrRef = @{$$reff1{'children'}}[$i];
			$SbarSFirsrNum = 1;
		  }
		&SbarSFirstWordTraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}


sub SbarSFirstWordTraverse11
{
	my ($reff) = shift;
	#print $$reff{'name'}."\n";
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
			if((defined @{$$reff{'children'}}[$i]->{'locate'}))
			{
				push(@SbarSFistLocate,@{$$reff{'children'}}[$i]->{'locate'});
				#print @{$$reff{'children'}}[$i]->{'name'}."SSSSSSL\n";
			}
			
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			
	}
	&SbarSFirstWordTraverse22($reff);
	#my $tmp = ();
	
}


sub SbarSFirstWordTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&SbarSFirstWordTraverse11(@{$$reff1{'children'}}[$i]);	 
	}
}


sub SbarSAllWord
{
	my $string = shift;
	my $reff = MulTree($string);
	SbarSFirstWordTraverse1($reff);
	my @tmp = @SbarSFistLocate;
	@SbarSFistLocate = ();
	$SbarSFirsrRef = ();
    $SbarSFirsrNum = 0;
    $SbarSFirsrNum1 = 0;
	return @tmp;
}
#################################################################################

my $SbarPPRef;
my $SbarPP1Ref;
my $SbarPPNum = 0;
my $SbarPP1Num = 0;
my $SbarPPNum1 = 0;
my @SbarPPLocate = ();
sub SbarPPTraverse1
{
	my ($reff) = shift;
	if((defined $SbarPPRef))
	{
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			if($SbarPPNum1 == 0)
			{
				&SbarPPTraverse11($SbarPPRef);
				$SbarPPNum1 = 1;
			}	
	}
	&SbarPPTraverse2($reff);

	#my $tmp = ();
	
}


sub SbarPPTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		  if(($$reff1{'name'}) eq "SBAR" and $SbarPPNum == 0)
		  {
			$SbarPPRef = @{$$reff1{'children'}}[$count - 1];
			$SbarPPNum = 1;
		  }
		&SbarPPTraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}


sub SbarPPTraverse11
{
	my ($reff1) = shift;
	#print $$reff{'name'}."\n";
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
			if(@{$$reff1{'children'}}[$i]->{'name'} eq "PP" and $SbarPP1Num == 0)
			{
				$SbarPP1Ref = @{$$reff1{'children'}}[$i];
				$SbarPP1Num = 1;
				SbarPPTraverse111($SbarPP1Ref);
			}
			
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			
	}
	&SbarPPTraverse22($reff1);
	#my $tmp = ();
	
}


sub SbarPPTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&SbarPPTraverse11(@{$$reff1{'children'}}[$i]);	 
	}
}
sub SbarPPTraverse111
{
	my ($reff) = shift;
	#print $$reff{'name'}."\n";
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
			if((defined @{$$reff{'children'}}[$i]->{'locate'}))
			{
				push(@SbarPPLocate,@{$$reff{'children'}}[$i]->{'locate'});
				#print @{$$reff{'children'}}[$i]->{'name'}."SSSSSSL\n";
			}
			
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			
	}
	&SbarPPTraverse222($reff);
	#my $tmp = ();
	
}


sub SbarPPTraverse222
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&SbarPPTraverse111(@{$$reff1{'children'}}[$i]);	 
	}
}


sub SbarPPWord
{
	my $string = shift;
	my $reff = MulTree($string);
	SbarPPTraverse1($reff);
	my @tmp = @SbarPPLocate;
	@SbarPPLocate = ();
	$SbarPPRef = ();
	$SbarPP1Ref = ();
    $SbarPPNum = 0;
	 $SbarPP1Num = 0;
	#$SbarPP1Num = 0；
    $SbarPPNum1 = 0;
	return @tmp;
}
############################################################################################################
my $ThSRef;
my $ThSNum = 0;
my $ThSNum1 = 0;
my @ThSLocate = ();
sub ThSTraverse1
{
	my ($reff) = shift;
	if((defined $ThSRef) )
	{
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			if($ThSNum1 == 0)
			{
				&ThSTraverse11($ThSRef);
				$ThSNum1 = 1;
			}	
	}
	&ThSTraverse2($reff);

	#my $tmp = ();
	
}


sub ThSTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		  if(@{$$reff1{'children'}}[$i]->{'name'} eq "S" and ($$reff1{'children'}[$i]->{'layer'}) ==3 and $ThSNum == 0)
		  {
			#print "$$reff1{'layer'}";
			$ThSRef = @{$$reff1{'children'}}[$i];
			$ThSNum = 1;
		  }
		&ThSTraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}


sub ThSTraverse11
{
	my ($reff) = shift;
	#print $$reff{'name'}."\n";
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
			if((defined @{$$reff{'children'}}[$i]->{'locate'}))
			{
				push(@ThSLocate,@{$$reff{'children'}}[$i]->{'locate'});
				#print @{$$reff{'children'}}[$i]->{'name'}."SSSSSSL\n";
			}
			
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			
	}
	&ThSTraverse22($reff);
	#my $tmp = ();
	
}


sub ThSTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&ThSTraverse11(@{$$reff1{'children'}}[$i]);	 
	}
}


sub ThSAllWord
{
	my $string = shift;
	my $reff = MulTree($string);
	ThSTraverse1($reff);
	my @tmp = @ThSLocate;
	@ThSLocate = ();
	$ThSRef = ();
    $ThSNum = 0;
    $ThSNum1 = 0;
	return @tmp;
}


####################################CC
my $ThSCCRef;
my $ThSCCNum = 0;
my $ThSCCNum1 = 0;
my @ThSCCLocate = ();
sub ThSCCTraverse1
{
	my ($reff) = shift;
	if((defined $ThSCCRef) )
	{
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			if($ThSCCNum1 == 0)
			{
				&ThSTraverse11($ThSCCRef);
				$ThSCCNum1 = 1;
			}	
	}
	&ThSCCTraverse2($reff);

	#my $tmp = ();
	
}


sub ThSCCTraverse2
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		  if(@{$$reff1{'children'}}[$i]->{'name'} eq "CC" and ($$reff1{'children'}[$i]->{'layer'}) ==3 and $ThSNum == 0)
		  {
			#print "$$reff1{'layer'}";
			$ThSCCRef = @{$$reff1{'children'}}[$i];
			$ThSCCNum = 1;
		  }
		&ThSCCTraverse1(@{$$reff1{'children'}}[$i]);
		 
		
	}
}


sub ThSCCTraverse11
{
	my ($reff) = shift;
	#print $$reff{'name'}."\n";
	my $count = scalar(@{$$reff{'children'}});
	if($count == 0) {return;}
	for(my $i=0; $i<$count; $i++)
	{
			if((defined @{$$reff{'children'}}[$i]->{'locate'}))
			{
				push(@ThSCCLocate,@{$$reff{'children'}}[$i]->{'locate'});
				#print @{$$reff{'children'}}[$i]->{'name'}."SSSSSSL\n";
			}
			
			#push(@SbarLastWordTSstring,@{$$SbarLastWordTref{'children'}}[$i]->{'name'});
			
	}
	&ThSCCTraverse22($reff);
	#my $tmp = ();
	
}


sub ThSCCTraverse22
{
	my ($reff1) = shift;
	my $count = scalar(@{$$reff1{'children'}});
	if($count == 0) {return;}
	#$countnumber++;
	for(my $i=0; $i<$count; $i++)
	{
		&ThSCCTraverse11(@{$$reff1{'children'}}[$i]);	 
	}
}


sub ThCCAllWord
{
	my $string = shift;
	my $reff = MulTree($string);
	ThSCCTraverse1($reff);
	my @tmp = @ThSLocate;
	@ThSLocate = ();
	$ThSCCRef = ();
    $ThSCCNum = 0;
    $ThSCCNum1 = 0;
	return @tmp;
}













return 1;





















