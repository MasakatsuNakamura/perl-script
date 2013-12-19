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
	if (/=\?[iI][sS][oO]-2022-[jJ][pP]\?B\?([0-9a-zA-Z\+\/]+)=*\?=/) {
		($pre, $encode, $code, $next) = /^(.*)(=\?[iI][sS][oO]-2022-[jJ][pP]\?B\?([0-9a-zA-Z\+\/]+)=*\?=)(.*)$/;
		$code .= "==";
		$code = decode_base64($code);	
		$_ = "$pre$code$next\n";
	} else {
		print OUT "$_\n";
	}
}
close(OUT);
close(FILE);
