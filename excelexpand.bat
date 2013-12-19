@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!C:\perl\bin\perl -w
#line 15

if ($#ARGV == -1) {
	exit(1);
} elsif (!(-f $ARGV[0])) {
	exit(1);
}

unless ($ARGV[0] =~ /\.csv$/) {
	exit(1);
}

$out = $ARGV[0];
$out =~ s/\.csv$//;

$out =~ /^(.*)\\([^\\]+)$/;
$path = $1;
$out = $2;
open(FILE, $ARGV[0]) || die;
open(OUT, ">>$path\\out.txt") || die;

undef(@buffer);
$line = 0;
while(<FILE>) {
	if ($line == 0 || $line == 1) {
		$line++;
		next;
	}
	chop;
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	if ($line == 2) {
		$month1 = $line[4];
		$month2 = $line[5];
		$month3 = $line[6];
		$month4 = $line[7];
		$month5 = $line[8];
		$month6 = $line[9];
	} elsif ($line[1] eq "") {
		$bunrui = $line[0];
		foreach (@buffer) {
			print OUT "$out $bunrui $_\n";
		}
		undef(@buffer);
	} else {
		push (@buffer, "Œv‰æ " . $line[0] . " " . $line[1] . " " . $line[2]);
		push (@buffer, "ƒYƒŒ " . $line[0] . " " . $line[1] . " " . $line[3]);
		push (@buffer, $month1 . " " . $line[0] . " " . $line[1] . " " . $line[4]);
		push (@buffer, $month2 . " " . $line[0] . " " . $line[1] . " " . $line[5]);
		push (@buffer, $month3 . " " . $line[0] . " " . $line[1] . " " . $line[6]);
		push (@buffer, $month4 . " " . $line[0] . " " . $line[1] . " " . $line[7]);
		push (@buffer, $month5 . " " . $line[0] . " " . $line[1] . " " . $line[8]);
		push (@buffer, $month6 . " " . $line[0] . " " . $line[1] . " " . $line[9]);
	}
	$line++;
}

__END__
:endofperl
