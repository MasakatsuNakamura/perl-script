#!C:\perl\bin\perl.exe
# 引数の解析・パス名の作成
unless ($ARGV[0] =~ /^.*\.[^\\\.]*$/) {
	print "Please specify *.dbx file\n";
	exit(1);
} elsif ($ARGV[0] =~ /\\/) {
	($path, $filename, $ext) = ($ARGV[0] =~ /^(.*)\\([^\\]*)\.([^\\\.]*)$/);
} else {
	$path = ".";
	($filename, $ext) = ($ARGV[0] =~ /^(.*)\.([^\.]*)$/);
}
$ext =~ tr/A-Z/a-z/;
unless ($ext == "dbx") {
	print "Please specify *.dbx file\n";
	exit(1);
}
$outfile = $path . $filename . ".out";

# 変数定義
$meshead = "^(Return-Path:|Received:|From) ";

# タイトル表示
print "Outlook Express 5 message recovery utility ver.0.1\n\n";

# メッセージのスキャン
print "Scanning .dbx file ...\n";
open(FILE, $ARGV[0]) || die;
binmode(FILE);
@keys = ();
$pos = 0;
seek(FILE, 0, 2); $fsize = tell(FILE); seek(FILE, 0, 0);
while (read(FILE, $buf, 4)) {
	$pos += 4;
	$adrs = unpack("V", $buf);
	if ($adrs == $pos - 4) {
		read(FILE, $buf, 12); $pos += 12;
		($leng, $aleng, $next) = unpack("VVV", $buf);
		if ($leng == 0x200 && $aleng <= $leng) {
			read(FILE, $buf, $aleng); $pos += $aleng;
			$delta = ($aleng % 4 == 0) ? 0 : 4 - ($aleng % 4);
			seek(FILE, $delta, 1); $pos += $delta;
			if ($buf =~ /$meshead/o) {
				$adrs{$adrs - 2} = $adrs;
				push (@keys, $adrs - 2);
				$head{$adrs} = 1;
			}
			if ($next != 0) {
				$adrs{$adrs} = $next;
				push (@keys, $adrs);
			} else {
				$last{$adrs} = 1;
			}
			$size{$adrs} = $aleng;
			printf "Progress: %010d/%010d (%03.2f\%)\r", $pos, $fsize, $pos * 100 / $fsize;
		}
	}
}
printf "Progress: %010d/%010d (%03.2f\%)\r", $pos, $fsize, $pos * 100 / $fsize;
print "\nPhase 1 done !!\n";

# メッセージの書き出し
print "\nCreating message files ...\n";
system("mkdir $path\\$filename");
open (OUT, ">$path\\$filename\\mes00000.eml") || die;
binmode(OUT);
$keys = $#keys;
$number = 1;
for ($i = 0; $i <= $keys; $i++) {
	$adrs = $adrs{$keys[$i]};
	seek (FILE, $adrs + 16, 0);
	read (FILE, $buf, $size{$adrs});
	if (defined($head{$adrs}) || $i > 0 && defined($last{$keys[$i-1]})) {
		close (OUT);
		if (defined($head{$adrs})) {
			$fname = sprintf("mes%05d.eml", $number);
		} else {
			$fname = sprintf("mes%05d.brk", $number);
		}
		open (OUT, ">$path\\$filename\\$fname") || die;
		binmode(OUT);
		$number++;
	}
	print OUT $buf;
	printf "Progress: %08d/%08d (%03.2f\%)\r", $i, $keys, $i * 100 / $keys;
}
close (OUT);
close (FILE);
print "\nPhase 2 done !!\n";
print "\nAll jobs are finished !!\n";
