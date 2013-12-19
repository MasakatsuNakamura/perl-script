while(<>){
	chop;
	@line = split(/\t/);
	@chars1 = split(//, $line[0]);
	@chars2 = split(//, $line[1]);
	print "\$table{\"";
	foreach $i (@chars1) {
		printf("\\x%02x", unpack("C", $i));
	}
	print "\"} = \"";
	foreach $i (@chars2) {
		printf("\\x%02x", unpack("C", $i));
	}
	print "\";\n";
}
