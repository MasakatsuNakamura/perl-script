#!c:\per\bin\perl.exe
use Win32::Internet;

$INET = new Win32::Internet();
$INET->FTP($FTP, "ppd.sf.nara.sharp.co.jp", "nakamura", "ls-aglF") || die;
$FTP->Binary();
&getdir('/home/nakamura/src', 'C:\\Windows\\ÃŞ½¸Ä¯Ìß\\test');
$FTP->Close();

sub getdir
{
	local($currentdir, $targetdir) = @_;
	local(@files);
	local($file);

	$FTP->Cd($currentdir);
	system("mkdir $targetdir") unless (-d $targetdir);
	chdir($targetdir);

	@files = $FTP->List("*.*", 3);
	foreach $file (@files) {
		next if ($file->{'name'} eq "." || $file->{'name'} eq "..");
		if ($file->{'attr'} == 16) {
			print "Chdir to " . $currentdir ."/" . $file->{'name'} . " ... \n";
			&getdir($currentdir . "/" . $file->{'name'}, $targetdir . "\\" . $file->{'name'});
		} else {
			print "Fetching " . $currentdir ."/" . $file->{'name'} . "... \n";
			print "      to " . $targetdir ."\\" . $file->{'name'} . "... \n";
			$response = $FTP->Get($currentdir ."/" . $file->{'name'}, $file->{'name'});
			unless ($response) {
				print "Error !!\n";
			}
			print $file->{'date'} , "\n";
		}
	}
}
