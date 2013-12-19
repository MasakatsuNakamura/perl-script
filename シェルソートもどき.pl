# シェルソートもどき

# ソート済み配列@valuesに値$valueを挿入する場合
splice(@values, &find_insert($value, @values), 0, $value);

# ソート済み配列@valuesに値@newの要素すべてを挿入する場合
foreach (@new) {
	splice(@values, &find_insert($_, @values), 0, $_);
}

# 配列@keysをソートして@sortedに格納する場合
@sorted = ();
foreach (@keys) {
	splice(@sorted, &find_insert($_, @sorted), 0, $_);
}
# ただし、当然ながら標準のsortの方が早い（これもそれなりに
# 早いはずだが）。また、あくまでもどきなので本当のシェルソー
# トより遅い。
# このルーチンの価値がでるのは、常にソートされているデータ
# 列において、データが増えて行く場合に限られる。たとえば、
# 住所録に新しいレコードを挿入するような場合。
# 最速を誇るクイックソートを使用しているPerlのsort関数だが、
# 毎回配列全体をソートしていては時間がかかりすぎる。

sub find_insert {
	local ($value, @values) = @_;
	local ($start);
	$values = $#values;
	if ($values == 0) {
		return (0);
	} elsif ($values[0] >= $value) {
		return (0);
	} elsif ($values[$values] <= $value) {
		return ($values);
	} else {
		$start = int($values / 2);
		while (1) {
			last if ($values[$start] <= $value && $values[$start+1] >= $value);
			$start = int($start / 2) if ($values[$start] >= $value);
			$start = int(($start + $values) / 2) if ($values[$start] <= $value);
		}
		return ($start+1);
	}
}
