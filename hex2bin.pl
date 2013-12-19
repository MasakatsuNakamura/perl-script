#!C:\perl\bin\perl
if ($#ARGV == -1) {
	exit(1);
} elsif (!(-f $ARGV[0])) {
	exit(1);
}
$out = $ARGV[0]. ".txt";
open(FILE, $ARGV[0]) || die;
open(OUT, ">$out") || die;
while(<FILE>) {
	chop;
	s/ //g;
	s/([0-9a-f][0-9a-f])/pack("C", hex($1))/eg;
	print OUT "$_\n";
}
close(OUT);
close(FILE);
