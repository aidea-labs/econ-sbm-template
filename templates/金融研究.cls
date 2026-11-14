% 格式参考：https://www.jryj.org.cn/CN/column/item74.shtml
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{金融研究}[2026/11/13 中文经济学期刊投稿模板]

% 封面单独输出，其他选项交给基础模板处理。
\newif\ifjournal@cover
\DeclareOption{cover}{\journal@covertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}
\ProcessOptions\relax
\PassOptionsToPackage{gblanorder=chineseahead,sortlocale=zh__pinyin,maxbibnames=99,maxcitenames=2,mincitenames=1,uniquename=false,uniquelist=false}{biblatex}
\LoadClass[zihao=5,bibstyle=chinese-erj,citestyle=chinese-erj]{base}
% 兼容尚未加载超链接支持的基础模板。
\@ifpackageloaded{hyperref}{}{\RequirePackage[hidelinks]{hyperref}}

\RequirePackage[margin=2.5cm]{geometry}
\RequirePackage{placeins}
\RequirePackage{perpage}
\RequirePackage{caption}
\captionsetup{labelsep=space}
\MakePerPage{footnote}
\renewcommand{\thefootnote}{\textcircled{\scriptsize\arabic{footnote}}}
\NewDocumentCommand{\figuresource}{m}{\par\noindent\footnotesize 资料来源：#1\par}
\NewDocumentCommand{\tablesource}{m}{\par\noindent\footnotesize 资料来源：#1\par}

% 统一常见语言标记，确保中英文文献按各自语言排序。
\DeclareSourcemap{\maps[datatype=bibtex]{
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:en(?:[-_][a-z]+)?)\z}, replace={english}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:zh(?:[-_][a-z]+)?)\z}, replace={chinese}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:english)\z}, final]\step[fieldset=lansortorder, fieldvalue={4}]}
  \map[overwrite]{\step[fieldsource=language, match=\regexp{\A(?i:chinese)\z}, final]\step[fieldset=lansortorder, fieldvalue={1}]}
}}
\DefineBibliographyStrings{english}{andincite = {and}}

% 按期刊示例区分中英文参考文献的标点与著录格式。
\DeclareNameFormat{journal:english}{%
  \ifnumgreater{\value{listcount}}{1}{%
    \ifnumequal{\value{listcount}}{\value{liststop}}
      {\ifnumgreater{\value{liststop}}{2}{\addcomma}{}\addspace and\space}
      {\addcomma\space}}{}%
  \ifnumequal{\value{listcount}}{1}
    {\namepartfamily\addcomma\space\namepartgiveni}
    {\namepartgiveni\space\namepartfamily}%
  \usebibmacro{name:andothers}}
\DeclareDelimFormat[bib]{multinamedelim}{\iffieldequalstr{userd}{chinese}{、}{\addcomma\space}}
\DeclareDelimFormat[bib]{finalnamedelim}{\iffieldequalstr{userd}{chinese}{和}{\addspace and\space}}
\DeclareFieldFormat{journal:enquote}{\mkbibquote{#1}}
\DeclareFieldFormat{journal:italics}{\mkbibemph{#1}}
\csletcs{blx@bbx@finance@article}{blx@bbx@article}
\csletcs{blx@bbx@finance@book}{blx@bbx@book}
\csletcs{blx@bbx@finance@report}{blx@bbx@report}
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \iffieldequalstr{userd}{chinese}{%
    \printnames{author}\setunit{，}\printfield{year}\setunit{，}%
    \printtext{《\printfield[noformat]{title}》}\setunit{，}%
    \printtext{《\printfield[noformat]{journaltitle}》}%
    \iffieldundef{number}{}{\printtext{第\printfield[noformat]{number}期}}%
    \iffieldundef{pages}{}{\printtext{，第\printfield[noformat]{pages}页}}%
  }{%
    \printnames[journal:english]{author}\setunit{\addcomma\space}\printfield{year}%
    \setunit{\addcomma\space}\printfield[journal:enquote]{title}%
    \setunit{\addcomma\space}\printfield[journal:italics]{journaltitle}%
    \setunit{\addcomma\space}\printfield{volume}%
    \iffieldundef{number}{}{\printtext{\mkbibparens{\printfield[noformat]{number}}}}%
    \iffieldundef{pages}{}{\setunit{\addcomma\space}\printtext{pp.\addspace}\printfield[noformat]{pages}}%
  }\usebibmacro{finentry}}
\DeclareBibliographyDriver{book}{%
  \iffieldequalstr{userd}{chinese}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \ifnameundef{author}{\printnames{editor}}{\printnames{author}}\setunit{，}\printfield{year}%
     \setunit{，}\printtext{《\printfield[noformat]{title}》}%
     \setunit{，}\printlist{publisher}\setunit{}\printfield{year}\printtext{年}%
     \iffieldundef{edition}{}{\printfield[noformat]{edition}\printtext{版}}%
     \usebibmacro{finentry}}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \ifnameundef{author}{\printnames[journal:english]{editor}}{\printnames[journal:english]{author}}%
     \setunit{\addcomma\space}\printfield{year}%
     \setunit{\addcomma\space}\printfield[journal:italics]{title}%
     \setunit{\addcomma\space}\printlist{publisher}\usebibmacro{finentry}}}
\csletcs{blx@bbx@collection}{blx@bbx@book}
\DeclareBibliographyDriver{report}{%
  \iffieldequalstr{userd}{chinese}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames{author}\setunit{，}\printfield{year}%
     \setunit{，}\printtext{《\printfield[noformat]{title}》}%
     \setunit{，}\printlist{institution}%
     \iffieldundef{number}{}{\setunit{，}\printfield[noformat]{number}}%
     \usebibmacro{finentry}}
    {\usebibmacro{bibindex}\usebibmacro{begentry}%
     \printnames[journal:english]{author}\setunit{\addcomma\space}\printfield{year}%
     \setunit{\addcomma\space}\printfield[journal:enquote]{title}%
     \setunit{\addcomma\space}\printlist{institution}%
     \iffieldundef{number}{}{\setunit{\addcomma\space}\printtext{No.\addspace}\printfield{number}}%
     \usebibmacro{finentry}}}
\newbibmacro*{finance:collection}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \iffieldequalstr{userd}{chinese}{%
    \printnames{author}\setunit{，}\printfield{year}%
    \setunit{，}\printtext{《\printfield[noformat]{title}》}%
    \ifnameundef{editor}{}{\setunit{，}\printtext{载}\printnames{editor}\printtext{主编}}%
    \setunit{，}\printtext{《\printfield[noformat]{booktitle}》}%
    \setunit{，}\printlist{location}\printlist{publisher}%
    \iffieldundef{pages}{}{\printtext{，第\printfield[noformat]{pages}页}}%
  }{%
    \printnames[journal:english]{author}\setunit{\addcomma\space}\printfield{year}%
    \setunit{\addcomma\space}\printfield[journal:enquote]{title}%
    \setunit{\addcomma\space}\printtext{in\space}\printfield[journal:italics]{booktitle}%
    \ifnameundef{editor}{}{\setunit{\addcomma\space}\printtext{Eds. by\space}\printnames[journal:english]{editor}}%
    \iffieldundef{pages}{}{\setunit{\addcomma\space}\printtext{pp.\addspace}\printfield[noformat]{pages}}%
  }\usebibmacro{finentry}}
\DeclareBibliographyDriver{incollection}{\usebibmacro{finance:collection}}
\DeclareBibliographyDriver{inproceedings}{\usebibmacro{finance:collection}}

% 官网未列明学位论文和网络文献示例，沿用作者—年份体例并保留来源信息。
\DeclareBibliographyDriver{thesis}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \iffieldequalstr{userd}{chinese}{%
    \printnames{author}\setunit{，}\printfield{year}%
    \setunit{，}\printtext{《\printfield[noformat]{title}》}%
    \setunit{，}\printlist{institution}%
  }{%
    \printnames[journal:english]{author}\setunit{\addcomma\space}\printfield{year}%
    \setunit{\addcomma\space}\printfield[journal:italics]{title}%
    \setunit{\addcomma\space}\printlist{institution}%
  }\usebibmacro{finentry}}
\DeclareBibliographyDriver{online}{%
  \usebibmacro{bibindex}\usebibmacro{begentry}%
  \iffieldequalstr{userd}{chinese}{%
    \printnames{author}\setunit{，}\printfield{year}%
    \setunit{，}\printtext{《\printfield[noformat]{title}》}%
    \setunit{，}\printfield{url}%
    \iffieldundef{urlyear}{}{\setunit{，}\printurldate}%
  }{%
    \printnames[journal:english]{author}\setunit{\addcomma\space}\printfield{year}%
    \setunit{\addcomma\space}\printfield[journal:enquote]{title}%
    \setunit{\addcomma\space}\printfield{url}%
    \iffieldundef{urlyear}{}{\setunit{\addcomma\space}\printurldate}%
  }\usebibmacro{finentry}}

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
  \ifdefempty{\econ@jel}{}{\noindent\textbf{JEL 分类号：}\econ@jel\par}%
  \medskip}

% 期刊要求英文信息排在文末，附录存在时放在附录之前。
\newcommand{\journal@english}{%
  \ifdefempty{\journal@titleen}{}{%
    \medskip\begin{center}{\large\bfseries\journal@titleen\par}\end{center}}%
  \ifdefempty{\econ@abstracten}{}{%
    \noindent\textbf{Abstract: }\econ@abstracten\par}%
  \ifdefempty{\econ@keywordsen}{}{%
    \noindent\textbf{Keywords: }\econ@keywordsen\par}}
\newif\ifjournal@englishprinted
\newcommand{\journal@printenglish}{%
  \ifjournal@englishprinted\else\global\journal@englishprintedtrue\journal@english\fi}
\ifjournal@cover\else
  \AddToHook{cmd/appendix/before}{\journal@printenglish}
  \AtEndDocument{\journal@printenglish}
\fi

% 前三级标题独占一行，第四级标题与正文接排。
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
\labelformat{subsubsection}{\thesubsubsection}
\labelformat{paragraph}{\theparagraph}

\endinput
