#!C:\Perl\bin\perl.exe
$i = 0;
open(FILE, "I:\\óMƒgƒŒƒC.dbx") || die;
#open(FILE, "c:\\Windows\\ÃŞ½¸Ä¯Ìß\\NIC.dbx") || die;
binmode(FILE);
while (read(FILE, $buf, 1024)) {
	for ($j = 0; $j < length($buf); $j++) {
		$c = substr($buf, $j, 1);
		printf("%08X:", $i) if ($i % 16 == 0);
		printf("%02X ",unpack("C", $c));
		print "\n" if ($i % 16 == 15);
		$i++;
	}
	last if ($i >= 131072);
}
close(FILE);
