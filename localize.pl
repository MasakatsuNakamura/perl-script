#!C:\perl\bin\perl.exe
@files = <*.html>;
$words = 1;
open (OUT, ">words.txt") || die;
foreach $file (@files) {
	open (FILE, "$file") || die;
	$data = join("", <FILE>);
	close (FILE);
	$data =~ s/((value|alt)\s*=\s*")([^"]*)(")/$1>$3<$4/g;
	$data =~ s/<[^>]*>/\n/g;
	$data =~ s/(\s|　|\x81\x40)*[\n]+(\s|　|\x81\x40)*/\n/g;
	@data = split(/\n/, $data);
	foreach (@data) {
		s/^(\s|　|\x81\x40)+//;
		s/(\s|　|\x81\x40)+$//;
		if ($_ ne "") {
			print OUT "$words	$file	$_\n";
			$words++;
		}
	}
}
close (OUT);

$current = "";
$last = "<><><><><><><>";
open (FILE, "words.txt") || die;
while ($data = <FILE>) {
	chop ($data);
	($number, $file, $word) = split(/\t/, $data);
	$word =~ s/([\^\$\\\{\}\,\*\+\?\(\)\.\[\]\|])/\\$1/g;
	if ($current ne $file) {
		if ($current ne "") {
			if ($last ne "<><><><><><><>") {
				print OUT $last;
				$last = "<><><><><><><>";
			}
			while (<IN>) {
				print OUT $_;
			}
			close (IN);
			close (OUT);
		}
		open (IN, "$file") || die;
		open (OUT, ">$file.org") || die;
		$current = $file;
	}
	while () {
		if ($last eq "<><><><><><><>") {
			$_ = <IN>;
			last if (eof(IN));
		} else {
			$_ = $last;
			$last = "<><><><><><><>";
		}
		if (/(<[^>]*>)*.*$word.*(<[^>]*>)*/) {
			s/((<[^>]*>)*.*)$word(.*(<[^>]*>)*)/$1\$\$LOCALWORD($number)\$\$$3/;
			$last = $_;
			last;
		} elsif (/(alt|value)\s*=\s*".*$word.*"/) {
			s/((alt|value)\s*=\s*".*)$word(.*")/$1\$\$LOCALWORD($number)\$\$$3/;
			$last = $_;
			last;
		}
		print OUT $_;
		$last = "<><><><><><><>";
	}
}
