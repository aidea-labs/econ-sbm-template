% 格式参考：https://qks.sufe.edu.cn/J/CJYJ/Menu/25
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{财经研究}[2026/11/13 中文经济学期刊投稿模板]

% 封面单独输出，其他选项交给基础模板处理。
\newif\ifjournal@cover
\DeclareOption{cover}{\journal@covertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}
\ProcessOptions\relax
\PassOptionsToPackage{sorting=cie,sortlocale=zh__pinyin,maxbibnames=99,maxcitenames=2,mincitenames=1,uniquename=false,uniquelist=false,giveninits=true}{biblatex}
\LoadClass[zihao=5,bibstyle=gb7714-2015,citestyle=gb7714-2015ay]{base}
% 兼容尚未加载超链接支持的基础模板。
\@ifpackageloaded{hyperref}{}{\RequirePackage[hidelinks]{hyperref}}

\RequirePackage[margin=2.5cm]{geometry}
\RequirePackage{placeins}
\RequirePackage{perpage}
\MakePerPage{footnote}
\renewcommand{\thefootnote}{\textcircled{\scriptsize\arabic{footnote}}}

% 文末按中英文分组，再按作者姓名排序并编号。
\DeclareSortingTemplate{cie}{
  \sort{\field{presort}}
  \sort{\field{lansortorder}}
  \sort{\field{sortname}\field{author}\field{editor}\field{title}}
  \sort{\field{sortyear}\field{year}}
  \sort{\field{sorttitle}\field{title}}
}
\DeclareSourcemap{\maps[datatype=bibtex]{
  \map[overwrite]{\step[fieldset=lansortorder, fieldvalue={4}]}
  \map[overwrite]{\step[fieldsource=author, match=\regexp{\p{Han}}, final]\step[fieldset=lansortorder, fieldvalue={1}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:zh(?:[-_][a-z]+)?|chinese)\z}, final]\step[fieldset=lansortorder, fieldvalue={1}]}
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
% 报纸和电子文献保留文献库提供的完整发表日期。
\newbibmacro*{cie:fulldate}{%
  \printfield{year}%
  \iffieldundef{month}{}{\printtext{-\ifnumless{\thefield{month}}{10}{0}{}\thefield{month}}}%
  \iffieldundef{day}{}{\printtext{-\ifnumless{\thefield{day}}{10}{0}{}\thefield{day}}}}
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}%
  \iffieldequalstr{entrysubtype}{news}{\printtext{[N]}}{\printtext{[J]}}%
  \setunit{\adddot\space}\printfield{journaltitle}\setunit{\addcomma\space}%
  \iffieldequalstr{entrysubtype}{news}{\usebibmacro{cie:fulldate}}{\printfield{year}}%
  \iffieldundef{volume}{}{\setunit{\addcomma\space}\printfield{volume}}%
  \iffieldundef{number}{}{%
    \iffieldundef{volume}{\setunit{\addcomma\space}}{}%
    \printtext{\mkbibparens{\printfield{number}}}}%
  \setunit{\addcolon}\printfield{pages}%
  \usebibmacro{finentry}}
\DeclareBibliographyDriver{book}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \iflistundef{origlocation}{}{\printtext{（\printlist{origlocation}）}}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield{title}%
  \iffieldequalstr{entrysubtype}{standard}
    {\iffieldundef{number}{}{\printtext{：\printfield[noformat]{number}}}\printtext{[S]}}
    {\printtext{[M]}}%
  \setunit{\adddot\space}%
  \ifnameundef{translator}{}{\printnames[cie-translator]{translator}\printtext{译}\setunit{\adddot\space}}%
  \iffieldundef{edition}{}{\printfield[noformat]{edition}\printtext{版}\setunit{\adddot\space}}%
  \usebibmacro{cie:publication}\usebibmacro{finentry}}
\DeclareBibliographyDriver{collection}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \usebibmacro{cie:author}\setunit{\adddot\space}%
  \printfield[noformat]{title}\printtext{[C]}\setunit{\adddot\space}%
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
  \usebibmacro{cie:fulldate}%
  \usebibmacro{finentry}}

% 中文文内页码采用期刊示例的“第 n 页”写法。
\DeclareDelimFormat{nameyeardelim}{%
  \iffieldequalstr{userd}{chinese}{，}{\addcomma\space}}
\DeclareDelimFormat{postnotedelim}{%
  \iffieldequalstr{userd}{chinese}{，}{\addcomma\space}}
\DeclareFieldFormat{postnote}{%
  \ifpages{#1}
    {\iffieldequalstr{userd}{chinese}{第\mkautorange{#1}页}{\mkpageprefix[pagination][\mkautorange]{#1}}}
    {#1}}
\AddToHook{cmd/printbibliography/before}{\FloatBarrier}


% 支持原稿中的中英文首页信息与独立封面信息。
\newcommand{\journal@titleen}{}
\newcommand{\journal@authors}{}
\newcommand{\journal@address}{}
\newcommand{\journal@acknowledgments}{}
\newcommand{\journal@funding}{}
\NewDocumentCommand{\titleen}{m}{\gdef\journal@titleen{#1}}
\NewDocumentCommand{\correspondenceaddress}{m}{\gdef\journal@address{#1}}
\NewDocumentCommand{\acknowledgments}{+m}{\gdef\journal@acknowledgments{#1}}
\NewDocumentCommand{\funding}{+m}{\gdef\journal@funding{#1}}
\NewDocumentCommand{\coverauthor}{m m m m m m}{%
  \g@addto@macro\journal@authors{%
    \noindent\textbf{#1（#2）}\par
    \noindent #3（#4）\par
    \noindent 电话：#5\quad 邮箱：\nolinkurl{#6}\par\medskip}}

\newcommand{\journal@title}{%
  \begin{center}{\econ@titleformat\@title\par}\end{center}}

\newcommand{\journal@coverpage}{%
  \thispagestyle{empty}%
  \journal@title
  \ifdefempty{\journal@authors}{%
    \noindent\begin{tabular}[t]{@{}l@{}}\@author\end{tabular}\par
    \@thanks
  }{\journal@authors}%
  \ifdefempty{\journal@address}{}{%
    \noindent\textbf{通信作者地址：}\journal@address\par}%
  \ifdefempty{\journal@funding}{}{%
    \noindent\textbf{基金项目：}\journal@funding\par}%
  \ifdefempty{\journal@acknowledgments}{}{%
    \noindent\textbf{感谢语：}\journal@acknowledgments\par}}

% 默认正文隐藏标准作者字段，封面使用 cover 选项单独生成。
\ifjournal@cover
  \renewcommand{\maketitle}{\journal@coverpage\end{document}}
\else
  \renewcommand{\maketitle}{%
    \hypersetup{pdfauthor={}}%
    \thispagestyle{plain}%
    \journal@title}
  \pagestyle{plain}
\fi

\RenewDocumentEnvironment{abstract}{}{%
  \par\noindent\textbf{摘要：}\ignorespaces
}{\par\medskip}
\NewDocumentCommand{\keywords}{m}{%
  \par\noindent\textbf{关键词：}#1\par
  \ifdefempty{\journal@titleen}{}{%
    \medskip\begin{center}{\large\bfseries\journal@titleen\par}\end{center}}%
  \ifdefempty{\econ@abstracten}{}{%
    \noindent\textbf{Abstract: }\econ@abstracten\par}%
  \ifdefempty{\econ@keywordsen}{}{%
    \noindent\textbf{Keywords: }\econ@keywordsen\par}%
  \ifdefempty{\econ@jel}{}{%
    \noindent\textbf{JEL 分类号：}\econ@jel\par}%
  \medskip}

% 层级标题采用中文经济学论文常用编号。
\setcounter{secnumdepth}{4}
\ctexset{
  section = {name = {,、}, number = \chinese{section}, aftername = {},
    format = \normalfont\centering\heiti\zihao{4}},
  subsection = {name = {（,）}, number = \chinese{subsection}, aftername = {},
    format = \normalfont\songti\zihao{5}},
  subsubsection = {name = {,.}, number = \arabic{subsubsection}, aftername = {\hspace{0.5em}},
    format = \normalfont\songti\zihao{5}},
  paragraph = {name = {(,)}, number = \arabic{paragraph}, aftername = {},
    format = \normalfont\songti\zihao{5}, runin = true, aftertitle = {}, afterskip = 0.5em},
  subparagraph = {format = \normalfont\songti\zihao{5}}
}
\labelformat{subsection}{\thesubsection}

\endinput
