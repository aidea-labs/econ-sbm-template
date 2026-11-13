% 格式参考：https://ciejournal.ajcass.com/UploadFile/SiteResource/zqnj5npp.pdf
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{中国工业经济}[2026/11/13 中国工业经济投稿模板]

% 默认生成匿名正文，封面通过选项单独生成。
\newif\ifjournal@cover
\DeclareOption{cover}{\journal@covertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}
\ProcessOptions\relax
\PassOptionsToPackage{sorting=cie,sortlocale=zh__pinyin,maxbibnames=99,maxcitenames=2,mincitenames=1,uniquename=false,uniquelist=false,giveninits=true}{biblatex}
\LoadClass[zihao=5,bibstyle=gb7714-2015,citestyle=gb7714-2015ay]{base}
% 五号字每行 42 字；以基础模板的 1.5 倍行距安排每页 39 行。
\RequirePackage[textwidth=452.5pt,textheight=739.86pt,centering]{geometry}
\RequirePackage{placeins}
\RequirePackage{perpage}
\RequirePackage{caption}

% 文献按语言、作者和年份排序，中文在前。
\DeclareSortingTemplate{cie}{
  \sort{\field{presort}}
  \sort{\field{lansortorder}}
  \sort{\field{sortname}\field{author}\field{editor}\field{sorttitle}\field{title}}
  \sort{\field{sortyear}\field{year}}
  \sort{\field{sorttitle}\field{title}}
}
\DeclareSourcemap{\maps[datatype=bibtex]{
  \map[overwrite]{\step[fieldset=lansortorder, fieldvalue={4}]}
  \map[overwrite]{\step[fieldsource=author, match=\regexp{\p{Han}}, final]\step[fieldset=lansortorder, fieldvalue={1}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:en(?:[-_][a-z]+)?)\z}, replace={english}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:zh(?:[-_][a-z]+)?)\z}, replace={chinese}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:english)\z}, final]\step[fieldset=lansortorder, fieldvalue={4}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:chinese)\z}, final]\step[fieldset=lansortorder, fieldvalue={1}]}
}}
\DefineBibliographyStrings{english}{andincite = {\addspace and\addspace}}
% 英文作者首位姓在前，其余名在前；中文作者保持原有写法。
\DeclareNameFormat{cie-bib}{%
  \ifboolexpr{test {\iffieldequalstr{userd}{chinese}}}
    {\usebibmacro{name:family-given}{\namepartfamily}{\namepartgiven}{\namepartprefix}{\namepartsuffix}}
    {\ifnumequal{\value{listcount}}{1}
      {\usebibmacro{name:family-given}{\namepartfamily}{\namepartgiveni}{\namepartprefix}{\namepartsuffix}}
      {\usebibmacro{name:given-family}{\namepartfamily}{\namepartgiveni}{\namepartprefix}{\namepartsuffix}}}%
  \usebibmacro{name:andothers}}
\DeclareDelimFormat[bib]{finalnamedelim}{%
  \iffieldequalstr{userd}{chinese}{\addcomma\space}{\addcomma\space and\space}}
\AtBeginBibliography{\DeclareNameAlias{default}{cie-bib}\DeclareNameAlias{sortname}{cie-bib}}

% 常见文献类型按期刊示例输出，题名大小写由文献库提供。
\DeclareFieldFormat[article,book,incollection,inproceedings,report,online]{title}{#1}
\DeclareFieldFormat[incollection,inproceedings]{booktitle}{#1}
\DeclareFieldFormat[article]{journaltitle}{#1}
\DeclareFieldFormat[article]{pages}{#1}
\DeclareNameFormat{cie-translator}{%
  \namepartfamily\namepartgiven\namepartprefix\namepartsuffix}
\newbibmacro*{cie:author}{%
  \ifnameundef{author}{\printnames{editor}}{\printnames{author}}}
\newbibmacro*{cie:publication}{%
  \printlist{location}%
  \iflistundef{publisher}{}{%
    \setunit{\iffieldequalstr{userd}{chinese}{：}{\addcolon\space}}\printlist{publisher}}%
  \setunit{\iffieldequalstr{userd}{chinese}{，}{\addcomma\space}}\printfield{year}}
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}\printtext{[J]}\setunit{\adddot\space}%
  \printfield{journaltitle}\setunit{\addcomma\space}\printfield{year}%
  \iffieldundef{volume}{}{\setunit{\addcomma\space}\printfield{volume}}%
  \iffieldundef{number}{}{%
    \iffieldundef{volume}{\setunit{\addcomma\space}}{}%
    \printtext{\mkbibparens{\printfield{number}}}}%
  \setunit{\addcolon}\printfield{pages}%
  \usebibmacro{finentry}}
\DeclareBibliographyDriver{book}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \iflistundef{origlocation}{}{\printtext{[\printlist{origlocation}]}}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}\printtext{[M]}\setunit{\adddot\space}%
  \ifnameundef{translator}{}{\printnames[cie-translator]{translator}\printtext{译}\setunit{\adddot\space}}%
  \usebibmacro{cie:publication}\usebibmacro{finentry}}
\newbibmacro*{cie:incollection}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}\printtext{[A]}\setunit{\adddot\space}%
  \printnames{editor}\setunit{\adddot\space}%
  \printfield{booktitle}\printtext{[C]}\setunit{\adddot\space}%
  \usebibmacro{cie:publication}\usebibmacro{finentry}}
\DeclareBibliographyDriver{incollection}{\usebibmacro{cie:incollection}}
\DeclareBibliographyDriver{inproceedings}{\usebibmacro{cie:incollection}}
\DeclareBibliographyDriver{report}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}\printtext{[R]}\setunit{\adddot\space}%
  \printlist{institution}\setunit{\addcomma\space}\printfield{year}%
  \usebibmacro{finentry}}
\DeclareBibliographyDriver{online}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}\printtext{[EB/OL]}\setunit{\adddot\space}%
  \printfield{url}\setunit{\addcomma\space}%
  \iffieldundef{urlyear}{\printfield{year}}{\printfield{urlyear}}%
  \usebibmacro{finentry}}
\AddToHook{cmd/printbibliography/before}{\FloatBarrier}

% 作者信息放在单独的封面，正文继续使用现有摘要与关键词命令。
\newcommand{\journal@titleen}{}
\newcommand{\journal@authors}{}
\newcommand{\journal@address}{}
\newcommand{\journal@acknowledgments}{}
\newcommand{\journal@clc}{}
\newcommand{\journal@articleid}{}
\newcommand{\journal@receiveddate}{}
\newcommand{\journal@funding}{}
\newcommand{\journal@authorbio}{}
\NewDocumentCommand{\titleen}{m}{\gdef\journal@titleen{#1}}
\NewDocumentCommand{\clc}{m}{\gdef\journal@clc{#1}}
\NewDocumentCommand{\articleid}{m}{\gdef\journal@articleid{#1}}
\NewDocumentCommand{\receiveddate}{m}{\gdef\journal@receiveddate{#1}}
\NewDocumentCommand{\funding}{+m}{\gdef\journal@funding{#1}}
\NewDocumentCommand{\authorbio}{+m}{\gdef\journal@authorbio{#1}}
\NewDocumentCommand{\correspondenceaddress}{m}{\gdef\journal@address{#1}}
\NewDocumentCommand{\acknowledgments}{+m}{\gdef\journal@acknowledgments{#1}}
\NewDocumentCommand{\coverauthor}{m m m m m m}{%
  \g@addto@macro\journal@authors{%
    \noindent\textbf{#1（#2）}\par
    \noindent #3（#4）\par
    \noindent 电话：#5\quad 邮箱：\nolinkurl{#6}\par\medskip}}
\newcommand{\journal@title}{\begin{center}{\econ@titleformat\@title\par}\end{center}}
\ifjournal@cover
  \renewcommand{\maketitle}{%
    \thispagestyle{empty}\journal@title
    \ifdefempty{\journal@authors}{\noindent\begin{tabular}[t]{@{}l@{}}\@author\end{tabular}\par\@thanks}{\journal@authors}%
    \ifdefempty{\journal@address}{}{\noindent\textbf{通信地址：}\journal@address\par}%
    \ifdefempty{\journal@receiveddate}{}{\noindent\textbf{［收稿日期］}\journal@receiveddate\par}%
    \ifdefempty{\journal@funding}{}{\noindent\textbf{［基金项目］}\journal@funding\par}%
    \ifdefempty{\journal@authorbio}{}{\noindent\textbf{［作者简介］}\journal@authorbio\par}%
    \ifdefempty{\journal@acknowledgments}{}{\noindent\textbf{致谢：}\journal@acknowledgments\par}%
    \end{document}}
\else
  \renewcommand{\maketitle}{\hypersetup{pdfauthor={}}\thispagestyle{plain}\journal@title}
  \pagestyle{plain}
\fi
\RenewDocumentEnvironment{abstract}{}{\par\noindent\textbf{［摘要］}\ignorespaces}{\par\medskip}
\NewDocumentCommand{\keywords}{m}{%
  \par\noindent\textbf{［关键词］}#1\par
  \ifdefempty{\journal@clc}{}{\noindent\textbf{［中图分类号］}\journal@clc\par}
  \noindent\textbf{［文献标识码］}A\par
  \ifdefempty{\journal@articleid}{}{\noindent\textbf{［文章编号］}\journal@articleid\par}
  \medskip}

% 英文摘要放在参考文献之后，未填写的字段不显示。
\newcommand{\journal@english}{%
  \ifdefempty{\journal@titleen}{}{\medskip\begin{center}{\large\bfseries\journal@titleen\par}\end{center}}%
  \ifdefempty{\econ@abstracten}{}{\noindent\textbf{Abstract: }\econ@abstracten\par}%
  \ifdefempty{\econ@keywordsen}{}{\noindent\textbf{Key Words: }\econ@keywordsen\par}%
  \ifdefempty{\econ@jel}{}{\noindent\textbf{JEL Classification: }\econ@jel\par}}
\newif\ifjournal@englishprinted
\newcommand{\journal@printenglish}{%
  \ifjournal@englishprinted\else
    \global\journal@englishprintedtrue\journal@english
  \fi}
\AddToHook{cmd/appendix/before}{\journal@printenglish}
\AtEndDocument{\journal@printenglish}

% 图表资料来源由作者填写，不能自动推断。
\NewDocumentCommand{\figuresource}{m}{\par\noindent{\songti\zihao{6}资料来源：#1\par}}
\NewDocumentCommand{\tablesource}{m}{\par\noindent{\songti\zihao{6}资料来源：#1\par}}

% 一级标题居中，二级标题单独成行，三级标题与正文接排。
\ctexset{
  section = {name = {,、}, number = \chinese{section}, aftername = {},
    format = \normalfont\centering\fangsong\zihao{4}},
  subsection = {name = {,.}, number = \arabic{subsection}, aftername = {\hspace{0.5em}},
    format = \normalfont\heiti\bfseries\zihao{5}, indent = 2em},
  subsubsection = {name = {（,）}, number = \arabic{subsubsection}, aftername = {},
    format = \normalfont\songti\zihao{5}, indent = 2em, runin = true, aftertitle = {}, afterskip = 0.5em}
}
\MakePerPage{footnote}
\renewcommand{\thefootnote}{\textcircled{\scriptsize\arabic{footnote}}}
\DeclareCaptionFont{ciecaption}{\heiti\bfseries\zihao{5}}
\captionsetup{font=ciecaption}
\endinput
