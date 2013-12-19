#!/usr/local/bin/perl
while(<>) {
	/href="([^"]*)"/;
	$href = $1;
	if ($href ne "") {
		$href =~ s#\\#/#g;
		s/href="[^"]*"/href="$href"/;
	}
	print $_;
}
