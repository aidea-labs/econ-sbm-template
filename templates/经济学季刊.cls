% 格式参考：https://nsd.pku.edu.cn/xzyj/cbw/jjxjk/tgzg/250625.htm

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{经济学季刊}[2026/11/11 Economic Quarterly manuscript]

\newif\ifeq@cover
\DeclareOption{cover}{\eq@covertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{base}}
\ProcessOptions\relax

% 季刊用五号字（zihao=5）和单倍行距（linespread=1），在加载 base.cls 时设置。
% 文内用作者—年份引用，文末按作者姓名排序并编号。
\PassOptionsToPackage{
  sorting=nyt,
  sortlocale=zh__pinyin,
  giveninits=true,
  doi=false,
  isbn=false,
  url=false,
  eprint=false
}{biblatex}
\LoadClass[zihao=5,linespread=1,bibstyle=numeric,citestyle=authoryear]{base}

%%%%%%%%%%%%%%%%%%%%
% 独立封面和匿名正文
% 生成独立封面时，把 main.tex 第一行改为 \documentclass[cover]{经济学季刊}。
% 正式封面为每位作者填写一次 \coverauthor，再填写 \correspondenceaddress。如有感谢语，填写 \acknowledgments。
% 未填写 \coverauthor 时，封面沿用 \author 中的署名及 \thanks 中的作者脚注。
% 编译时可用 latexmk -jobname=cover main.tex，将封面另存为 cover.pdf。
% 生成匿名正文时，第一行写 \documentclass{经济学季刊}。
%%%%%%%%%%%%%%%%%%%%

\newcommand{\eq@authors}{}
\newcommand{\eq@address}{}
\newcommand{\eq@acknowledgments}{}

\NewDocumentCommand{\correspondenceaddress}{m}{\gdef\eq@address{#1}}
\NewDocumentCommand{\acknowledgments}{+m}{\gdef\eq@acknowledgments{#1}}

% 每调用一次就添加一位作者，按稿件中的填写顺序排列。
\NewDocumentCommand{\coverauthor}{m m m m m m}{%
  \g@addto@macro\eq@authors{%
    \noindent\textbf{#1（#2）}\par
    \noindent #3（#4）\par
    \noindent 电话：#5\par
    \noindent 邮箱：\nolinkurl{#6}\par
    \medskip
  }%
}

\newcommand{\eq@warnifempty}[2]{%
  \ifdefempty{#1}{\ClassWarningNoLine{经济学季刊}{Missing #2}}{}}

\newcommand{\eq@printcover}{%
  \eq@warnifempty{\eq@authors}{cover author details}%
  \eq@warnifempty{\eq@address}{corresponding author address}%
  \thispagestyle{empty}%
  \eq@printtitle
  \ifdefempty{\eq@authors}{%
    \noindent\begin{tabular}[t]{@{}l@{}}\@author\end{tabular}\par
    \@thanks
  }{\eq@authors}%
  \ifdefempty{\eq@address}{}{%
    \noindent\textbf{通信作者地址：}\eq@address\par
  }%
  \ifdefempty{\eq@acknowledgments}{}{%
    \medskip
    \noindent\textbf{感谢语：}\eq@acknowledgments\par
  }%
}

\ifeq@cover
  % 封面排完即结束编译，使这份 PDF 只包含封面。
  \renewcommand{\maketitle}{\eq@printcover\end{document}}
\else
  \pagestyle{plain}
  \renewcommand{\maketitle}{\eq@printanonymous}
\fi

%%%%%%%%%%%%%%%%%%%%
% 正文首页配置
%%%%%%%%%%%%%%%%%%%%

\newcommand{\eq@titleen}{}
\NewDocumentCommand{\titleen}{m}{\gdef\eq@titleen{#1}}

\newcommand{\eq@printtitle}{%
  \begin{center}
    {\econ@titleformat\@title\par}
  \end{center}%
}

\newcommand{\eq@printanonymous}{%
  \eq@warnifempty{\eq@titleen}{English title}%
  \eq@warnifempty{\econ@abstracten}{English abstract}%
  \eq@warnifempty{\econ@keywordsen}{English keywords}%
  \eq@warnifempty{\econ@jel}{JEL codes}%
  \hypersetup{pdfauthor={}}%
  \thispagestyle{plain}%
  \eq@printtitle
}

\RenewDocumentEnvironment{abstract}{}{%
  \par\noindent\textbf{摘要：}\ignorespaces
}{\par\medskip}

% 排完中文关键词后，接着排英文关键词、英文标题、英文摘要和 JEL 分类号。
\NewDocumentCommand{\keywords}{m}{%
  \par\noindent\textbf{关键词：}#1\par
  \noindent\textbf{Keywords: }\econ@keywordsen\par
  \begin{center}
    {\large\bfseries\eq@titleen\par}
  \end{center}%
  \noindent\textbf{Abstract: }\econ@abstracten\par
  \medskip
  \noindent\textbf{JEL 分类号：}\econ@jel\par
  \medskip
}

%%%%%%%%%%%%%%%%%%%%
% 标题配置
%%%%%%%%%%%%%%%%%%%%

\setcounter{secnumdepth}{4}

\ctexset{
  section = {
    name = {,、}, number = \chinese{section}, aftername = {},
    format = \normalfont\kaishu\zihao{4}\centering,
    beforeskip = \baselineskip, afterskip = \baselineskip
  },
  subsection = {
    name = {（,）}, number = \chinese{subsection}, aftername = {},
    format = \normalfont, indent = 2\ccwd,
    beforeskip = .5\baselineskip, afterskip = .5\baselineskip
  },
  subsubsection = {
    name = {,.}, number = \arabic{subsubsection}, aftername = \enspace,
    format = \normalfont, indent = 2\ccwd,
    beforeskip = 0pt, afterskip = 0pt
  },
  paragraph = {
    name = {（,）}, number = \arabic{paragraph}, aftername = {},
    format = \normalfont, indent = 2\ccwd, runin = true,
    beforeskip = 0pt, afterskip = .5em
  },
  subparagraph = {
    format = \normalfont, indent = 2\ccwd, runin = true,
    beforeskip = 0pt, afterskip = .5em
  }
}

% 各级标题的显示编号从头计数，交叉引用保留完整层级编号。
\labelformat{subsection}{\thesubsection}
\labelformat{subsubsection}{\thesubsubsection}
\labelformat{paragraph}{\theparagraph}

%%%%%%%%%%%%%%%%%%%%
% 字号、行间距
%%%%%%%%%%%%%%%%%%%%

% 五号字和单倍行距在文件开头加载 base.cls 时设置。
% 选用仿宋，并为表头和字段标签提供模拟粗体。
\newcommand{\eq@fangsongfont}{FandolFang-Regular.otf}
\IfFontExistsTF{FangSong}
  {\renewcommand{\eq@fangsongfont}{FangSong}}
  {\IfFontExistsTF{STFangsong}{\renewcommand{\eq@fangsongfont}{STFangsong}}{}}
\setCJKfamilyfont{eq-fangsong}[AutoFakeBold=2,AutoFakeSlant=.2]{\eq@fangsongfont}
\renewcommand{\CJKrmdefault}{eq-fangsong}

%%%%%%%%%%%%%%%%%%%%
% 参考文献配置
%%%%%%%%%%%%%%%%%%%%

% 文内和文末的样式选项在文件开头传入。以下定义具体的姓名、页码和条目格式。
% 文献条目未指定语种时，根据作者姓名中的汉字识别中文条目。
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldsource=author, match=\regexp{\p{Han}}, final]
      \step[fieldset=langid, fieldvalue={chinese}]
    }
  }
}
\DeclareNameAlias{author}{family-given/given-family}
\DeclareNameFormat{eq:chinese-name}{%
  \nameparts{#1}%
  \usebibmacro{name:delim}{\namepartfamily}%
  \printtext{\namepartfamily\namepartgiven}%
  \usebibmacro{name:andothers}}
\DeclareDelimFormat{multinamedelim}{%
  \iffieldequalstr{langid}{chinese}{、}{\addcomma\space}}
\DeclareDelimFormat{finalnamedelim}{%
  \iffieldequalstr{langid}{chinese}
    {、}
    {\ifnumgreater{\value{liststop}}{2}{\finalandcomma}{}\addspace\bibstring{and}\space}}
\AtEveryBibitem{%
  \clearlist{language}%
  \iffieldequalstr{langid}{chinese}
    {\DeclareNameAlias{author}{eq:chinese-name}%
     \DeclareNameAlias{editor}{eq:chinese-name}}
    {}}

\AtEveryCitekey{%
  \iffieldequalstr{langid}{chinese}
    {\DeclareNameAlias{labelname}{eq:chinese-name}}
    {}}
\DeclareDelimFormat{nameyeardelim}{\addcomma\space}
\DeclareDelimFormat{postnotedelim}{%
  \iffieldequalstr{langid}{chinese}{：}{\addcolon}}
\DeclareFieldFormat{postnote}{%
  \ifpages{#1}
    {\iffieldequalstr{langid}{chinese}{第\mkautorange{#1}页}{pp.\mkautorange{#1}}}
    {#1}}

\DeclareFieldFormat{eq:year}{#1年}
\DeclareFieldFormat{eq:volume}{第#1卷}
\DeclareFieldFormat{eq:issue}{第#1期}
\DeclareFieldFormat{eq:pages}{第#1页}
\DeclareFieldFormat{eq:booktitle}{《#1》}

\newbibmacro*{eq:publication}{%
  \printlist{location}%
  \setunit{\addcolon\space}%
  \printlist{publisher}%
  \setunit{\addcomma\space}%
  \iffieldequalstr{langid}{chinese}
    {\printfield[eq:year]{year}}
    {\printfield{year}}}

\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\addcomma\space}%
  \usebibmacro{title}%
  \setunit{\addcomma\space}%
  \usebibmacro{journal}%
  \setunit{\addcomma\space}%
  \iffieldequalstr{langid}{chinese}
    {\printfield[eq:year]{year}%
     \setunit{}%
     \printfield[eq:volume]{volume}%
     \setunit{}%
     \printfield[eq:issue]{number}%
     \setunit{，}%
     \printfield[eq:pages]{pages}}
    {\printfield{year}%
     \setunit{\addcomma\space}%
     \printfield{volume}%
     \setunit{}%
     \printfield[parens]{number}%
     \setunit{\addcomma\space}%
     \printfield[noformat]{pages}}%
  \usebibmacro{finentry}}

\DeclareBibliographyDriver{book}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/editor+others/translator+others}%
  \setunit{\addcomma\space}%
  \usebibmacro{title}%
  \newunit\newblock
  \usebibmacro{eq:publication}%
  \usebibmacro{finentry}}

\DeclareBibliographyDriver{incollection}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\addcomma\space}%
  \usebibmacro{title}%
  \setunit{\addcomma\space}%
  \printtext{\iffieldequalstr{langid}{chinese}{载}{\bibstring{in}}}%
  \setunit{\addspace}%
  \printnames{editor}%
  \iffieldequalstr{langid}{chinese}
    {\setunit*{编}%
     \printfield[eq:booktitle]{booktitle}}
    {\setunit{\addcomma\space}%
     \usebibmacro{maintitle+booktitle}}%
  \newunit\newblock
  \usebibmacro{eq:publication}%
  \setunit{\addcomma\space}%
  \printfield[noformat]{pages}%
  \usebibmacro{finentry}}

%%%%%%%%%%%%%%%%%%%%
% 其他的
%%%%%%%%%%%%%%%%%%%%

\RequirePackage{placeins}

% 先排完待处理的正文图表，再开始参考文献或附录。
\AddToHook{cmd/printbibliography/before}{\FloatBarrier}
\AddToHook{cmd/appendix/before}{\FloatBarrier}

\endinput
