#!c:\perl\bin\perl.exe

die if ($#ARGV == -1);
directory($ARGV[0]);

sub directory
{
	local($path) = @_;
	local(@file);
	local($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst);

	$dir = opendir(DIR,$path);
	@file = sort readdir(DIR);
	closedir(DIR);

	foreach (@file) {
		next if ($_ eq "." || $_ eq "..");
		if (-d "$path$_/") {
			directory("$path$_/");
		} else {
			($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime((stat "$path$_")[9]);
			$year += 1900;
			$mon += 1;
			printf("\"%4d/%02d/%02d %02d:%02d:%02d\",\"%s%s\"\n", $year,$mon,$mday,$hour,$min,$sec,$path,$_);
		}
	}
}
