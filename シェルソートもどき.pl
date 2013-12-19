# �V�F���\�[�g���ǂ�

# �\�[�g�ςݔz��@values�ɒl$value��}������ꍇ
splice(@values, &find_insert($value, @values), 0, $value);

# �\�[�g�ςݔz��@values�ɒl@new�̗v�f���ׂĂ�}������ꍇ
foreach (@new) {
	splice(@values, &find_insert($_, @values), 0, $_);
}

# �z��@keys���\�[�g����@sorted�Ɋi�[����ꍇ
@sorted = ();
foreach (@keys) {
	splice(@sorted, &find_insert($_, @sorted), 0, $_);
}
# �������A���R�Ȃ���W����sort�̕��������i���������Ȃ��
# �����͂������j�B�܂��A�����܂ł��ǂ��Ȃ̂Ŗ{���̃V�F���\�[
# �g���x���B
# ���̃��[�`���̉��l���ł�̂́A��Ƀ\�[�g����Ă���f�[�^
# ��ɂ����āA�f�[�^�������čs���ꍇ�Ɍ�����B���Ƃ��΁A
# �Z���^�ɐV�������R�[�h��}������悤�ȏꍇ�B
# �ő����ւ�N�C�b�N�\�[�g���g�p���Ă���Perl��sort�֐������A
# ����z��S�̂��\�[�g���Ă��Ă͎��Ԃ������肷����B

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
