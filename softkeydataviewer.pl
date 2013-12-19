#!C:\Perl\bin\perl.exe
use Win32::ODBC;
use MIME::Base64;

if ($#ARGV == -1) {
	exit(1);
} elsif (!(-f $ARGV[0])) {
	exit(1);
}
$out = $ARGV[0];
$out =~ s/\.[^\.]*$//;
$out .= ".html";
open(FILE, $ARGV[0]) || die;
open(OUT, ">$out") || die;

$i = 0;
@keys =  ("Status", "MachineSerialNumber", "OptionClass", "ApplicationNumber", "ModelName", "ProductKey", "DealerName", "DealerPersonName", "DealerPersonMailAddr", "ClientName", "ClientPersonName", "ClientPersonMailAddr", "IPAddress", "CountryId", "LanguageId", "RecordId", "UpdateUser", "UpdateDate");

foreach $key (@keys) {
	$tag{$key} = $i;
	$i++;
}

print OUT "<html><body><table border=1><tr>";
foreach $key (@keys) {
	print OUT "<td>$key</td>";
}
print OUT "</tr>\n";

$number = 0;
$issued = 0;

while ($line = <>) {
	print OUT "<tr>";
	{
		my $tmp = $line;
		$tmp =~ s/(?:\x0D\x0A|[\x0D\x0A])?$/,/;
		@values = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
		        ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	foreach $key (@keys) {
		$_ = $values[$tag{$key}];
		s/\t//g;
		if ($key eq "DealerName" || $key eq "DealerPersonName" || $key eq "ClientName" || $key eq "ClientPersonName") {
			$_ .= "==";
			s/=+$/==/;
			$_ = decode_base64($_);
		} elsif ($key eq "Status" && $_ == 1) {
			$issued++;
		}
		print OUT "<td>$_</td>";
	}
	print OUT "</tr>\n";
	$number++;
}
print OUT "</table>\n";
print OUT "Number of Records : $number<br>\n";
print OUT "Number of Issued Product Keys : $issued\n";
print OUT "</body></html>\n";
