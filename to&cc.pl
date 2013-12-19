#!/usr/local/bin/perl
# UNIX形式のメールボックスファイルを受け取り、送信先の一覧を作成する
# 標準入力から受け取り、標準出力に書き出し。
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
