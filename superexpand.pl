#!C:\perl\bin\perl -w
$indent = 0;
$space = 2;

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
	push(@lines, $_);
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	for($i = 0; $i <= $#line; $i++){
		$length = length($line[$i]);
		if ($max[$i] < $length) {
			$max[$i] = $length;
		}
	}
}

foreach(@lines) {
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	for ($j = 0; $j < $indent; $j++) {
		print OUT " ";
	}
	for($i = 0; $i <= $#line; $i++){
		if ($line[$i] =~ /^[0-9]+$/) {
			$spaces = $max[$i] - length($line[$i]);
			for ($j = 0; $j < $spaces; $j++) {
				print OUT " ";
			}
			print OUT $line[$i];
			for ($j = 0; $j < $space; $j++) {
				print OUT " ";
			}
		} else {
			print OUT $line[$i];
			$spaces = $max[$i] - length($line[$i]) + $space;
			for ($j = 0; $j < $spaces; $j++) {
				print OUT " ";
			}
		}
	}
	print OUT "\n";
}
