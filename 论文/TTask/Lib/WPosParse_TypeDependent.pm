package WPosParse_TypeDependent;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(WordsAndPos_Penn_TypedDependt Sentence_PriVerb_Locate TextPath Pos Word Penn TypeDpdt Verb SentenceKinds Predivate_Verb_and_Location Sentence_Sub_Locate);
use File::Find;
#@EXPORT_OK = qw(wordsAndPos);
use strict;
use Cwd;
#use Algorithm::Diff qw(traverse_sequences);#2014\02\10目的是为了并列句的分类
#***************************
#支持中文
#***************************
#use utf8;
#use open ":encoding(gbk)", ":std";
#****************
#支持颜色显示
#****************
# use Win32::Console::ANSI;
# use Term::ANSIColor;
# print color 'reset';
#*****************
#my $usage = "perl sentence_kinds.pl .file.txt\n";
#@ARGV || die $usage;
#my ($filetxt) = @ARGV;
my @data_struct;
my $datapath;
my $jarpath;
my $modelpath;
sub wanted 
{
		if ($_ =~ /^data$/i and -d $_)
		{
			$datapath = $File::Find::name;
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

sub TextPath
{
my $filepath = shift;
my $filetxt_handle;
#my $DEBUG = 1;#compare function
#my $file_parse = 'parse.tmp';
my $file_parse_handle;
#my $local_direc = getcwd();
#$local_direc =~ s/\//\\/g;
#my ($dirname, $outName) = $local_direc =~ /(.*)\/(.*)/;
#print $local_direc."DDD\n";
my $dirpath = getcwd();
#my $count_sprit;
#print "$filepath \n\n\n";

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
	#


# if(-e "$dirname/data")
# {
# }
# else
# {
	# mkdir "$dirname/data";
# }

open($filetxt_handle,"< $filepath") || die "can not open sample.txt\n";
open($file_parse_handle,"> $datapath/parse.tmp") || die "can not write parse.tmp\n";
# while(<$filetxt_handle>)
# {
	
# }
#***************把文本生成pos和parse结构
#
#
#				A loweyellow rating could raise borrowing costs for all Japanese, 
#				cyellowit. And such a move could further weaken Japanese banks, which
#				already pay more to borrow because they hold in excess of $600
#				billion in bad loans.
#*****************************************************************************************
#det(nation-30, the-29)
#poss(rating-34, nation-30)
#amod(rating-34, pristine-32)
#nn(rating-34, cyellowit-33)
#prep_on(provided-24, rating-34)

#The/DT exchange/NN rate/NN of/IN Japan/NNP 's/POS currency/NN ,/, the/DT yen/NN ,/, tumbled/VBD to/TO a/DT six-and-a-half-year/JJ low/NN ,/, and/CC the/DT stock/NN and/CC bond/NN markets/NNS fell/VBD on/IN the/DT decision/NN by/IN the/DT American-based/JJ ratings/NNS agency/NN to/TO change/VB its/PRP$ view/NN on/IN Japan/NNP _/NNP whose/WP$ government/NN debt/NN has/VBZ been/VBN rated/VBN triple-A/JJ _/NNS from/IN ``/`` stable/JJ ''/'' to/TO ``/`` negative/JJ ./. ''/''

#(ROOT
 # (S
    # (S
      # (NP
        # (NP (DT The) (NN exchange) (NN rate))
        # (PP (IN of)
          # (NP
            # (NP
              # (NP (NNP Japan) (POS 's))
              # (NN currency))
            # (, ,)
            # (NP (DT the) (NN yen))
            # (, ,))))
#
#
#
print  $file_parse_handle `java -mx300m -cp $jarpath/stanford-parser.jar edu.stanford.nlp.parser.lexparser.LexicalizedParser -outputFormat "wordsAndTags,penn,typedDependencies" $modelpath/englishPCFG.ser.gz $filepath`;
close($filetxt_handle);
close($file_parse_handle);
#********************************************
#****************************************************************************
open($file_parse_handle,"< $datapath/parse.tmp") || die "can not open parse.tmp\n";
#****************************************************************************
#data_struct结构为([pos,[],[]])
#***************************************************************************
my $flag = 0;
my $Sentence_count = 0;

while(<$file_parse_handle>)
{
	chomp;
	s/^\s+//g;
	
	if($_ =~ /^\s*$/)
	{
		$flag += 1;
	}
	if($flag == 0)
	{
		$data_struct[$Sentence_count][$flag] = $_;
	}
	elsif($flag == 1)
	{
		#$data_struct[$Sentence_count][$flag] = [];
		if($_ !~ /^\s*$/)
		{push(@{$data_struct[$Sentence_count][$flag]},$_);}
		# if($_ =~ /\(SBAR[^Q].*/)
		# {
			# $Parse_SBAR[$Sentence_count][$sbar_number] = "$_";
			# $sbar_number++;
		# }
		# else
		# {
			# $Parse_SBAR[$Sentence_count][$sbar_number] = "$_";
			# $sbar_number++;
		# }
	}
	elsif($flag == 2)
	{
		#$data_struct[$Sentence_count][$flag] = [];
		if($_ !~ /^\s*$/)
		{push(@{$data_struct[$Sentence_count][$flag]},$_);}
	}
	else
	{
		$Sentence_count +=1;
		$flag = 0;
	}
	
	
}
 # foreach(@data_struct)
 # {
	 # print "@{@$_[2]}[0] DDD\n";
	 # my $typedependent = "@{@$_[2]}";
	# # 
		 # @$_[2]   = "$typedependent";
	 # my $parse = "@{@$_[1]}";
		 # @$_[1]   = "$parse";
		
		# foreach(@$_)
		# {
			# #print "$_ FFF\n";
		# }
 # }
close($file_parse_handle);
}
#&wordsAndPos();
sub WordsAndPos_Penn_TypedDependt
{
	my @wordsAndPos_penn_typedDependencies = @data_struct;
	# foreach(@wordsAndPos_penn_typedDependencies)
	# {
		# print "$_ \n";
	# }
	return @wordsAndPos_penn_typedDependencies;
}

sub Word
{
	my @wordAndPos = ();
	my @word = ();
    for(my $i = 0; $i <=$#data_struct; $i++)
	{
		push(@wordAndPos,$data_struct[$i][0]); 
    }
	for(my $i = 0; $i <=$#wordAndPos; $i++)
	{
		my @tmp = split(/\s|\//,$wordAndPos[$i]);
		for(my $j = 0; $j<=$#tmp; $j++)
		{
			if(!($j&1))
			{
				push(@{$word[$i]},$tmp[$j]);
			}
		}
    }
	return @word;
}

sub Pos
{
	my @wordAndPos = ();
	my @pos = ();
    for(my $i = 0; $i <=$#data_struct; $i++)
	{
		push(@wordAndPos,$data_struct[$i][0]); 
    }
	for(my $i = 0; $i <=$#wordAndPos; $i++)
	{
		my @tmp = split(/\s|\//,$wordAndPos[$i]);
		for(my $j = 0; $j<=$#tmp; $j++)
		{
			if(($j&1))
			{
				push(@{$pos[$i]},$tmp[$j]);
			}
		}
    }
	return @pos;
}

sub Penn
{
	my @parse = ();
	for(my $i = 0; $i<= $#data_struct; $i++)
	{
		#print "@{@{$WPos_Penn_Typedepent[$i]}[1]}[0] DDDDDDD\n";
		@{$parse[$i]} = @{@{$data_struct[$i]}[1]} ;
	}
	return @parse;
}


sub TypeDpdt
{
	my @typedpdt = ();
	for(my $i = 0; $i<= $#data_struct; $i++)
	{
		#print "@{@{$WPos_Penn_Typedepent[$i]}[1]}[0] DDDDDDD\n";
		@{$typedpdt[$i]} = @{@{$data_struct[$i]}[2]} ;
	}
	return @typedpdt;
}

sub Verb
{
	my @pos = &Pos();
	my @word = &Word();
	my @verb = ();
	for(my $i=0 ;$i<=$#pos ;$i++)
	{
		my $k = 0;
		for(my $j=0 ;$j<scalar(@{$pos[$i]}) ;$j++)
			{
			if($pos[$i][$j] =~ /^(VB)/)
				{
					push(@{$verb[$i][$k]},$word[$i][$j]);
					push(@{$verb[$i][$k]},$pos[$i][$j]);
					push(@{$verb[$i][$k]},$j+1);
					$k++;
				}
			}
	}
	return @verb;
}



sub SentenceKinds
{
	#0_陈述句 1_疑问句 2_感叹句 3_祈使句
	my @word = Word();
	my @pos = Pos();

	my @Sentence_value = ();
	for(my $i = 0;$i <= $#word; $i++)
	{
		#my @tmparr = @{$word[$i]};
		
		if($word[$i][scalar(@{$word[$i]})-1] =~ /^\.$/)
		{
			$Sentence_value[$i][0] += 2;
			$Sentence_value[$i][1] += 0;
			$Sentence_value[$i][2] += 0;
			$Sentence_value[$i][3] += 2;
		}
		if($word[$i][scalar(@{$word[$i]})-1] =~ /^\?$/)
		{
			$Sentence_value[$i][0] += 0;
			$Sentence_value[$i][1] += 2;
			$Sentence_value[$i][2] += 0;
			$Sentence_value[$i][3] += 0;
		}
		if($word[$i][scalar(@{$word[$i]})-1] =~ /^\!$/)
		{
			$Sentence_value[$i][0] += 0;
			$Sentence_value[$i][1] += 0;
			$Sentence_value[$i][2] += 2;
			$Sentence_value[$i][3] += 1;
		}
		if($pos[$i][0] =~ /^VB$/ or $word[$i][0] =~ /^please$/i)
		{
			$Sentence_value[$i][3] += 2;
		}
		if($pos[$i][0] =~ /^(MD|VBP|VBZ)$/)
		{
			$Sentence_value[$i][1] += 1;
		}
		if($word[$i][0] =~ /^(what|how)$/i and $word[$i][scalar(@{$word[$i]})-1] =~ /^\!$/)
		{
			#$Sentence_value[$i][1] += 1;
			$Sentence_value[$i][2] += 2;
		}
		if($word[$i][0] =~ /^(who|which|where|when|why|whose)$/i)
		{
			$Sentence_value[$i][1] += 1;
		}
		if($word[$i][scalar(@{$word[$i]})-1] !~ /^(\.|\?|!)$/)
		{
			$Sentence_value[$i][0] += 0;
			$Sentence_value[$i][1] += 0;
			$Sentence_value[$i][2] += 0;
			$Sentence_value[$i][3] += 0;
			$Sentence_value[$i][4] += 3;
		}
	}
	my @Max_possible = ();
	foreach(@Sentence_value)
	{
		my $n = 0; 
		my @tmp = @$_;
		for(my $i = 0;$i <= $#tmp; $i++)
		{
			if($tmp[$n] < $tmp[$i])
			{
				$n = $i;
			}
		}
		push(@Max_possible,$n);
	}
	my @SKinds = @Max_possible;
	return @SKinds;
}



# sub text_sentence
# {
	# my $filedir = shift;
	# my $handletmp;
	# my @arrtmp;
	# open($handletmp,"< $filedir") || die "can not open it";
	# while(<$handletmp>)
	# {
		# chomp;
		# print
	# }
# }

sub Predivate_Verb_and_Location
{
	my @subpenn = TypeDpdt();
	my @rtn;
	foreach(@subpenn)
	{
		#print;
		#print"@$_\n";
		my %loc_word;
		my @nsubj_Negnsubj_aux = "@$_" =~ /nsubj\(.*?\)|nsubjpass\(.*?\)|aux\(.*?\)|auxpass\(.*?\)/g;
		@nsubj_Negnsubj_aux = grep { $_ !~ /, to\-/i } @nsubj_Negnsubj_aux; 
		my %count;
		@nsubj_Negnsubj_aux = grep {++$count{$_} < 2} map {s/.*?\(//g;s/,\s+.*/,/;my $str = $_;} @nsubj_Negnsubj_aux;
		#print"\n";
		#my %count
		foreach(@nsubj_Negnsubj_aux)
		{
			#$_ = reverse($_);
			s/\s+|,//g;
			my ($value,$key) = split(/\-/,$_);
			$loc_word{"$key"} = $value;
			#print"$_";
		}
		push(@rtn,\%loc_word);
		#print"\n\n\n";
	}
	#print $rtn[0]->{3};
	 # foreach(@rtn)
	 # {
		 # #print $$_{keys(%$_)};
		 # print"$_  MMM\n";
		 # print $_->{5};
	 # }
	return @rtn;
}

sub Sentence_Sub_Locate
{
	my @subpenn = TypeDpdt();
	my @rtn;
	my @pos = Pos();
	my @word = Word();
	my $binge = qr/\b(me|us|her|him|them)\b/;
	foreach(my $i = 0;$i <=$#subpenn; $i++)
	{
		#print;
		#print "@{$subpenn[$i]} FFF\n";
		my %loc_word;
		my @poS = @{$pos[$i]};
		my @worD = @{$word[$i]};
		my @nsubj_Negnsubj_aux = "@{$subpenn[$i]}" =~ /nsubj\(.*?\)|nsubjpass\(.*?\)|expl\(.*?\)/g;
		#foreach(@nsubj_Negnsubj_aux){print "$_\n";}
		for(my $j = 0;$j <= $#nsubj_Negnsubj_aux; $j++)
		{
			my $str = $nsubj_Negnsubj_aux[$j];
			$str =~ s/.*?\-([0-9]+).*?\-([0-9]+)/$2 $1/;
			$str =~ s/\)//g;
			#print "S: $str\n";
			my ($sub,$pverb) = split(/\s+/,$str);
			my $flag_verb = 1;
			my $flag_verb1 = 1;
			if($worD[$sub-1] =~ /$binge/)
			{
				$flag_verb = 2;
				#print "FFFFFFFFFFK\n";
			}
			for(my $p = $sub-1;$p < $pverb; $p++)
			{
				if($poS[$p] =~ /^(VB|MD)/ and $poS[$p-1] !~ /^(TO)/){$flag_verb1 = 3;}
			}
			if($flag_verb == 2 or $flag_verb1 != 3)
			{
				#print "FFFFKKKKKFFFFFF\n";
				splice(@nsubj_Negnsubj_aux,$j,1);
				
				$j--;
			}
			$flag_verb = 0;
			#$nsubj_Negnsubj_aux[$j] =~ s///g;
		}
		##############
		for(my $j = 0;$j <= $#nsubj_Negnsubj_aux; $j++)
		{
			my $str = $nsubj_Negnsubj_aux[$j];$str =~ s/.*?([0-9]+)/$1/;$str =~ s/\)|\s+//g;
			my ($end,$bgn) = split(/,.*?\-/,$str);
			#print""
			for(my $k = $j+1;$k <= $#nsubj_Negnsubj_aux; $k++)
			{
				my $str1 = $nsubj_Negnsubj_aux[$k];$str1 =~ s/.*?([0-9]+)/$1/;$str1 =~ s/\)|\s+//g;
				my ($end1,$bgn1) = split(/,.*?\-/,$str1);
				if($bgn == $bgn1 or $end == $end1){splice(@nsubj_Negnsubj_aux,$j,1);$j--;$k--;last;}
			}
		}
		#@@nsubj_Negnsubj_aux = grep { $_ !~ /, to\-/i } @nsubj_Negnsubj_aux; 
		my %count;
		
		@nsubj_Negnsubj_aux = grep {++$count{$_} < 2} map {s/.*?\,//g;s/.*\-//;s/\)//g;s/\s+//;my $str = $_;} @nsubj_Negnsubj_aux;
		#foreach(@nsubj_Negnsubj_aux){print"$_ KKK\n";}
		push(@rtn,\@nsubj_Negnsubj_aux);
		#print"\n";
		
		#my %count
		# foreach(@nsubj_Negnsubj_aux)
		# {
			# #$_ = reverse($_);
			# s/\s+|,//g;
			# my ($value,$key) = split(/\-/,$_);
			# $loc_word{"$key"} = $value;
			# #print"$_";
		# }
		# push(@rtn,\%loc_word);
		# #print"\n\n\n";
	# }
	# #print $rtn[0]->{3};
	 # # foreach(@rtn)
	 # # {
		 # # print $$_{keys(%$_)};
		 # # print"$_  MMM\n";
		 # # print $_->{5};
	}
	return @rtn;
}

sub Sentence_PriVerb_Locate
{
	my @subpenn = TypeDpdt();
	my @rtn;
	my @pos = Pos();
	my @word = Word();
	my $binge = qr/^(me|us|her|him|them)$/;
	foreach(my $i = 0;$i <=$#subpenn; $i++)
	{
		#print;
		#print "@{$subpenn[$i]} FFF\n";
		my %loc_word;
		my @poS = @{$pos[$i]};
		my @worD = @{$word[$i]};
		my @nsubj_Negnsubj_aux = "@{$subpenn[$i]}" =~ /nsubj\(.*?\)|nsubjpass\(.*?\)/g;
		#foreach(@nsubj_Negnsubj_aux){print "$_\n";}
		for(my $j = 0;$j <= $#nsubj_Negnsubj_aux; $j++)
		{
			my $str = $nsubj_Negnsubj_aux[$j];
			$str =~ s/.*?\-([0-9]+).*?\-([0-9]+)/$2 $1/;
			$str =~ s/\)//g;
			#print "S: $str\n";
			my ($sub,$pverb) = split(/\s+/,$str);
			my $flag_verb = 1;
			my $flag_verb1 = 1;
			if($worD[$sub-1] =~ /$binge/)
			{
				$flag_verb = 2;
				#print "FFFFFFFFFFK\n";
			}
			for(my $p = $sub-1;$p < $pverb; $p++)
			{
				if($poS[$p] =~ /^(VB|MD)/ and $poS[$p-1] !~ /^(TO)/){$flag_verb1 = 3;}
			}
			if($flag_verb == 2 or $flag_verb1 != 3)
			{
				#print "FFFFFFFFFF\n";
				splice(@nsubj_Negnsubj_aux,$j,1);
				
				$j--;
			}
			$flag_verb = 0;
			#$nsubj_Negnsubj_aux[$j] =~ s///g;
		}
		for(my $j = 0;$j <= $#nsubj_Negnsubj_aux; $j++)
		{
			my $str = $nsubj_Negnsubj_aux[$j];$str =~ s/.*?([0-9]+)/$1/;$str =~ s/\)|\s+//g;
			my ($end,$bgn) = split(/,.*?\-/,$str);
			for(my $k = $j+1;$k <= $#nsubj_Negnsubj_aux; $k++)
			{
				my $str1 = $nsubj_Negnsubj_aux[$k];$str1 =~ s/.*?([0-9]+)/$1/;$str1 =~ s/\)|\s+//g;
				my ($end1,$bgn1) = split(/,.*?\-/,$str1);
				if($bgn == $bgn1 or $end == $end1){splice(@nsubj_Negnsubj_aux,$j,1);$j--;$k--;last;}
			}
		}
		#@@nsubj_Negnsubj_aux = grep { $_ !~ /, to\-/i } @nsubj_Negnsubj_aux; 
		my %count;
		#foreach(@nsubj_Negnsubj_aux){print"$_ KKK\n";}
		@nsubj_Negnsubj_aux = grep {++$count{$_} < 2} map {s/.*?\-([0-9]+),/$1/g;s/([0-9]+).*/$1/;s/\s+//g;my $str = $_;} @nsubj_Negnsubj_aux;
		#foreach(@nsubj_Negnsubj_aux){print"$_ KKK\n";}
		push(@rtn,\@nsubj_Negnsubj_aux);
		#print"\n";
		
		#my %count
		# foreach(@nsubj_Negnsubj_aux)
		# {
			# #$_ = reverse($_);
			# s/\s+|,//g;
			# my ($value,$key) = split(/\-/,$_);
			# $loc_word{"$key"} = $value;
			# #print"$_";
		# }
		# push(@rtn,\%loc_word);
		# #print"\n\n\n";
	# }
	# #print $rtn[0]->{3};
	 # # foreach(@rtn)
	 # # {
		 # # print $$_{keys(%$_)};
		 # # print"$_  MMM\n";
		 # # print $_->{5};
	}
	return @rtn;
}









return 1;