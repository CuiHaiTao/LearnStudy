use strict;
my $usage = "perl merge_sentence.pl file para";
@ARGV || die "$usage\n";

my ($file) = @ARGV;
my $file_hdl;
open($file_hdl,"< $file") or die "can not open it!\n";
my $out_file_label_hdl;
open($out_file_label_hdl,"> ..\\Data\\Label_Cls") or die "can not append it!\n";
my $out_file_sentence_hdl;
open($out_file_sentence_hdl,"> ..\\Data\\Label_Cls_Sentence") or die "can not append it!\n";
while(<$file_hdl>)
{
	chomp;
	my($Lab,$sentence) = split/\t/,$_;
	print $out_file_label_hdl "$Lab\n";
	print $out_file_sentence_hdl "$sentence\n";
}
close($file_hdl);
close($out_file_label_hdl);
close($out_file_sentence_hdl);