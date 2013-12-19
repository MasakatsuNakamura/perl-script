#!C:\perl\bin\perl
if ($#ARGV == -1) {
	exit(1);
} elsif (!(-f $ARGV[0])) {
	exit(1);
}
$out = $ARGV[0]. ".txt";
open(FILE, $ARGV[0]) || die;
open(OUT, ">$out") || die;
$first = 1;
while(<FILE>) {
	chop;
	push(@lines, $_);
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	foreach $c (@line){
		if ($c eq "~") {
			print OUT "false,";
		} elsif ($c eq "›") {
			print OUT "true,";
		} elsif ($c =~ /^\-?[0-9\,]+$/) {
			if ($c >= -10 && $c <= 10) {
				print OUT "$c,";
			} else {
				print OUT "\"$c\",";
			}
		} else {
			print OUT "\"$c\",";
		}
		$first = 0;
	}
	print OUT "\n";
}
