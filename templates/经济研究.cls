% 格式参考：https://erj.ajcass.com/
% 引文体例参考：https://se.ucass.edu.cn/system/_content/download.jsp?owner=1549353323&urltype=news.DownloadAttachUrl&wbfileid=13266132
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{经济研究}[2026/11/13 中文经济学期刊投稿模板]

% 封面单独输出，其他选项交给基础模板处理。
\newif\ifjournal@cover
\DeclareOption{cover}{\journal@covertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}
\ProcessOptions\relax
\PassOptionsToPackage{gblanorder=chineseahead,sortlocale=zh__pinyin,maxbibnames=99,maxcitenames=2,mincitenames=1,uniquename=false,uniquelist=false,giveninits=true}{biblatex}
\LoadClass[zihao=5,bibstyle=chinese-erj,citestyle=chinese-erj]{base}
% 兼容尚未加载超链接支持的基础模板。
\@ifpackageloaded{hyperref}{}{\RequirePackage[hidelinks]{hyperref}}

% 页面尺寸沿用项目设定，期刊未在体例文件中指定页边距。
\RequirePackage[margin=2.5cm]{geometry}
\RequirePackage{placeins}

% 将常见语言标记统一为引文样式识别的名称。
\DeclareSourcemap{\maps[datatype=bibtex]{
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:en(?:[-_][a-z]+)?)\z}, replace={english}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:zh(?:[-_][a-z]+)?)\z}, replace={chinese}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:english)\z}, final]\step[fieldset=lansortorder, fieldvalue={4}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:chinese)\z}, final]\step[fieldset=lansortorder, fieldvalue={1}]}
}}

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

% 中文文献沿用期刊样式；英文文献按作者、年份、文献名和出处排列。
\csletcs{blx@bbx@erj@article}{blx@bbx@article}
\csletcs{blx@bbx@erj@book}{blx@bbx@book}
\csletcs{blx@bbx@erj@incollection}{blx@bbx@incollection}
\csletcs{blx@bbx@erj@report}{blx@bbx@report}
\DeclareFieldFormat{erj:article}{\mkbibquote{#1}}
\DeclareFieldFormat{erj:journal}{\mkbibemph{#1}}
\DeclareFieldFormat{erj:book}{#1}
\DeclareNameFormat{erj:english}{%
  \ifnumgreater{\value{listcount}}{1}{\addcomma\space}{}%
  \namepartfamily\addcomma\space\namepartgiveni\usebibmacro{name:andothers}}
\DeclareNameFormat{erj:translator}{\namepartfamily\namepartgiven\namepartprefix\namepartsuffix}
\newbibmacro*{erj:year}{\printfield{year}\printfield{extradate}}
\DeclareBibliographyDriver{article}{%
  \iffieldequalstr{userd}{chinese}{\csuse{blx@bbx@erj@article}}{%
    \usebibmacro{bibindex}\usebibmacro{begentry}\printnames[erj:english]{author}%
    \setunit{\addcomma\space}\usebibmacro{erj:year}%
    \setunit{\addcomma\space}\printfield[erj:article]{title}%
    \setunit{\addcomma\space}\printfield[erj:journal]{journaltitle}%
    \iffieldundef{volume}{}{\setunit{\addcomma\space}\printtext{Vol.\addspace}\printfield{volume}}%
    \iffieldundef{number}{}{\setunit{\addcomma\space}\printtext{No.\addspace}\printfield[noformat]{number}}%
    \iffieldundef{pages}{}{\setunit{\addcomma\space}\printtext{pp.\addspace}\printfield[noformat]{pages}}%
    \usebibmacro{finentry}}}
\DeclareBibliographyDriver{book}{%
  \iffieldequalstr{userd}{chinese}{%
    \usebibmacro{bibindex}\usebibmacro{begentry}%
    \ifnameundef{author}{\printnames{editor}}{\printnames{author}}%
    \setunit{，}\usebibmacro{erj:year}\setunit{：}%
    \printtext{《\printfield[noformat]{title}》}%
    \ifnameundef{translator}{}{\setunit{，}\printnames[erj:translator]{translator}\printtext{译}}%
    \setunit{，}\printlist{publisher}\usebibmacro{finentry}%
  }{%
    \usebibmacro{bibindex}\usebibmacro{begentry}%
    \ifnameundef{author}{\printnames[erj:english]{editor}}{\printnames[erj:english]{author}}%
    \setunit{\addcomma\space}\usebibmacro{erj:year}%
    \setunit{\addcomma\space}\printfield[erj:book]{title}%
    \setunit{\addcomma\space}\printlist{publisher}\usebibmacro{finentry}}}
\DeclareBibliographyDriver{incollection}{%
  \iffieldequalstr{userd}{chinese}{\csuse{blx@bbx@erj@incollection}}{%
    \usebibmacro{bibindex}\usebibmacro{begentry}\printnames[erj:english]{author}%
    \setunit{\addcomma\space}\usebibmacro{erj:year}%
    \setunit{\addcomma\space}\printfield[erj:article]{title}%
    \setunit{\addcomma\space}\printtext{in\space}\printnames[erj:english]{editor}%
    \setunit{\addcomma\space}\printfield[erj:book]{booktitle}%
    \setunit{\addcomma\space}\printlist{publisher}%
    \iffieldundef{pages}{}{\setunit{\addcomma\space}\printtext{pp.\addspace}\printfield[noformat]{pages}}%
    \usebibmacro{finentry}}}
\csletcs{blx@bbx@inproceedings}{blx@bbx@incollection}
% 工作论文未给出独立示例，保留作者、年份、题名和机构信息。
\DeclareBibliographyDriver{report}{%
  \iffieldequalstr{userd}{chinese}{\csuse{blx@bbx@erj@report}}{%
    \usebibmacro{bibindex}\usebibmacro{begentry}\printnames[erj:english]{author}%
    \setunit{\addcomma\space}\usebibmacro{erj:year}%
    \setunit{\addcomma\space}\printfield[erj:article]{title}%
    \setunit{\addcomma\space}\printfield[noformat]{series}%
    \setunit{\addcomma\space}\printlist{location}%
    \setunit{\addcolon\space}\iflistequalcs{publisher}{abx@list@institution}{}{\printlist{publisher}}%
    \setunit{\addcomma\space}\printlist{institution}%
    \iffieldundef{number}{}{\setunit{\addcomma\space}\printfield[noformat]{number}}%
    \usebibmacro{finentry}}}


% 支持原稿中的中英文首页信息与独立封面信息。
\newcommand{\journal@titleen}{}
\newcommand{\journal@authors}{}
\newcommand{\journal@address}{}
\newcommand{\journal@acknowledgments}{}
\newcommand{\journal@summaryzh}{}
\NewDocumentCommand{\summaryzh}{+m}{\gdef\journal@summaryzh{#1}}
\NewDocumentCommand{\titleen}{m}{\gdef\journal@titleen{#1}}
\NewDocumentCommand{\correspondenceaddress}{m}{\gdef\journal@address{#1}}
\NewDocumentCommand{\acknowledgments}{+m}{\gdef\journal@acknowledgments{#1}}
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
  \par\noindent\textbf{内容提要：}\ignorespaces
}{\par\medskip}
\NewDocumentCommand{\keywords}{m}{%
  \par\noindent\textbf{关键词：}#1\par
  \ifdefempty{\journal@titleen}{}{%
    \medskip\begin{center}{\large\bfseries\journal@titleen\par}\end{center}}%
  \ifdefempty{\econ@abstracten}{}{%
    \noindent\textbf{Summary: }\econ@abstracten\par}%
  \ifdefempty{\econ@keywordsen}{}{%
    \noindent\textbf{Keywords: }\econ@keywordsen\par}%
  \ifdefempty{\econ@jel}{}{%
    \noindent\textbf{JEL 分类号：}\econ@jel\par}%
  \ifdefempty{\journal@summaryzh}{}{%
    \medskip\noindent\textbf{英文梗概中文对照：}\journal@summaryzh\par}%
  \medskip}

% 一级、二级标题使用中文序号。
\ctexset{
  section = {name = {,、}, number = \chinese{section}, aftername = {},
    format = \normalfont\centering\heiti\zihao{4}},
  subsection = {name = {（,）}, number = \chinese{subsection}, aftername = {},
    format = \normalfont\songti\zihao{5}},
  subsubsection = {format = \normalfont\songti\zihao{5}},
  paragraph = {format = \normalfont\songti\zihao{5}},
  subparagraph = {format = \normalfont\songti\zihao{5}}
}
\labelformat{subsection}{\thesubsection}

\endinput
