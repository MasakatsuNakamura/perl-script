$gif = <*.gif>;
$giffile = $gif;
$gif =~ s/^[^i]*in //;
$gif =~ s/_h .*$//;
open(FILE, "counter.txt");
$count = <FILE>;
$dir = <FILE>;
chop($count);
chop($dir);
close(FILE);
if ($gif ne $dir) {
	$count = 1;
	$dir = $gif;
}
rename($giffile, "C:\\WINDOWS\\ÃÞ½¸Ä¯Ìß\\Tiger_gif_image\\$dir\\image$count.gif");
$count++;
open(FILE, ">counter.txt");
print FILE "$count\n";
print FILE "$dir\n";
close(FILE);
