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
use List::MoreUtils qw(uniq);
use MulTree qw(TestTraverse SbarNumber SbarSAllWord ThSAllWord ThCCAllWord SbarPPWord SbarSChild  SbarAllword ThreeRlatSbar MainTruck SbarLeftSibling SbarAllFather SbarAllChildren SbarRightSibling SbarFather);
use WPosParse_TypeDependent qw(Sentence_PriVerb_Locate WordsAndPos_Penn_TypedDependt TextPath Pos Word Penn TypeDpdt Verb SentenceKinds Predivate_Verb_and_Location Sentence_Sub_Locate);

my ($usage) = "perl .pl fullpathtext";
@ARGV || die $usage;
my ($tfff,$outtag) = @ARGV;
my $file_parse_handle;
my $local_direc = getcwd();
#$local_direc =~ s/\//\\/g;
my ($dirname, $outName) = $local_direc =~ /(.*)\/(.*)/;
my ($nerpath) = DealTmWheFile($tfff);
#my @NerSent = TmWhe_Sentence();
TextPath("$nerpath");




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 #########################################################################################Main


 my @WORD= Word();
my @POS = Pos();
	#my @poS = @{$pOs[$nums]};
 my @PENN = Penn();
my @Arr_Feature;
my $outFile_hdl;#E:\Task\train\feature
open($outFile_hdl,"> ..\\train\\tested\\test_$outtag.feature") or die "can not append it!\n";
my $j=0;
 for(my $i = 0;$i<=$#WORD;$i++)
 {
	 #my $feature = FTR_EXTRACT("@{$PENN[$i]}",$i);
	
	 my $Pos_Chunk_feature = PosChunk("@{$PENN[$i]}",$i);
	 my $Pos_NerChunk_feature = PosNerChunk("@{$PENN[$i]}",$i);
	 my @worD = @{$WORD[$i]};
	 my @poS = @{$POS[$i]};
	 my $word_feature = join(" ",@worD);
	 my $pos_feature = join(" ",@poS);
	 print "$word_feature\n";
	 print "$pos_feature\n"; 
	 print "Chunk$i:	$Pos_Chunk_feature\n";
	 #$i++;
	 print $outFile_hdl "$Pos_NerChunk_feature\n";
	 }
##################################



##############引导词的位置
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
	if(scalar(@sbarallword) > 0.1)
	{
		return @sbarallword;
	}
	else
	{
		return @void;
	}
	
}
 

 
 

 

 



 
 

 
 
##########################################字符相似度
 
 
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
######################################
#PosChunk(Introducer word)
sub PosChunk
{
	my ($tmpstring,$nums) = @_;
	my $sBarnumber = SbarNumber($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @sbarallword = SbarAllword($tmpstring);
	my @that = ("that_insert");
	if($sBarnumber > 0.1 and scalar(@intro) == 0)
	{
		splice(@poS,$sbarallword[0]-1,0,@that);
	}
	elsif($sBarnumber > 0.1 and scalar(@intro) > 0.1)
	{
		if(scalar(@intro) == 1)
		{
			splice(@poS,$sbarallword[0]-1,1,$worD[$sbarallword[0]-1]);
		}
		else
		{
			my $two_intro = 0;
			#my $one_intro = 0;
			for(my $i = $sbarallword[0]-1;$i < $sbarallword[0]+scalar(@intro);$i++)
			{
				my $tmpString = "$worD[$i]"."_"."$worD[$i+1]";
				my $flag = $i;
				if($tmpString =~ /as_if|as_though|so_that/)
				{
					$two_intro = 1;
					splice(@poS,$i,2,$worD[$i],$worD[$i+1]);
				}
			}
			if($two_intro == 0)
			{
				for(my $i = $sbarallword[0]-1;$i < $sbarallword[0]+scalar(@intro);$i++)
				{
					if($worD[$i] =~ /after|although|anywhere|as|because|before|everywhere|how|however|if|lest|since|than|that|though|till|unless|until|what|whatever|when|whenever|where|wherever|whether|which|whichever|while|who|whoever|whom|whomever|whose|whosever|why/i)
					{
						splice(@poS,$i,1,$worD[$i]);
					}
				}
			}
		}
	}
	else
	{
		@poS;
	}
	my $bck = join(" ",@poS);
	return $bck;
}

 #####################################################################################特征提取
 
 
 
 ########
 sub PosNerChunk
{
	my ($tmpstring,$nums) = @_;
	my $sBarnumber = SbarNumber($tmpstring);
	my @intro = introducer($tmpstring);
	my @wOrd = Word();
	my @worD = @{$wOrd[$nums]};
	my @pOs = Pos();
	my @poS = @{$pOs[$nums]};
	my @sbarallword = SbarAllword($tmpstring);
	my @that = ("that_insert");
	my $Link_appos = qr/^(statement|desire|order|possibility|plan|doubt|rumor|news|eagerness|question|demand|impression|truth|idea|words||resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|problem|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $single_R = qr/^(Seeing|considering|now|given)$/i;
	my $single_C = qr/^(assuming|providing|provided|supposed|supposing)$/i;
	my $single_CCS = qr/^(granting|granted)$/i;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mailed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|prepared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|steal|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
	my $time_noun = qr/(year|month|day|hour|minute|second|century|ago|period|today|stage|tonight|morning|time|afternoon|noon|midday|noonday|afternoon|forenoon|moment|dawn|dark|night|nightfall|present|sunrise|past|now|future)s?/i;
	my $place_noun = qr/(camp|building|school|bank|factory|classroom|station|mall|airport|cinema|hospital|river|lake|hotel|market|square|plaza|Forum|piazza|place|palace|palace|alcazar|city|country|countyrside|village|area|town|mountain|province|municipality|region|desert|sea|forest|house|home|university|school|street)s?/i;
	for(my $i = 0;$i<$#worD;$i++)
	{
		if($worD[$i] =~ /\b$double_object\b/i){splice(@poS,$i,1,qw(DObj));}
		if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bmatter\b/i){splice(@poS,$i,2,qw(NO Matter));}
		if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bsooner\b/i){splice(@poS,$i,2,qw(NO Sooner));}
		if($worD[$i] =~ /\b$Link_appos\b/i){splice(@poS,$i,1,qw(LogN));}
		if($poS[$i] =~ /^VB/ and $worD[$i+1] =~ /\bit\b/i){splice(@poS,$i+1,1,qw(it));}
		if($worD[$i] =~ /\b$single_R\b/i){splice(@poS,$i,1,qw(SOLOR));}
		if($worD[$i] =~ /\b$single_C\b/i){splice(@poS,$i,1,qw(SOLOC));}
		if($worD[$i] =~ /\b$single_CCS\b/i){splice(@poS,$i,1,qw(SOLOCCS));}
		
	}
	if($sBarnumber > 0.1 and scalar(@intro) == 0)
	{
		splice(@poS,$sbarallword[0]-1,0,@that);
	}
	elsif($sBarnumber > 0.1 and scalar(@intro) > 0.1)
	{
		if(scalar(@intro) == 1)
		{
			splice(@poS,$sbarallword[0]-1,1,$worD[$sbarallword[0]-1]);
			if($worD[$sbarallword[0]-1] =~ /\bwhen\b/i and $worD[$sbarallword[0]-2] =~ /$time_noun/i){splice(@poS,$sbarallword[0]-2,1,"TIME");}
			if($worD[$sbarallword[0]-1] =~ /\b(who|whose)\b/i and $worD[$sbarallword[0]-2] =~ /PERSON/i){splice(@poS,$sbarallword[0]-2,1,"PERSON");}
			if($worD[$sbarallword[0]-1] =~ /\bwhere\b/i and $worD[$sbarallword[0]-2] =~ /$place_noun/i){splice(@poS,$sbarallword[0]-2,1,"PLACE");}
		}
		else
		{
			my $two_intro = 0;
			#my $one_intro = 0;
			for(my $i = $sbarallword[0]-1;$i < $sbarallword[0]+scalar(@intro);$i++)
			{
				my $tmpString = "$worD[$i]"."_"."$worD[$i+1]";
				my $flag = $i;
				if($tmpString =~ /as_if|as_though|so_that/)
				{
					$two_intro = 1;
					splice(@poS,$i,2,$worD[$i],$worD[$i+1]);
				}
			}
			if($two_intro == 0)
			{
				for(my $i = $sbarallword[0]-1;$i < $sbarallword[0]+scalar(@intro);$i++)
				{
					if($worD[$i] =~ /after|although|anywhere|as|because|before|everywhere|how|however|if|lest|since|than|that|though|till|unless|until|what|whatever|when|whenever|where|wherever|whether|which|whichever|while|who|whoever|whom|whomever|whose|whosever|why/i)
					{
						splice(@poS,$i,1,$worD[$i]);
					}
				}
			}
		}
	}
	else
	{
		@poS;
	}
	my $bck = join(" ",@poS);
	return $bck;
}

#

sub FTR_EXTRACT
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
	my @sbarsschild = SbarSChild($tmpstring);
	my @dpdt = TypeDpdt();
	my @acl = "@{$dpdt[$nums]}" =~ /acl:relcl\(.*?\)/g;
	my $maintruck = 0;
	if($maintruck=~ /SBAR[^Q]/){$maintruck =~ s/(.*?)SBAR(.*?)VP.*/$2/;}else{$maintruck = 1;}
	$maintruck =~ s/SBAR(.*?)VP.*/$1/;
	my @maintruck1 = split(/-/,$maintruck);
	my @n_v;
	my @sub_num = Sentence_Sub_Locate();
	my @pub_num = Sentence_PriVerb_Locate();
	my @spcl_loc = @{$sub_num[$nums]};
	#foreach(@sub_num){print"AAA\n";}
	#$n_v[0] = "@worD";#句子
	#$n_v[1] = "@poS";#词性
	my $Sentence_Number = scalar(@spcl_loc);
	my $Is_Sentence_XianXingCiWord;
	#$n_v[1] = scalar(@{$sub_num[$nums]});#词性
	
	
	if($sBarnumber > 0.1){if(scalar(@intro) == 0){$Is_Sentence_XianXingCiWord = "that";}if(scalar(@intro)>0.1){for(my $i=$intro[0]-1;$i<$intro[0]+scalar(@intro)-1;$i++){$Is_Sentence_XianXingCiWord .= "$worD[$i] ";}}}
	if($sBarnumber < 0.1){$Is_Sentence_XianXingCiWord = "non";}
	#print "$n_v[1]\n\n";
	$Is_Sentence_XianXingCiWord =~ s/\s+$//;
	################################################
	my $qstword = qr/(what|who|which|whose|when|where|how|why|whose|whoever|whomever|whosever|whatever|whichever|why|how|however)/i;
	my $qstwordever = qr/(whoever|whomever|whosever|whatever|whichever|however)/i;
	my $Non_OC_Verb = qr/^(provided|suppose|supposing|providing|seeing|given|considering|granted|granting|admitting)$/i;
	my $Link_Verb = qr/^('s|am|is|are|feel|seem|appear|sound|stay|become|was|were|felt||seemed|looked|appeared|remain|remained|sounded|stayed|became)s?$/;
	my $be = qr/^(are|been|am|is|be|were|was|'s)$/;
	my $Vi = qr/^(rain|rained|agree|agreed|go|went|gone|work|worked|listen|listened|look|looked|come|came|die|died|belong|belonged|fall|fell|fallen|exist|existed|rise|rose|risen|arrive|arrived|sat|sitten|sail|sailed|hurry|hurried|fail|failed|succeed|succeeded|behave|behaved|leave|put|discuss|doubt|left|discussed|doubted)s?$/;
	my $Link_appos = qr/^(statement|desire|order|possibility|plan|doubt|rumor|news|eagerness|question|demand|impression|truth|idea|words||resolution|fact|promise|hope|message|advice|announcement|argument|belief|claim|conclusion|decision|evidence|explanation|feeling|hope|idea|impression|information|knowledge|opinion|order|probability|promise|proposal|remark|reply|report|problem|saying|statement|suggestion|thought|treat|warning|wish|word)$/i;
	my $double_object = qr/^(allow|allowed|ask|asked|award|awarded|book|booked|borrow|borrowed|bought|bring|brought|buy|cause|caused|charge|charged|choose|chose|chosen|cook|cooked|draw|drawn|drew|fetch|fetched|find|fix|fixed|forgave|forgive|forgiven|found|get|got|gotten|hand|handed|leave|left|lend|lendt|lent|made|made|mail|mailed|mailed|make|mistake|mistaken|mistook|offer|offered|order|ordered|owe|owed|paid|paid|pass|passed|pay|pick|picked|play|played|post|posted|prepare|prepared|preserve|preserved|read|refuse|refused|return|returned|sang|save|saved|sell|send|sent|serve|served|show|showed|shown|sing|sold|spare|spared|steal|stole|stolen|sung|take|taken|taught|teach|tell|threw|throw|thrown|told|took|write|written|wrote)s?$/;
	my $adjObClauseWord = qr/^(sure|certain|glad|please|happy|sorry|afraid|satisfied|surprised)$/;
	my $special_verb = qr/^(leave|put|discuss|doubt|left|discussed|doubted).s$/;
	my $time_noun = qr/(year|month|day|hour|minute|second|century|ago|period|today|stage|tonight|morning|time|afternoon|noon|midday|noonday|afternoon|forenoon|moment|dawn|dark|night|nightfall|present|sunrise|past|now|future)s?/i;
	my $place_noun = qr/(camp|building|school|bank|factory|classroom|station|mall|airport|cinema|hospital|river|lake|hotel|market|square|plaza|Forum|piazza|place|palace|palace|alcazar|city|country|countyrside|village|area|town|mountain|province|municipality|region|desert|sea|forest|house|home|university|school|street)s?/i;
	my $as_vb = qr/\b(know|known|see|saw|say|said|expect|expected|imagine|imagined|hope|hoped|believe|believed|announce|announced|suggest|suggested|report|reported)?s\b/i;
	##########################先行词
	my $sub_introducer = qr/\b(that|whether|who|whoever|what|whatever|which|whichever|whom|whose|how|why|when|while)\b/i;
	my $sub_string = "that whether who whoever what whatever which whichever whom whose how why when while";
	my $o_introducer = qr/\b(that|whether|what|who|which|whose|how|why|whom|if|whose|whoever|whomever|whosever|whatever|whichever|why|how|however|when|where|whenever|wherever)\b/;
	my $o_string = "that whether what who which whose how why whom if whose whoever whomever whosever whatever whichever why how however when where whenever wherever";
	my $prd_introducer = qr/\b(that|whether|who|whoever|whom|whose|what|whatever|which|whichever|when|where|how|why|as_if|as_though|when|where)\b/i;#表语从句
	my $prd_string = "that whether who whoever whom whose what whatever which whichever when where how why as_if as_though when where";
	my $appos_introducer = qr/\b(that|whether|what|which|who|how|why|when|where)\b/i;
	my $appos_string = "that whether what which who how why when where";
	my $attr_introducer = qr/\b(that|how|whose|whom|who|which|why|when|where)\b/i;
	my $attr_string = "that how whose whom who which why when where";
	my $mnr_introducer = qr/\b(as|as_if|as_though)\b/i;
	my $mnr_string = "as as_if as_though";
	my $nattr_introducer = qr/\b(how|whose|whom|who|which|when|where|as)\b/i;
	my $nattr_string = "how whose whom who which when where as";
	my $pre_introducer = qr/(lest|so_that|that)/i;#目的状语从句引导词
	my $pre_string = "lest so_that that";
	my $time_introducer = qr/^(before|after|till|until|when|while|whenever)$/i;
	my $time_string = "before after till until when while whenever";
	my $rsn_introducer = qr/\b(since|now_that|because)\b/i;
	my $rsn_string = "since now_that because";
	my $where_introducer= qr/\b(where|anywhere|everywhere|wherever)\b/i;
	my $where_string = "where anywhere everywhere wherever";
	my $cdt_introducer = qr/\b(if|unless)\b/i;
	my $cdt_string = "if unless";
	my $Css_introducer = qr/\b(though|although|as|that)\b/i;
	my $Css_string = "though although as that";
	my $rsl_introducer = qr/\b(so_that|that)\b/i;
	my $rsl_string = "so_that that";
	my $cmp_introducer = qr/\b(than|as)\b/i;
	my $cmp_string = "than as";
	##############################################Extract 引导词
	my $Feature_YDC;
	my $mulYDC;
    if($sBarnumber > 0.1 and scalar(@intro) == 0)
	{
		$Feature_YDC = "$sub_string"." "."$o_string"." "."$prd_string"." "."$appos_string"." "."$attr_string"." "."$pre_string"." "."$rsn_string"." "."$Css_string"." "."$rsl_string";
		my @ydc = split(/\s+/,$Feature_YDC);my @uniqword = uniq(@ydc);$Feature_YDC = join(" ",@uniqword);
		#$Feature_YDC .="$o_string";
	}
	elsif($sBarnumber > 0.1 and scalar(@intro) == 1)
	{
		#my $intro;
		if($worD[$intro[0]-1] =~ /$qstword/i and $worD[$intro[0]-2] !~ /\bmatter\b/i and $worD[$intro[0]-3] !~ /\bno\b/i){$Feature_YDC = YDC("$worD[$intro[0]-1]");my @ydc = split(/\s+/,$Feature_YDC);my @uniqword = uniq(@ydc);$Feature_YDC = join(" ",@uniqword);}
		elsif($worD[$intro[0]-1] =~ /$qstword/i and $worD[$intro[0]-2] =~ /\bmatter\b/i and $worD[$intro[0]-3] =~ /\bno\b/i){$Feature_YDC = "$worD[$intro[0]-3] $worD[$intro[0]-2] $worD[$intro[0]-1]";}
		#elsif(){}
		else{$Feature_YDC = YDC("$worD[$intro[0]-1]");my @ydc = split(/\s+/,$Feature_YDC);my @uniqword = uniq(@ydc);$Feature_YDC = join(" ",@uniqword);}
	}
	elsif($sBarnumber > 0.1 and scalar(@intro) > 1.1)
	{
		for(my $i=$worD[0]-1;$i<$worD[0]+scalar(@intro);$i++){my $tmp = "$worD[$i]"."_"."$worD[$i+1]";if($tmp =~ /so_that|as_if|as_though/){$Feature_YDC ="$&";}else{my $bg = $intro[0]-1;my $ed = $intro[0]+scalar(@intro)-1;$mulYDC = "@worD[$bg .. $ed]";$Feature_YDC=YDC("@worD[$bg .. $ed]");}}
		my @ydc = split(/\s+/,$Feature_YDC);my @uniqword = uniq(@ydc);$Feature_YDC = join(" ",@uniqword);
	}
	else
	{$Feature_YDC = "none";}
	##############################主要特征
	my $First_Feature;
	my $No_Sbar_NP =0;
	if(scalar(@sbarsschild) > 0 and "@sbarsschild" !~ /NP/){$No_Sbar_NP = 1;}
	#foreach(@sbarsschild){if($_ =~ /^NP/){$No_Sbar_NP = 1}}
	my $Nonfine_loc_xxc;
	if(scalar(@intro) > 0.1){for(my $i = $sbarallword[0] - 4;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /,/){$Nonfine_loc_xxc = $i-1;}}}
	#if($No_Sbar_NP == 1){$ftr[0] =1;}
	#主语从句
	if((scalar(@intro) == 0) and $poS[$sbarallword[0]-1] =~ /JJ|VBN|VBD|NN/i){for(my $i=0;$i<$sbarallword[0];$i++){if(($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /VB/) or ($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /RB/ and $poS[$i+2] =~ /VB/)) {$First_Feature .= " "."NoNP1";}}}
	if(($worD[$sbarallword[0]-1] =~ /\b(that|whether|what)\b/i and $sBarnumber > 0.1) and $poS[$sbarallword[0]-2] =~ /JJ|VBN|VBD|NN/i){for(my $i=0;$i<$sbarallword[0];$i++){if(($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /VB/) or ($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /RB/ and $poS[$i+2] =~ /VB/)) {$First_Feature .= " "."NoNP2";}}}
	#print "$maintruck MM\n\n";
	if($maintruck !~ /NP/ and $maintruck != 1 and $sBarnumber > 0.1){$First_Feature .= " "."NoNP";}
	#宾语从句
	if($sBarnumber > 0.1){
		for(my $i=$sbarallword[0];$i>=$sbarallword[0]-5;$i--){if($worD[$i]=~/\bit\b/ and $poS[$i-1] =~ /^VB/) {for(my $j=$i+1;$j<=$sbarallword[0];$j++){if($poS[$j] !~ /VB/){$First_Feature .= " "."O_3Feature";last;}}}}
		for(my $i=$sbarallword[0]-1;$i>=$sbarallword[0]-5;$i--){if($worD[$i]=~/$double_object/) {for(my $j=$i+1;$j<$sbarallword[0];$j++){if($poS[$j] =~ /NN|PRP|DT/){$First_Feature .= " "."O_2Feature";last;}}}}
		for(my $i=$sbarallword[0];$i>=$sbarallword[0]-5;$i--){if($worD[$i] =~ /$Link_Verb/i){for(my $j=$i+1;$j<$sbarallword[0];$j++){if($worD[$j] =~ /$adjObClauseWord/i){$First_Feature .= " "."O_4Feature";last;}}}}
		if($poS[$sbarallword[0]-2] =~ /VB/ and $worD[$sbarallword[0]-2] !~ /$Link_Verb/){$First_Feature .= " "."O_5Feature";}
		if($poS[$sbarallword[0]-2] =~ /^(RB|IN|RP)/ and $poS[$sbarallword[0]-3] =~ /VB/ and $worD[$sbarallword[0]-3] !~ /$Link_Verb/){$First_Feature .= " "."O_1Feature";}
	}
	
	#表语从句
	if($sBarnumber > 0.1 and ($poS[$sbarallword[0]-2] =~ /RB/ and $worD[$sbarallword[0]-3] =~ /$Link_Verb/) or ($worD[$sbarallword[0]-2] =~ /$Link_Verb/) or ($poS[$sbarallword[0]-2] =~ /RB/ and $poS[$sbarallword[0]-3] =~ /RB/ and $poS[$sbarallword[0]-4] =~ /$Link_Verb/)){$First_Feature .= " "."PRD_1Feature";}
	#同位语从句
	if($sBarnumber > 0.1 and $worD[@{$sub_num[$nums]}[0]-1] =~ /$Link_appos/ or $worD[$sbarallword[0]-2] =~ /$Link_appos/){$First_Feature .= " "."Fst_ApposFeature";}
	#定语从句特征
	if($No_Sbar_NP == 1 and $worD[$sbarallword[0]-2] !~ /,/){$First_Feature .= " "."Att_FirstFeature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b$attr_introducer\b/ and $worD[$sbarallword[0]-1] !~ /\b(when|where|as)\b/ and $poS[$sbarallword[0]-2] =~ /NN|DT|PRT/ and $worD[$sbarallword[0]-2] !~ /$Link_appos/){$First_Feature .= " "."Att_1Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b$attr_introducer\b/ and $poS[$sbarallword[0]-1] =~ /\b(IN|RB)\b/ and $worD[$sbarallword[0]-1] =~ /which/){$First_Feature .= " "."Att_2Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b$attr_introducer\b/ and $worD[$sbarallword[0]-1] =~ /\bwhen\b/ and $worD[$sbarallword[0]-2] =~ /$time_noun/){$First_Feature .= " "."Att_3Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\bwhere\b/ and $worD[$sbarallword[0]-2] =~ /$place_noun/){$First_Feature .= " "."Att_3Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\bas\b/){for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++){if(($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bsame\b/) or ($worD[$i] =~ /\b(as|such)\b/ and $poS[$sbarallword[0]-2] =~ /^(NN|DT|PRP)/)){$First_Feature .= " "."Att_4Feature";}}}
	#非限定定语从句
	if($worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc) and scalar(@intro) > 0.1){for(my $i = $Nonfine_loc_xxc;$i<=$intro[scalar(@intro)-1];$i++){if($poS[$i] =~ /IN/ and $worD[$i+1] =~ /\bwhich\b/i){$First_Feature .= " "."Natt_1Feature";}}}
	if($sBarnumber > 0.1 and $worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc) and $worD[$sbarallword[0]-1] =~ /\bwhen\b/ and $worD[$Nonfine_loc_xxc] =~ /$time_noun/){$First_Feature .= " "."Natt_2Feature";}
	if($sBarnumber > 0.1 and $worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc) and $worD[$sbarallword[0]-1] =~ /\bwhere\b/ and $worD[$Nonfine_loc_xxc] =~ /$place_noun/){$First_Feature .= " "."Natt_3Feature";}
	if($No_Sbar_NP == 1 and $worD[$sbarallword[0]-2] =~ /,/){$First_Feature .= " "."Att_4Feature";}
	if($sBarnumber > 0.1 and $worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc) and $worD[$sbarallword[0]-1] =~ /$nattr_introducer/ and $worD[$sbarallword[0]-1] =~ /\bwhen|where\b/ and$worD[$Nonfine_loc_xxc] =~ /NN|DT/){$First_Feature .= " "."Natt_5Feature";}
	#时间状语从句
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\bsince\b/i and $worD[$spcl_loc[0]-1] =~ /\bit\b/i){$First_Feature .= " "."Tadv_1Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\bsince\b/i){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(has|had|have)\b/ and "@poS[$i+1 .. $spcl_loc[1]]" =~ /VB/){$First_Feature .= " "."Tadv_2Feature";}}}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\bsince\b/i and $sbarallword[0] <= 3){for(my $i = $spcl_loc[1];$i<=$#worD;$i++){if($worD[$i] =~ /\b(has|had|have)\b/ and "@poS[$i+1 .. $spcl_loc[1]]" =~ /VB/){$First_Feature .= " "."Tadv_3Feature";}}}
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bas\b/ and $worD[$i+1] =~ /\bsoon\b/ and $worD[$i+2] =~ /\bas\b/){$First_Feature .= " "."Tadv_4Feature";}}}
	my $sooner_than;
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bsooner\b/){$sooner_than = 1;}if($sooner_than == 1 and $worD[$i] =~ /\bthan\b/) {$First_Feature .= " "."Tadv_5Feature";}}}
	
	my ($the_two,$by_the_time,$immediately,$the_thr,$evey_time);
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(moment|minute|insant|second)\b/ and ($i <= $spcl_loc[0] or ($spcl_loc[0] < ($i) and ($i) < $spcl_loc[1]))){$the_two = 1;}if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(first|last|next)\b/ and $worD[$i+2] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$the_thr = 1;}if($worD[$i] =~ /\b(every|each)\b/i and $worD[$i+1] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$evey_time = 1;}if($worD[$i] =~ /\bby\b/i and $worD[$i+1] =~ /\b(the)\b/ and $worD[$i+2] =~ /\b(time)\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$by_the_time = 1;}if($worD[$i] =~ /\b(immediately|directly)\b/i and (($i) < $spcl_loc[0] and ($i+1) < $spcl_loc[1])){$immediately = 1;}}}
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(moment|minute|insant|second)\b/ and ($i <= $spcl_loc[0] or ($spcl_loc[0] < ($i) and ($i) < $spcl_loc[1]))){$the_two = 1;}if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(first|last|next)\b/ and $worD[$i+2] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$the_thr = 1;}if($worD[$i] =~ /\b(every|each)\b/i and $worD[$i+1] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$evey_time = 1;}if($worD[$i] =~ /\bby\b/i and $worD[$i+1] =~ /\b(the)\b/ and $worD[$i+2] =~ /\b(time)\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$by_the_time = 1;}if($worD[$i] =~ /\b(immediately|directly)\b/i and (($i) < $spcl_loc[0] and ($i+1) < $spcl_loc[1])){$immediately = 1;}}}
	if($the_two==1 or $by_the_time==1 or $immediately==1 or $the_thr==1 or $evey_time == 1) {$First_Feature .= " "."Tadv_6Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b(when|whenever|while)\b/ and $sbarallword[0] <= 3){$First_Feature .= " "."Tadv_7Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b(when)\b/ and $worD[$sbarallword[0]-2] !~ /$time_noun/ and $sbarallword[0] > 2.9){$First_Feature .= " "."Tadv_8Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b(when)\b/ and $worD[$sbarallword[0]-2] =~ /,/ and $worD[$sbarallword[0]-3] !~ /$time_noun/ and $sbarallword[0] > 2.9){$First_Feature .= " "."Tadv_9Feature";}
	#地点状语从句
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b(where)\b/ and $worD[$sbarallword[0]-2] !~ /$place_noun/ and $sbarallword[0] > 2.9){$First_Feature .= " "."Wadv_1Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b(where)\b/ and $worD[$sbarallword[0]-2] =~ /,/ and $worD[$sbarallword[0]-3] !~ /$place_noun/ and $sbarallword[0] > 2.9){$First_Feature .= " "."Wadv_2Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /anywhere|everywhere|wherever/i){$First_Feature .= " "."Wadv_3Feature";}
	#原因状语从句
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\bthat\b/ and $worD[$sbarallword[0]-2] =~ /\b(Seeing|considering|now|given)\b/i){$First_Feature .= " "."Radv_1Feature";}
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(Seeing|considering|now|given)\b/i){$First_Feature .= " "."Ccsadv_2Feature";}}for(my $i = $spcl_loc[1]-5;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(Seeing|considering|now|given)\b/i){$First_Feature .= " "."Radv_FirstFeature";}}}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\because\b/i){$First_Feature .= " "."Radv_3Feature";}
	#条件状语从句
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(assuming|providing|provided|suppose|supposing)\b/i){$First_Feature .= " "."Cadv_FirstFeature";}}for(my $i = $spcl_loc[1] - 5;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(assuming|providing|provided|suppose|supposing)\b/i){$First_Feature .= " "."Cadv_1Feature";}}}
	
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\b(if|unless)\b/i){$First_Feature .= " "."Cadv_2Feature";}
	#目的状语从句
	my $spcl_cls;
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[1]-5;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bso\b/i and $worD[$i+1] =~ /\bthat\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/ and $worD[$i+1] =~ /\bcase\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bfor\b/ and $worD[$i+1] =~ /\bfear\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bhope\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bto\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bend\b/){$spcl_cls = 1;}}}
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\bcase\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bfor\b/i and $worD[$i+1] =~ /\bfear\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bhope\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bto\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bend\b/){$spcl_cls = 1;}}}
	if($spcl_cls == 1){$First_Feature .= " "."Pradv_3Feature";}
	if($sBarnumber > 0.1 and $worD[$sbarallword[0]-1] =~ /\blest\b/i){$First_Feature .= " "."Pradv_4Feature";}
	#让步状语从句
	if(scalar(@intro) > 0.1){for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++){my $tmp = "$worD[$i]"."_"."$worD[$i+1]";if($tmp =~ /\bas_though\b/i){$First_Feature .= " "."Ccsadv_FirstFeature";}if($tmp =~ /\b(even_if|even_though)\b/i){$First_Feature .= " "."Ccsadv_1Feature";}}}
	if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$First_Feature .= " "."Ccsadv_FirstFeature";}}for(my $i = $spcl_loc[1]-3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$First_Feature .= " "."Ccsadv_2Feature";}}}
	if(scalar(@intro) > 0.1){for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bmatter\b/ and $worD[$i+2] =~ /\b$qstword\b/){$First_Feature .= " "."Ccsadv_3Feature";}}}
	if(scalar(@intro) > 0.1){for(my $i = $intro[scalar(@intro)-1];$i<=$sbarallword[scalar(@sbarallword)-1];$i++){if($worD[$i] =~ /\bwhether\b/i){for(my $j = $i;$j<=$sbarallword[scalar(@sbarallword)-1];$j++){if($worD[$j] =~ /\bor\b/i){$First_Feature .= " "."Ccsadv_4Feature";}}}}}
	if(scalar(@intro) > 0.1){for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\b$qstwordever\b/i and $i < 2.1){$First_Feature .= " "."Ccsadv_FirstFeature";}if($worD[$i] =~ /\b$qstwordever\b/i and $worD[$i-1] =~ /,|;/){$First_Feature .= " "."Ccsadv_5Feature";}}}
	if($sBarnumber > 0.1 and defined($mulYDC) and $mulYDC =~ /\b(as|though)\b/i){my $noncamma=0;for(my $i = 0;$i<=$sbarallword[0];$i++){if($worD[$i] =~ /,/){$noncamma =1;}}if($poS[0] =~ /^(NN|VB|JJ|RB)/ and $noncamma == 0){$First_Feature .= " "."Ccsadv_5Feature";}}
	if($sBarnumber > 0.1 and defined($mulYDC) and $mulYDC =~ /\b(as|though)\b/i and $sbarallword[0] > $spcl_loc[0]){my $cammaloc=0;for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /,/){$cammaloc =$i;}}if($poS[$cammaloc+1] =~ /^(NN|VB|JJ|RB)/){$First_Feature .= " "."Ccsadv_6Feature";}}
	#比较状语从句
	if(scalar(@intro) > 0.1){for(my $i = 1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$sbarallword[0]-1] =~ /\bas\b/ and $worD[$i] =~ /\bas\b/ and $poS[$i+1] =~ /(RB|JJ)/){$First_Feature .= " "."Cmpadv_1Feature";}}}
	if(scalar(@intro) > 0.1){for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\bthan\b/i){$First_Feature .= " "."Cmpadv_3Feature";}}}
	if(scalar(@spcl_loc) > 1){for(my $i = 0;$i<$spcl_loc[0];$i++){if($poS[$i] =~ /JJ(R)/){for(my $j = $spcl_loc[0];$j<$spcl_loc[1];$j++){if($poS[$j] =~ /^JJ(R)/){$First_Feature .= " "."Cmpadv_2Feature";}}}}}
	#方式状语从句
	if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bway\b/){$First_Feature .= " "."Mnradv_1Feature";}}for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bway\b/){$First_Feature .= " "."Mnradv_2Feature";}}}
	my $prd_introducerflag;
	if(scalar(@intro) > 0.1)
	{
		for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++)
	    {
		 my $tmp_indcer = "$worD[$i]"."_"."$worD[$i+1]";
		 if($tmp_indcer =~ /^(as_if|as_though)$/i ){$prd_introducerflag = 1;
		 }
	    }
	}
	
	if(($prd_introducerflag == 1 and $worD[$sbarallword[0]-2] !~ /\b$Link_Verb\b/) or ($prd_introducerflag == 1 and $worD[$sbarallword[0]-3] !~ /\b$Link_Verb\b/ and $poS[$sbarallword[0]-2] =~ /RB/) ) {$First_Feature .= " "."Mnradv_3Feature";}
	#结果状语从句
	if($sBarnumber > 0.1){for(my $i = 0;$i<=$sbarallword[0];$i++){if($worD[$i] =~ /\bso\b/ and $poS[$i+1] =~ /^(JJ|RB)/){$First_Feature .= " "."Rsladv_FirstFeature";}if($worD[$i] =~ /\bsuch\b/ and ($poS[$i+1] =~ /^JJ/ or $poS[$i+2] =~ /^JJ/)){$First_Feature .= " "."Rsladv_4Feature";}}}
	#并列句表递进
	if(scalar(@spcl_loc) > 1.5 and $sBarnumber < 0.9)
	{
		for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /^(not|'t)$/i and $worD[$i+1] =~ /\bonly\b/){if($worD[$i] =~ /but/){$First_Feature .= " "."CMAS_A";}for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bbut\b/i){$First_Feature .= " "."CMAS_A";}}}}
		for(my $i = $spcl_loc[1]-4;$i<$spcl_loc[1];$i++){if($worD[$i] =~ /(and)/i){$First_Feature .= " "."CMAS_A";}}
		for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /^(neither)$/i ){for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bnor\b/i){$First_Feature .= " "."CMAS_A";}}}}
	}
	my $v1;
	my $v2;
	if(scalar(@spcl_loc) > 1.5){for(my $i = 0;$i<=$spcl_loc[scalar(@spcl_loc)];$i++){if($worD[$i] =~ /\b(neither)\b/i){$v1=1;}if($worD[$i] =~ /\b(nor)\b/){$v2=1;}}if($v1==1 and $v2 ==1){$First_Feature .= " "."CMAS_A";}}
	if(scalar(@spcl_loc) > 1.5){for(my $i = 0;$i<=$spcl_loc[scalar(@spcl_loc)];$i++){if($worD[$i] =~ /\b(not|'t)\b/i){$v1=1;}if($worD[$i] =~ /\b(only)\b/){$v2=1;}}if($v1==1 and $v2 ==1){$First_Feature .= " "."CMAS_A";}}
	#并列句表转折
	for(my $i = $spcl_loc[1]-4;$i<$spcl_loc[1];$i++){if($worD[$i] =~ /\b(yet|but)\b/i){$First_Feature .= " "."CMBS_A";}}
	for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bhowever\b/i){$First_Feature .= " "."CMBS_A";}}
	#并列句表选择
	for(my $i = $spcl_loc[1]-4;$i<$spcl_loc[1];$i++){if( ($worD[$i] =~ /\b(or)\b/i and $worD[$i+1] =~ /\beles\b/) or $worD[$i] =~ /\b(or|otherwise)\b/i){$First_Feature .= " "."CMCS_A";}}
	for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /^(either)$/i ){for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bor\b/i){$First_Feature .= " "."CMCS_A";}}}}
	#并列句表选择
	if($worD[$sbarallword[0]-1] =~ /\b(so|for)\b/ and $worD[$sbarallword[0]-2] =~ /,/){$First_Feature .= " "."CMRS_A";}
	for(my $i = $spcl_loc[1]-5;$i<$spcl_loc[1];$i++){if ($worD[$i] =~ /\b(so)\b/i and $worD[$i-1] =~ /,/){$First_Feature .= " "."CMRS_A";}}
	#简单句
	if($sBarnumber < 0.9 and scalar(@spcl_loc) <1.1){$First_Feature .= " "."SS_A";}
	
	if($First_Feature eq ""){$First_Feature = "NoN";}else{$First_Feature =~ s/^\s+//;}
	#print"量化的特征: ";
	#print "PC	";
	#for(my $i =0;$i<23;$i++){if($i == 22){print "$n_v[$i]";next;}print "$n_v[$i]	";}print "\n";
	#my $N_V_String = "$n_v[0]"."	"."$n_v[1]";
	return $First_Feature;
}

#############################################
sub YDC
{
	my $intro = shift;
	my $out_feature;
	my $sub_introducer = qr/\b(that|whether|who|whoever|what|whatever|which|whichever|whom|whose|how|why|when|while)\b/i;
	my $sub_string = "that whether who whoever what whatever which whichever whom whose how why when while";
	my $o_introducer = qr/\b(that|whether|what|who|which|whose|how|why|whom|if|whose|whoever|whomever|whosever|whatever|whichever|why|how|however|when|where|whenever|wherever)\b/;
	my $o_string = "that whether what who which whose how why whom if whose whoever whomever whosever whatever whichever why how however when where whenever wherever";
	my $prd_introducer = qr/\b(that|whether|who|whoever|whom|whose|what|whatever|which|whichever|when|where|how|why|as_if|as_though|when|where)\b/i;
	my $prd_string = "that whether who whoever whom whose what whatever which whichever when where how why as_if as_though when where";
	my $appos_introducer = qr/\b(that|whether|what|which|who|how|why|when|where)\b/i;
	my $appos_string = "that whether what which who how why when where";
	my $attr_introducer = qr/\b(that|how|whose|whom|who|which|why|when|where)\b/i;
	my $attr_string = "that how whose whom who which why when where";
	my $mnr_introducer = qr/\b(as|as_if|as_though)\b/i;
	my $mnr_string = "as as_if as_though";
	my $nattr_introducer = qr/\b(how|whose|whom|who|which|when|where|as)\b/i;
	my $nattr_string = "how whose whom who which when where as";
	my $pre_introducer = qr/(lest|so_that|that)/i;#目的状语从句引导词
	my $pre_string = "lest so_that that";
	my $time_introducer = qr/^(before|after|till|until|when|while|whenever)$/i;
	my $time_string = "before after till until when while whenever";
	my $rsn_introducer = qr/\b(since|now_that|because)\b/i;
	my $rsn_string = "since now_that because";
	my $where_introducer= qr/\b(where|anywhere|everywhere|wherever)\b/i;
	my $where_string = "where anywhere everywhere wherever";
	my $cdt_introducer = qr/\b(if|unless)\b/i;
	my $cdt_string = "if unless";
	my $Css_introducer = qr/\b(though|although|as|that)\b/i;
	my $Css_string = "though although as that";
	my $rsl_introducer = qr/\b(so_that|that)\b/i;
	my $rsl_string = "so_that that";
	my $cmp_introducer = qr/\b(than|as)\b/i;
	my $cmp_string = "than as";
	if($intro =~ /$sub_introducer/i){$out_feature .= " $sub_string";}
	if($intro =~ /$o_introducer/i){$out_feature .= " $o_string";}
	if($intro =~ /$prd_introducer/i){$out_feature .= " $prd_string";}
	if($intro =~ /$appos_introducer/i){$out_feature .= " $appos_string";}
	if($intro =~ /$attr_introducer/i){$out_feature .= " $attr_string";}
	if($intro =~ /$mnr_introducer/i){$out_feature .= " $mnr_string";}
	if($intro =~ /$nattr_introducer/i){$out_feature .= " $nattr_string";}
	if($intro =~ /$pre_introducer/i){$out_feature .= " $pre_string";}
	if($intro =~ /$time_introducer/i){$out_feature .= " $time_string";}
	if($intro =~ /$rsn_introducer/i){$out_feature .= " $rsn_string";}
	if($intro =~ /$where_introducer/i){$out_feature .= " $where_string";}
	if($intro =~ /$cdt_introducer/i){$out_feature .= " $cdt_string";}
	if($intro =~ /$Css_introducer/i){$out_feature .= " $Css_string";}
	if($intro =~ /$rsl_introducer/i){$out_feature .= " $rsl_string";}
	if($intro =~ /$cmp_introducer/i){$out_feature .= " $cmp_string";}
	if($out_feature eq ""){$out_feature = "$intro";}
	$out_feature =~ s/^\s+//;
	return $out_feature;
}

 ####225-227
 
 # my $sub_introducerflag;
	# my ($sub_introducerflag,$o_introducerflag,$prd_introducerflag,$appos_introducerflag,$attr_introducerflag,$nattr_introducerflag,$time_introducerflag,$where_introducerflag,$rsn_introducerflag,$cdt_introducerflag,$pre_introducerflag,$Css_introducerflag,$cmp_introducerflag,$rsl_introducerflag,$mnr_introducerflag) = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	# my ($sub_xxcflag,$o_xxcflag,$prd_xxcflag,$appos_xxcflag,$attr_xxcflag,$nattr_xxcflag,$time_xxcflag,$where_xxcflag,$rsn_xxcflag,$cdt_xxcflag,$pre_xxcflag,$Css_xxcflag,$cmp_xxcflag,$rsl_xxcflag,$mnr_xxcflag) = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	# if(scalar(@intro) == 1){for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /$sub_introducer/){$sub_introducerflag = 1;}if($worD[$i] =~ /$o_introducer/){$o_introducerflag = 1;}if($worD[$i] =~ /$prd_introducer/){$prd_introducerflag = 1;}if($worD[$i] =~ /$appos_introducer/){$appos_introducerflag = 1;}if($worD[$i] =~ /$attr_introducer/){$attr_introducerflag = 1;}if($worD[$i] =~ /$nattr_introducer/){$nattr_introducerflag = 1;}if($worD[$i] =~ /$time_introducer/){$time_introducerflag = 1;}if($worD[$i] =~ /$where_introducer/){$where_introducerflag = 1;}if($worD[$i] =~ /$rsn_introducer/){$rsn_introducerflag = 1;}if($worD[$i] =~ /$cdt_introducer/){$cdt_introducerflag = 1;}if($worD[$i] =~ /$pre_introducer/){$pre_introducerflag = 1;}if($worD[$i] =~ /$Css_introducer/){$Css_introducerflag = 1;}if($worD[$i] =~ /$cmp_introducer/){$cmp_introducerflag = 1;}if($worD[$i] =~ /$rsl_introducer/){$rsl_introducerflag = 1;}if($worD[$i] =~ /$mnr_introducer/){$mnr_introducerflag = 1;}}}
	# my $forth_ele;
	# my $fifth_ele;
	# my $forth_vle;
	# my $fifth_vle;
	# if(scalar(@intro) == 0)
	# {
		# $forth_ele = "$sub_introducerflag$o_introducerflag$prd_introducerflag$appos_introducerflag$attr_introducerflag$nattr_introducerflag$time_introducerflag$where_introducerflag";
		# $fifth_ele = "$rsn_introducerflag$cdt_introducerflag$pre_introducerflag$Css_introducerflag$cmp_introducerflag$rsl_introducerflag$mnr_introducerflag";
		# $forth_vle = oct( '0b'.$forth_ele);
		# $fifth_vle = oct( '0b'.$fifth_ele);
	# }
	# if(scalar(@intro) == 1)
	# {
		# $forth_ele = "$sub_introducerflag$o_introducerflag$prd_introducerflag$appos_introducerflag$attr_introducerflag$nattr_introducerflag$time_introducerflag$where_introducerflag";
		# $fifth_ele = "$rsn_introducerflag$cdt_introducerflag$pre_introducerflag$Css_introducerflag$cmp_introducerflag$rsl_introducerflag$mnr_introducerflag";
		# $forth_vle = oct( '0b'.$forth_ele);
		# $fifth_vle = oct( '0b'.$fifth_ele);
	# }
	# if(scalar(@intro) > 1.1){for(my $i = $intro[0]-1;$i<=$intro[scalar(@intro)-1];$i++){my $tmp = "$worD[$i]"."_"."$worD[$i+1]"; if($tmp =~ /$sub_introducer/){$sub_introducerflag = 1;}if($tmp =~ /$o_introducer/){$o_introducerflag = 1;}if($tmp =~ /$prd_introducer/){$prd_introducerflag = 1;}if($tmp =~ /$appos_introducer/){$appos_introducerflag = 1;}if($tmp =~ /$attr_introducer/){$attr_introducerflag = 1;}if($tmp =~ /$nattr_introducer/){$nattr_introducerflag = 1;}if($tmp =~ /$time_introducer/){$time_introducerflag = 1;}if($tmp =~ /$where_introducer/){$where_introducerflag = 1;}if($tmp =~ /$rsn_introducer/){$rsn_introducerflag = 1;}if($tmp =~ /$cdt_introducer/){$cdt_introducerflag = 1;}if($tmp =~ /$pre_introducer/){$pre_introducerflag = 1;}if($tmp =~ /$Css_introducer/){$Css_introducerflag = 1;}if($tmp =~ /$cmp_introducer/){$cmp_introducerflag = 1;}if($tmp =~ /$rsl_introducer/){$rsl_introducerflag = 1;}if($tmp =~ /$mnr_introducer/){$mnr_introducerflag = 1;}}}
	# if(scalar(@intro) > 1.1)
	# {
		# $forth_ele = "$sub_introducerflag$o_introducerflag$prd_introducerflag$appos_introducerflag$attr_introducerflag$nattr_introducerflag$time_introducerflag$where_introducerflag";
		# $fifth_ele = "$rsn_introducerflag$cdt_introducerflag$pre_introducerflag$Css_introducerflag$cmp_introducerflag$rsl_introducerflag$mnr_introducerflag";
		# $forth_vle = oct( '0b'.$forth_ele);
		# $fifth_vle = oct( '0b'.$fifth_ele);
	# }
	# if(scalar(@intro) > 0.9){$n_v[2] = 1;}else{$n_v[2] = 0;}
	# $n_v[3] = $forth_vle;
	# $n_v[4] = $fifth_vle;
	# #################################################
	# if(scalar(@intro) == 1){my $xxc_loc = $sbarallword[0];if($xxc_loc = 1){$sub_xxcflag = 1;}
	# if($worD[$xxc_loc-2] !~ /$Link_Verb|$Non_OC_Verb|$special_verb/ and $poS[$xxc_loc-2] =~ /^VB/){$o_xxcflag=1;}
	# if($worD[$xxc_loc-2] =~ /$Link_Verb/ or ($worD[$xxc_loc-3] =~ /$Link_Verb/ and $poS[$xxc_loc-2] =~ /RB/)){$prd_xxcflag=1;}
	# if($worD[$xxc_loc-2] =~ /$Link_appos/ or $worD[@{$sub_num[$nums]}[0]-1] =~ /$Link_appos/){$appos_xxcflag=1;}
	# if($poS[$xxc_loc-2] =~ /^(NN|PRP|DT)/ and ($worD[$xxc_loc-3] !~ /,/ or $worD[$xxc_loc-4] !~ /,/)){$attr_xxcflag=1;}
	# if($worD[$xxc_loc-2] =~ /,/ and $worD[$xxc_loc-3] =~ /^NN|PRP/){$nattr_xxcflag=1;}
	# my $sixth_ele = "$sub_xxcflag$o_xxcflag$prd_xxcflag$appos_xxcflag$attr_xxcflag$nattr_xxcflag";
	# my $sixth_vle = oct( '0b'.$forth_ele);
	# $n_v[5] = $sixth_vle;
	# }
	# my @ftr = (0)x8;
	# #######主语从句的特征
	# if($maintruck !~ /NP/){$ftr[0]=1;}
	# if(($worD[$sbarallword[0]-1] =~ /\b(that|whether|what)\b/i) and $poS[$sbarallword[0]-2] =~ /JJ|VBN|VBD|NN/i){for(my $i=0;$i<$sbarallword[0];$i++){if(($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /VB/) or ($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /RB/ and $poS[$i+2] =~ /VB/)) {$ftr[1] = 1;}}}
	# if((scalar(@intro) == 0) and $poS[$sbarallword[0]-1] =~ /JJ|VBN|VBD|NN/i){for(my $i=0;$i<$sbarallword[0];$i++){if(($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /VB/) or ($worD[$i]=~ /\b(it)\b/i and $poS[$i+1] =~ /RB/ and $poS[$i+2] =~ /VB/)) {$ftr[2] = 1;}}}
	# ########################################主语从句
	# my $senventh_vle = oct( '0b'.arr_to_str(\@ftr));
	# $n_v[6] = $senventh_vle;
	# @ftr = (0)x8;
	# ###########宾语从句的特征
	# if($worD[0] !~ /\bit\b/i){for(my $i=$sbarallword[0];$i>=$sbarallword[0]-5;$i--){if($worD[$i] =~ /$Link_Verb/i){for(my $j=$i+1;$j<$sbarallword[0];$j++){if($worD[$j] =~ /$adjObClauseWord/i){$ftr[0] =1;}}}}}
	# for(my $i=$sbarallword[0];$i>=$sbarallword[0]-5;$i--){if($worD[$i]=~/\bit\b/ and $poS[$i-1] =~ /^VB/) {for(my $j=$i+1;$j<=$sbarallword[0];$j++){if($poS[$j] !~ /VB/){$ftr[1] =1;}}}}
	# for(my $i=$sbarallword[0]-1;$i>=$sbarallword[0]-5;$i--){if($worD[$i]=~/$double_object/) {for(my $j=$i+1;$j<$sbarallword[0];$j++){if($poS[$j] =~ /NN|PRP|DT/){$ftr[2] =1;}}}}
	# ########################################宾语从句
	# my $eigth_vle = oct( '0b'.arr_to_str(\@ftr));
	# $n_v[7] = $eigth_vle;
	# @ftr = (0)x8;
	# #######表语从句的特征
	# if(($poS[$sbarallword[0]-2] =~ /RB/ and $worD[$sbarallword[0]-3] =~ /$Link_Verb/) or ($worD[$sbarallword[0]-2] =~ /$Link_Verb/) or ($poS[$sbarallword[0]-2] =~ /RB/ and $poS[$sbarallword[0]-3] =~ /RB/ and $poS[$sbarallword[0]-4] =~ /$Link_Verb/)){$ftr[0] =1;}
	# ########################################表语从句
	# #print arr_to_str(\@ftr);
	# $n_v[8] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ###########同位语从句的特征
	# if($worD[@{$sub_num[$nums]}[0]-1] =~ /$Link_appos/ or $worD[$sbarallword[0]-2] =~ /$Link_appos/){$ftr[0] =1;}
	# ########################################同位语从句
	# $n_v[9] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################定语从句的特征
	# my $No_Sbar_NP;
	# foreach(@sbarsschild){if($_ !~ /^NP/){$No_Sbar_NP = 1}}
	# if($No_Sbar_NP == 1){$ftr[0] =1;}
	# if(scalar(@acl) > 0.1){$ftr[1] =1;}
	# if($worD[$sbarallword[0]-1] =~ /\bwhen\b/ and $worD[$sbarallword[0]-1] =~ /$time_noun/){$ftr[2] =1;}
	# if($worD[$sbarallword[0]-1] =~ /\bwhere\b/ and $worD[$sbarallword[0]-1] =~ /$place_noun/){$ftr[3] =1;}
	# if($worD[$sbarallword[0]-1] =~ /\bas\b/){for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++){if(($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bsame\b/) or ($worD[$i] =~ /\b(as|such)\b/ and $poS[$sbarallword[0]-2] =~ /^(NN|DT|PRP)/)){$ftr[3] =1;}}}
	
	# ########################################定语从句
	# $n_v[10] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################非限定定语从句的特征
	# my $Nonfine_loc_xxc;
	# for(my $i = $sbarallword[0] - 4;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /,/){$Nonfine_loc_xxc = $i-1;}}
	# if($No_Sbar_NP == 1){$ftr[0] =1;}
	# if($worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc)){for(my $i = $Nonfine_loc_xxc;$i<=$intro[scalar(@intro)-1];$i++){if($poS[$i] =~ /IN/ and $worD[$i+1] =~ /\bwhich\b/i){$ftr[1] =1;}}}
	# if($worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc) and $worD[$sbarallword[0]-1] =~ /\bwhen\b/ and $worD[$Nonfine_loc_xxc] =~ /$time_noun/){$ftr[2] =1;}
	# if($worD[$Nonfine_loc_xxc+1] =~ /,/ and defined($Nonfine_loc_xxc) and $worD[$sbarallword[0]-1] =~ /\bwhere\b/ and $worD[$Nonfine_loc_xxc] =~ /$place_noun/){$ftr[3] =1;}
	
	# my $as_vb_loc;
	# my @verb = @{$pub_num[$nums]};
	# for(my $i = 0;$i<=$#verb;$i++){if($sbarallword[0] < $verb[$i] and $verb[$i] < $sbarallword[scalar[@sbarallword]-1]){$as_vb_loc = $verb[$i]}}
	# if($worD[$sbarallword[0]-1] =~ /\bas\b/i and ($worD[$as_vb_loc - 1] =~ /$as_vb/)){$ftr[4] = 1;}
	# ########################################非限定定语从句
	# $n_v[10] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################时间状语从句的特征
	# if($worD[$sbarallword[0]-1] =~ /\bsince\b/i and $worD[$spcl_loc[0]-1] =~ /\bit\b/i){$ftr[0] = 1;}
	# if($worD[$sbarallword[0]-1] =~ /\bsince\b/i){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(has|had|have)\b/ and "@poS[$i+1 .. $spcl_loc[1]]" =~ /VB/){$ftr[0] = 1;}}}
	# if($worD[$sbarallword[0]-1] =~ /\bsince\b/i and $sbarallword[0] <= 3){for(my $i = $spcl_loc[1];$i<=$#worD;$i++){if($worD[$i] =~ /\b(has|had|have)\b/ and "@poS[$i+1 .. $spcl_loc[1]]" =~ /VB/){$ftr[0] = 1;}}}
	# if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bas\b/ and $worD[$i+1] =~ /\bsoon\b/ and $worD[$i+2] =~ /\bas\b/){$ftr[1]=1;}}}
	# my $sooner_than;
	# if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bsooner\b/){$sooner_than = 1;}if($sooner_than == 1 and $worD[$i] =~ /\bthan\b/) {$ftr[2] =1;}}}
	
	
	# my ($the_two,$by_the_time,$immediately,$the_thr,$evey_time);
	# if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(moment|minute|insant|second)\b/ and ($i <= $spcl_loc[0] or ($spcl_loc[0] < ($i) and ($i) < $spcl_loc[1]))){$the_two = 1;}if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(first|last|next)\b/ and $worD[$i+2] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$the_thr = 1;}if($worD[$i] =~ /\b(every|each)\b/i and $worD[$i+1] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$evey_time = 1;}if($worD[$i] =~ /\bby\b/i and $worD[$i+1] =~ /\b(the)\b/ and $worD[$i+2] =~ /\b(time)\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$by_the_time = 1;}if($worD[$i] =~ /\b(immediately|directly)\b/i and (($i) < $spcl_loc[0] and ($i+1) < $spcl_loc[1])){$immediately = 1;}}}
	# if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(moment|minute|insant|second)\b/ and ($i <= $spcl_loc[0] or ($spcl_loc[0] < ($i) and ($i) < $spcl_loc[1]))){$the_two = 1;}if($worD[$i] =~ /\bthe\b/i and $worD[$i+1] =~ /\b(first|last|next)\b/ and $worD[$i+2] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$the_thr = 1;}if($worD[$i] =~ /\b(every|each)\b/i and $worD[$i+1] =~ /\btime\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$evey_time = 1;}if($worD[$i] =~ /\bby\b/i and $worD[$i+1] =~ /\b(the)\b/ and $worD[$i+2] =~ /\b(time)\b/ and (($i) < $spcl_loc[0] || ($spcl_loc[0] < $i and $i < $spcl_loc[1]))){$by_the_time = 1;}if($worD[$i] =~ /\b(immediately|directly)\b/i and (($i) < $spcl_loc[0] and ($i+1) < $spcl_loc[1])){$immediately = 1;}}}
	# if($the_two==1 or $by_the_time==1 or $immediately==1 or $the_thr==1 or $evey_time == 1) {$ftr[3]=1;}
	# if($worD[$sbarallword[0]-1] =~ /\b(when|whenever|while)\b/ and $sbarallword[0] <= 3){$ftr[4] = 1;}
	# if($worD[$sbarallword[0]-1] =~ /\b(when)\b/ and $worD[$sbarallword[0]-2] !~ /$time_noun/ and $sbarallword[0] > 2.9){$ftr[4] = 1;}
	# if($worD[$sbarallword[0]-1] =~ /\b(when)\b/ and $worD[$sbarallword[0]-2] =~ /,/ and $worD[$sbarallword[0]-3] !~ /$time_noun/ and $sbarallword[0] > 2.9){$ftr[4] = 1;}
	# ########################################时间状语从句
	# $n_v[11] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################地点状语从句的特征
	# if($worD[$sbarallword[0]-1] =~ /\b(where)\b/ and $worD[$sbarallword[0]-2] !~ /$place_noun/ and $sbarallword[0] > 2.9){$ftr[0] = 1;}
	# if($worD[$sbarallword[0]-1] =~ /\b(where)\b/ and $worD[$sbarallword[0]-2] =~ /,/ and $worD[$sbarallword[0]-3] !~ /$place_noun/ and $sbarallword[0] > 2.9){$ftr[0] = 1;}
	# ########################################地点状语从句
	# $n_v[12] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################原因状语从句的特征
	# if($worD[$sbarallword[0]-1] =~ /\bthat\b/ and $worD[$sbarallword[0]-2] =~ /\b(Seeing|considering|now|given)\b/i){$ftr[0]=1;}
	# if($worD[$sbarallword[0]-1] =~ /\because\b/i){$ftr[1] = 1;}
	# ########################################原因状语从句
	# $n_v[13] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################条件状语从句的特征
	# if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(assuming|providing|provided|suppose|supposing)\b/i){$ftr[0] = 1;}}for(my $i = $spcl_loc[1] - 3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(assuming|providing|provided|suppose|supposing)\b/i){$ftr[0] = 1;}}}
	# ########################################条件状语从句
	# $n_v[14] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################目的状语从句的特征
	# my $spcl_cls;
	# if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bfor\b/ and $worD[$i+1] =~ /\bfear\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\border\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bin\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bhope\b/){$spcl_cls = 1;}if($worD[$i] =~ /\bto\b/i and $worD[$i+1] =~ /\bthe\b/ and $worD[$i+2] =~ /\bend\b/){$spcl_cls = 1;}}}
	# if($spcl_cls == 1){$ftr[0]=1;}
	# ########################################目的状语从句
	# $n_v[15] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	# ########################################让步状语从句的特征
	# for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++){my $tmp = "$worD[$i]"."_"."$worD[$i+1]";if($tmp !~ /\bas_though\b/i){$ftr[0]=1;}if($tmp =~ /\b(even_if|even_though)\b/i){$ftr[0]=1;}}
	# if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$ftr[1]=1;}}for(my $i = $spcl_loc[1]-3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$ftr[1]=1;}}}if(scalar(@spcl_loc) > 1.9){for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$ftr[1]=1;}}for(my $i = $spcl_loc[1]-3;$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\b(granting|granted)\b/i){$ftr[1]=1;}}}
	# for(my $i = 0;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\bno\b/i and $worD[$i+1] =~ /\bmatter\b/ and $worD[$i+2] =~ /\b$qstword\b/){$ftr[2]=1;}}
	# for(my $i = $intro[scalar(@intro)-1];$i<=$sbarallword[scalar(@sbarallword)-1];$i++){if($worD[$i] =~ /\bwhether\b/i){for(my $j = $i;$j<=$sbarallword[scalar(@sbarallword)-1];$j++){if($worD[$j] =~ /\bor\b/i){$ftr[3] =1;}}}}
	# for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\b$qstwordever\b/i and $i < 2.1){$ftr[4]=1;}if($worD[$i] =~ /\b$qstwordever\b/i and $worD[$i-1] =~ /,|;/){$ftr[4]=1;}}
	# if($worD[$sbarallword[0]-1] =~ /\b(as|though)\b/){my $noncamma=0;for(my $i = 0;$i<=$sbarallword[0];$i++){if($worD[$i] =~ /,/){$noncamma =1;}}if($worD[0] =~ /^(NN|VB|JJ|RB)/ and $noncamma == 0){$ftr[5]=1;}}
	# if($worD[$sbarallword[0]-1] =~ /\b(as|though)\b/ and $sbarallword[0] > $spcl_loc[0]){my $cammaloc=0;for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /,/){$cammaloc =$i;}}if($worD[$cammaloc+1] =~ /^(NN|VB|JJ|RB)/){$ftr[5]=1;}}
	# ########################################让步状语从句
	# $n_v[16] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	
	
	# ########################################比较状语从句的特征
	# for(my $i = 1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$sbarallword[0]-1] =~ /\bas\b/ and $worD[$i] =~ /\bas\b/ and $poS[$i+1] =~ /(RB|JJ)/){$ftr[0]=1;}}
	# for(my $i = $intro[0]-1;$i<$intro[scalar(@intro)-1];$i++){if($worD[$i] =~ /\bthan\b/i){$ftr[1]=1;}}
	# if(scalar(@spcl_loc) > 1){for(my $i = 0;$i<$spcl_loc[0];$i++){if($poS[$i] =~ /JJ(R)/){for(my $j = $spcl_loc[0];$j<$spcl_loc[1];$j++){if($poS[$j] =~ /^JJ(R)/){$ftr[2]=1;}}}}}
	# ########################################比较状语从句
	# $n_v[16] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################方式状语从句的特征
	# if(scalar(@spcl_loc) > 1.9){for(my $i = $spcl_loc[0];$i<=$spcl_loc[1];$i++){if($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bway\b/){$ftr[0]=1;}}for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /\bthe\b/ and $worD[$i+1] =~ /\bway\b/){$ftr[0]=1;}}}
	
	# my $prd_introducerflag;
	# for(my $i = $intro[0]-2;$i<=$intro[scalar(@intro)-1];$i++)
	# {
		# my $tmp_indcer = "$worD[$i]"."_"."$worD[$i+1]";
		# if($tmp_indcer =~ /^(as_if|as_though)$/i ){$prd_introducerflag = 1;
		# }
	# }
	# if(($prd_introducerflag == 1 and $worD[$sbarallword[0]-2] !~ /\b$Link_Verb\b/) or ($prd_introducerflag == 1 and $worD[$sbarallword[0]-3] !~ /\b$Link_Verb\b/ and $poS[$sbarallword[0]-2] =~ /RB/) ) {$ftr[1]=1;}
	# ########################################方式状语从句
	# $n_v[17] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################结果状语从句的特征
	# for(my $i = 0;$i<=$sbarallword[0];$i++){if($worD[$i] =~ /\bso\b/ and $poS[$i+1] =~ /^(JJ|RB)/){$ftr[0]=1;}if($worD[$i] =~ /\bsuch\b/ and ($poS[$i+1] =~ /^JJ/ or $poS[$i+2] =~ /^JJ/)){$ftr[0]=1;}}
	# ########################################结果状语从句
	# $n_v[18] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################并列句表递进特征
	# for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /^(not|'t)$/i and $worD[$i+1] =~ /\bonly\b/){if($worD[$i] =~ /but/){$ftr[0]=1;}for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bbut\b/i){$ftr[0]=1;}}}}
	# for(my $i = $spcl_loc[1]-4;$i<$spcl_loc[1];$i++){if($worD[$i] =~ /(,|;|and)/i){$ftr[1]=1;}}
	# for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /^(neither)$/i ){for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bnor\b/i){$ftr[0]=1;}}}}
	# ########################################并列句表递进
	# $n_v[19] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################并列句表转折特征
	# for(my $i = $spcl_loc[1]-4;$i<$spcl_loc[1];$i++){if($worD[$i] =~ /\b(yet|but)\b/i){$ftr[0]=1;}}
	# for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bhowever\b/i){$ftr[1]=1;}}
	# ########################################并列句表转折
	# $n_v[20] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################并列句表选择特征
	# for(my $i = $spcl_loc[1]-4;$i<$spcl_loc[1];$i++){if( ($worD[$i] =~ /\b(or)\b/i and $worD[$i+1] =~ /\beles\b/) or $worD[$i] =~ /\b(or|otherwise)\b/i){$ftr[0]=1;}}
	# for(my $i = 0;$i<=$spcl_loc[0];$i++){if($worD[$i] =~ /^(either)$/i ){for(my $j = $spcl_loc[0];$j<=$spcl_loc[1];$j++){if($worD[$j] =~ /\bor\b/i){$ftr[1]=1;}}}}
	# ########################################并列句表选择
	# $n_v[21] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
	# ########################################并列句表因果特征
	# if($worD[$sbarallword[0]-1] =~ /\b(so|for)\b/ and $worD[$sbarallword[0]-2] =~ /,/){$ftr[0]=1;}
	# for(my $i = $spcl_loc[1]-5;$i<$spcl_loc[1];$i++){if ($worD[$i] =~ /\b(so)\b/i and $worD[$i-1] =~ /,/){$ftr[0]=1;}}
	# ########################################并列句表选择
	# #foreach(@ftr){print"$_ FFFF\n";}
	# #my $test = "@ftr";
	# # my $tmp = "@ftr";
	 # #print"$tmp FFF";
	# $n_v[22] = oct( '0b'.arr_to_str(\@ftr));@ftr = (0)x8;
	
 
 
 # my @sub_location = Sentence_Sub_Locate();
 # foreach(@sub_location){my @ttt = @{$_};
 # print "@ttt\n";
# print  "__DDDDDDD\n";}
 
 sub arr_to_str
 {
	my $arr_ref = shift;
	my @arr = @$arr_ref;
	my $str = "@arr";
	$str =~ s/\s+//g;
	return $str;
 }
 
 
 
 
 
 
 
 