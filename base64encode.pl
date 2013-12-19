#!C:\perl\bin\perl
use MIME::Base64;

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
	$_ = encode_base64($_);	
	print OUT "$_\n";
}
close(OUT);
close(FILE);
