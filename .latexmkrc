# Documentation https://texdoc.org/serve/latexmk/0
# Overleaf help https://www.overleaf.com/learn/latex/Articles/How_to_use_latexmkrc_with_Overleaf
# See https://www.latexstudio.net/archives/51493.html

# 监控模式启动：
# latexmk -pvc -silent main.tex

# 1. 核心引擎设置 (默认使用高质量 XeLaTeX)
$pdf_mode = 5;
$postscript_mode = $dvi_mode = 0;

# 2. 编译命令优化
# %O 是选项占位符，%S 是源文件。手动加入 -shell-escape 以支持某些高级宏包
$xelatex = "xelatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S";
$pdflatex = "pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S";

# 3. 自动化处理
$bibtex_use = 2;           # 自动运行 bibtex
$silence_logfile_warnings = 1; # 减少日志刷屏

# 4. 解决目录问题
$out_dir = ".";            # 强制输出在当前目录
$aux_dir = "";             # 辅助文件不另存，减少变量解析错误

# 5. 清理规则 (执行 latexmk -c 时清理这些文件)
$clean_ext = "hd nav snm synctex.gz xdv glo gls nlo nls";

# 6. 自定义生成 (术语表与索引)
add_cus_dep('glo', 'gls', 0, 'glo2gls');
sub glo2gls { system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\""); }

add_cus_dep('nlo', 'nls', 0, 'nlo2nls');
sub nlo2nls { system("makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\""); }
