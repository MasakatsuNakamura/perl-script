# SJIS�e�L�X�g��1�����P�ʂɕ���
$ascii = '[\x00-\x80\xa0-\xdf\xfd-\xff]';
$twoBytes = '[\x81-\x9f\xe0-\xfc][\x40-\x7e\x80-\xfc]';

$i = 1;
while(<>) {
	@line = m/($ascii|$twoBytes)/g;
	print "$i�s�ځF\n";
	foreach $c (@line) {
		print "$c\n";
	}
	$i++;
}
