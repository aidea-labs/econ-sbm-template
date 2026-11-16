use Config;

# 先搜索本地模板目录，再沿用 TeX 的标准搜索路径。
my $separator = $Config{path_sep};
my $existing_inputs = $ENV{'TEXINPUTS'} // '';
$ENV{'TEXINPUTS'} = './templates' . $separator . $existing_inputs;
$ENV{'TEXINPUTS'} .= $separator
    if length($existing_inputs) && substr($existing_inputs, -1) ne $separator;

$pdf_mode = 5;
@default_files = ('main.tex');
