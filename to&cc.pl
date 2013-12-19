#!/usr/local/bin/perl
# UNIX�`���̃��[���{�b�N�X�t�@�C�����󂯎��A���M��̈ꗗ���쐬����
# �W�����͂���󂯎��A�W���o�͂ɏ����o���B
while (<STDIN>) {
	next unless (/^(To|Cc): /);
	if (/</) {
		@address = /<([^>]*)>/g;
		push (@addresses, @address);
	} else {
		s/^(To|Cc): //;
		@address = split(/[,\s]/, $_)
		push (@addresses, @address);
	}
}

@addresses = sort @addresses;

$old = "";
foreach (@addresses) {
	print "$_\n" if ($_ ne $old);
	$old = $_;
}
