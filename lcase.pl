@files = <*.*>;
foreach $file (@files) {
	$lcase = $file;
	$lcase =~ tr/A-Z/a-z/;
	rename($file, $lcase);
}