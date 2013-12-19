#!C:\perl\bin\perl.exe
@files = <*.eml>;
foreach $file (@files) {
	$sub = 0;
	$to = 0;
	$from = 0;
	$date = 0;
	open (FILE, $file) || die;
	while (<FILE>) {
		chop;
		last if (/^$/);
		$sub = 1 if (/^Subject: /);
		$to = 1 if (/^To: /);
		$from = 1 if (/^From: /);
		$date = 1 if (/^Date: /);
	}
	close (FILE);
	rename ($file, $file . ".brk") if ($sub == 0 || $to == 0 || $from == 0 || $date == 0);
}
