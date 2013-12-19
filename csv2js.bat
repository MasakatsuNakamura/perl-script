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
#!C:\perl\bin\perl
#line 15
if ($#ARGV == -1) {
	exit(1);
} elsif (!(-f $ARGV[0])) {
	exit(1);
}
$out = $ARGV[0]. ".txt";
open(FILE, $ARGV[0]) || die;
open(OUT, ">$out") || die;
$first = 1;
while(<FILE>) {
	chop;
	push(@lines, $_);
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	foreach $c (@line){
		if ($c eq "~") {
			print OUT "false,";
		} elsif ($c eq "›") {
			print OUT "true,";
		} elsif ($c =~ /^\-?[0-9\,]+$/) {
			if ($c >= -10 && $c <= 10) {
				print OUT "$c,";
			} else {
				print OUT "\"$c\",";
			}
		} else {
			print OUT "\"$c\",";
		}
		$first = 0;
	}
	print OUT "\n";
}

__END__
:endofperl
