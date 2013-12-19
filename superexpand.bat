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
#!C:\Perl\bin\perl
#line 15
$indent = 0;
$space = 2;

if ($#ARGV == -1) {
	exit(1);
} elsif (!(-f $ARGV[0])) {
	exit(1);
}
$out = $ARGV[0]. ".txt";
open(FILE, $ARGV[0]) || die;
open(OUT, ">$out") || die;
while(<FILE>) {
	chop;
	push(@lines, $_);
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	for($i = 0; $i <= $#line; $i++){
		$length = length($line[$i]);
		if ($max[$i] < $length) {
			$max[$i] = $length;
		}
	}
}

foreach(@lines) {
	{
	  my $tmp = $_;
	  $tmp =~ s/(?:\r\n|[\r\n])?$/,/;
	  @line = map {/^"(.*)"$/ ? scalar($_ = $1, s/""/"/g, $_) : $_}
	                ($tmp =~ /("[^"]*(?:""[^"]*)*"|[^,]*),/g);
	}
	for ($j = 0; $j < $indent; $j++) {
		print OUT " ";
	}
	for($i = 0; $i <= $#line; $i++){
		if ($line[$i] =~ /^[0-9]+$/) {
			$spaces = $max[$i] - length($line[$i]);
			for ($j = 0; $j < $spaces; $j++) {
				print OUT " ";
			}
			print OUT $line[$i];
			for ($j = 0; $j < $space; $j++) {
				print OUT " ";
			}
		} else {
			print OUT $line[$i];
			$spaces = $max[$i] - length($line[$i]) + $space;
			for ($j = 0; $j < $spaces; $j++) {
				print OUT " ";
			}
		}
	}
	print OUT "\n";
}

close FILE;
close OUT;

__END__
:endofperl
