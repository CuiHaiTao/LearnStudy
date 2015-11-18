use strict;
my $usage = "perl merge_sentence.pl file para";
@ARGV || die "$usage\n";

my ($file,$argue) = @ARGV;
my $file_hdl;
open($file_hdl,"< $file") or die "can not open it!\n";
my $out_file_hdl;
open($out_file_hdl,">> ..\\Data\\tag_sentence.txt") or die "can not append it!\n";
while(<$file_hdl>)
{
	chomp;
	s/\t/ /g;
	s/\s+/ /g;
	s/\s+$//;
	#next if $_ =~ /^\s+$/;
	next if /^\s*$/;
	if($argue =~ /SS/i){print $out_file_hdl "SS	$_\n"};
	if($argue =~ /CMAS/i){print $out_file_hdl "CMAS	$_\n"};
	if($argue =~ /CMBS/i){print $out_file_hdl "CMBS	$_\n"};
	if($argue =~ /CMCS/i){print $out_file_hdl "CMCS	$_\n"};
	if($argue =~ /CMFS/i){print $out_file_hdl "CMFS	$_\n"};
	if($argue =~ /ATC/i){print $out_file_hdl "ATC	$_\n"};
	if($argue =~ /NATC/i){print $out_file_hdl "NATC	$_\n"};
	if($argue =~ /TADVC/i){print $out_file_hdl "TADVC	$_\n"};
	if($argue =~ /WADVC/i){print $out_file_hdl "WADVC	$_\n"};
	if($argue =~ /RADVC/i){print $out_file_hdl "RADVC	$_\n"};
	if($argue =~ /CADVC/i){print $out_file_hdl "CADVC	$_\n"};
	if($argue =~ /PADVC/i){print $out_file_hdl "PADVC	$_\n"};
	if($argue =~ /CCSADVC/i){print $out_file_hdl "CCSADVC	$_\n"};
	if($argue =~ /CMPADVC/i){print $out_file_hdl "CMPADVC	$_\n"};
	if($argue =~ /MNRADVC/i){print $out_file_hdl "MNRADVC	$_\n"};
	if($argue =~ /RSLADVC/i){print $out_file_hdl "RSLADVC	$_\n"};
	if($argue =~ /PC/i){print $out_file_hdl "PC	$_\n"};
	if($argue =~ /SC/i){print $out_file_hdl "SC	$_\n"};
	if($argue =~ /OC/i){print $out_file_hdl "OC	$_\n"};
	if($argue =~ /AC/i){print $out_file_hdl "AC	$_\n"};
}
close($file_hdl);
close($out_file_hdl);
