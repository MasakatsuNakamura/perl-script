#!C:\Perl\bin\perl.exe
use Win32::ODBC;
use MIME::Base64;

while(<>) {
	$_ = encode_base64($_);
	s/==$//;
	print "=?ISO-2022-JP?B?$_?=\n";
}

