% 格式参考：https://sjjj.magtech.com.cn/attached/file/20231010/20231010085505_466.docx
% 投稿须知：https://sjjj.magtech.com.cn/CN/column/column6.shtml
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{世界经济}[2026/11/13 中文经济学期刊投稿模板]

% 封面单独输出，其他选项交给基础模板处理。
\newif\ifjournal@cover
\DeclareOption{cover}{\journal@covertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}
\ProcessOptions\relax
\PassOptionsToPackage{gblanorder=chineseahead,sortlocale=zh__pinyin,maxbibnames=99,maxcitenames=2,mincitenames=1,uniquename=false,uniquelist=false}{biblatex}
\LoadClass[zihao=5,bibstyle=chinese-erj,citestyle=chinese-erj]{base}
% 兼容尚未加载超链接支持的基础模板。
\@ifpackageloaded{hyperref}{}{\RequirePackage[hidelinks]{hyperref}}

% 初投稿正文使用紧凑版式，编辑部未规定的页边距按 2.5 厘米设置。
\RequirePackage[margin=2.5cm]{geometry}

\RequirePackage{placeins}

% 将文献库中的语言缩写统一为引文样式可识别的名称。
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map[overwrite]{
      \step[fieldsource=language, match=\regexp{\A(?i:en(?:[-_][a-z]+)?)\z}, replace={english}]
    }
    \map[overwrite]{
      \step[fieldsource=language, match=\regexp{\A(?i:zh(?:[-_][a-z]+)?)\z}, replace={chinese}]
    }
    \map[overwrite]{
      \step[fieldsource=language, match=\regexp{\A(?i:english)\z}, final]
      \step[fieldset=lansortorder, fieldvalue={4}]
    }
    \map[overwrite]{
      \step[fieldsource=language, match=\regexp{\A(?i:chinese)\z}, final]
      \step[fieldset=lansortorder, fieldvalue={1}]
    }
  }
}

% 双作者英文引文按期刊示例使用 and。
\DefineBibliographyStrings{english}{andincite = {\addspace and\addspace}}


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
% 接受经济研究所需的中文梗概对照，切换模板时无需删除字段。
\NewDocumentCommand{\summaryzh}{+m}{}
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
    \noindent\textbf{Abstract: }\econ@abstracten\par}%
  \ifdefempty{\econ@keywordsen}{}{%
    \noindent\textbf{Keywords: }\econ@keywordsen\par}%
  \ifdefempty{\econ@jel}{}{%
    \noindent\textbf{JEL 分类号：}\econ@jel\par}%
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

% 以下英文文献条目按《世界经济》格式调整规范编排。
% 中文条目沿用中文经济学期刊引文样式。
\csletcs{blx@bbx@world@article}{blx@bbx@article}
\csletcs{blx@bbx@world@book}{blx@bbx@book}
\csletcs{blx@bbx@world@incollection}{blx@bbx@incollection}
\DeclareFieldFormat{world:title}{\mkbibquote{#1\addperiod}}
\DeclareFieldFormat{world:chapter}{\mkbibquote{#1\addcomma}}
\DeclareFieldFormat{world:journal}{\mkbibemph{#1}}
\DeclareFieldFormat{world:book}{\mkbibemph{#1}}
\DeclareNameFormat{world:translator}{\namepartfamily\namepartgiven\namepartprefix\namepartsuffix}
\DeclareNameFormat{world:editor}{%
  \ifnumgreater{\value{listcount}}{1}
    {\ifnumequal{\value{listcount}}{\value{liststop}}{\addspace and\space}{\addsemicolon\space}}{}%
  \namepartgiven\addspace\namepartfamily}
\DeclareDelimFormat[bib]{multinamedelim}{\iffieldequalstr{userd}{chinese}{、}{}}
\DeclareDelimFormat[bib]{finalnamedelim}{\iffieldequalstr{userd}{chinese}{、}{}}

% 英文文献作者逐一采用姓在前的写法。
\DeclareNameFormat{world:english}{%
  \ifnumgreater{\value{listcount}}{1}
    {\ifnumequal{\value{listcount}}{\value{liststop}}
       {\space and\space}{;\space}}
    {}%
  \nameparts{#1}%
  \namepartfamily\ifdefvoid{\namepartgiven}{}{,\space\namepartgiven}%
  \ifdefvoid{\namepartsuffix}{}{,\space\namepartsuffix}}

\DeclareBibliographyDriver{article}{%
  \iffieldequalstr{userd}{chinese}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames{author}%
     \setunit{}\printtext{（}\printfield{year}\printfield{extradate}\printtext{）：}%
     \printfield[title]{title}%
     \setunit{，}\printfield[journaltitle]{journaltitle}%
     \setunit{}\printfield{number}%
     \usebibmacro{finentry}}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames[world:english]{author}%
     \setunit{\addperiod\space}\printfield[world:title]{title}%
     \setunit{\addspace}\printfield[world:journal]{journaltitle}%
     \setunit{\addcomma\space}\printfield{year}\printfield{extradate}%
     \setunit{\addcomma\space}\printfield{volume}%
     \setunit{}\printfield[parens]{number}%
     \setunit{\addcomma\space}%
     \iffieldundef{pages}{}{\printtext{pp.}\printfield[noformat]{pages}}%
     \usebibmacro{finentry}}}
\DeclareBibliographyDriver{book}{%
  \iffieldequalstr{userd}{chinese}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \ifnameundef{author}{\printnames{editor}}{\printnames{author}}%
     \setunit{}\printtext{（}\printfield{year}\printfield{extradate}\printtext{）：}%
     \printtext{《\printfield[noformat]{title}》}%
     \ifnameundef{translator}{}{\printtext{（}\printnames[world:translator]{translator}\printtext{译）}}%
     \iffieldundef{edition}{}{\setunit{，}\printfield[noformat]{edition}\printtext{版}}%
     \setunit{，}\printlist{location}\setunit{：}\printlist{publisher}%
     \usebibmacro{finentry}}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames[world:english]{author}%
     \setunit{\addperiod\space}\printfield[world:book]{title}%
     \setunit{\addperiod\space}\printlist{location}%
     \setunit{\addcolon\space}\printlist{publisher}%
     \setunit{\addcomma\space}\printfield{year}\printfield{extradate}%
     \setunit{\addcomma\space}\printfield{edition}%
     \usebibmacro{finentry}}}
% 英文工作论文使用题名、工作论文系列、编号和年份。
\csletcs{blx@bbx@world@report}{blx@bbx@report}
\DeclareBibliographyDriver{report}{%
  \iffieldequalstr{userd}{chinese}
    {\csuse{blx@bbx@world@report}}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames[world:english]{author}%
     \setunit{\addperiod\space}\printfield[world:title]{title}%
     \setunit{\addspace}\printfield[noformat]{series}%
     \setunit{\addcomma\space}\printlist{location}%
     \setunit{\addcolon\space}\iflistequalcs{publisher}{abx@list@institution}{}{\printlist{publisher}}%
     \setunit{\addcomma\space}\printlist{institution}%
     \iffieldundef{number}{}{\setunit{\addspace}\printtext{No.\addspace}\printfield[noformat]{number}}%
     \setunit{\addcomma\space}\printfield{year}\printfield{extradate}%
     \iffieldundef{pages}{}{\setunit{\addcomma\space}\printtext{pp.}\printfield[noformat]{pages}}%
     \usebibmacro{finentry}}}
\DeclareBibliographyDriver{incollection}{%
  \iffieldequalstr{userd}{chinese}
    {\csuse{blx@bbx@world@incollection}}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames[world:english]{author}%
     \setunit{\addperiod\space}\printfield[world:chapter]{title}%
     \setunit{\addspace}\printtext{in}\setunit{\addspace}\printnames[world:editor]{editor}%
     \ifnameundef{editor}{}{%
       \setunit{\addcomma\space}%
       \ifnumgreater{\value{editor}}{1}{\printtext{eds\adddot}}{\printtext{ed\adddot}}}%
     \setunit{\addcomma\space}\printfield[world:book]{booktitle}%
     \setunit{\addperiod\space}\printlist{location}%
     \setunit{\addcolon\space}\printlist{publisher}%
     \setunit{\addcomma\space}\printfield{year}\printfield{extradate}%
     \setunit{\addcomma\space}%
     \iffieldundef{pages}{}{\printtext{pp.}\printfield[noformat]{pages}}%
     \usebibmacro{finentry}}}
\csletcs{blx@bbx@inproceedings}{blx@bbx@incollection}
% 未正式出版的手稿通过 entrysubtype=mimeo 标记。
\csletcs{blx@bbx@world@misc}{blx@bbx@misc}
\DeclareBibliographyDriver{misc}{%
  \iffieldequalstr{entrysubtype}{mimeo}{%
    \usebibmacro{bibindex}\usebibmacro{begentry}\printnames[world:english]{author}%
    \setunit{\addperiod\space}\printfield[world:title]{title}%
    \setunit{\addspace}\printtext{mimeo}%
    \setunit{\addcomma\space}\printlist{institution}%
    \setunit{\addcomma\space}\printfield{year}\printfield{extradate}%
    \usebibmacro{finentry}%
  }{\csuse{blx@bbx@world@misc}}}

\endinput
