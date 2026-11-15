\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{base}[2026/11/12 Shared class for Chinese manuscripts]

% Check the engine before loading the Chinese typesetting class.
\RequirePackage{iftex}
\RequireXeTeX

% Set defaults before loading biblatex, allowing child classes to replace them.
\DeclareKeys{
  bibstyle .code:n = {\def\econ@bibstyle{#1}},
  bibstyle .initial:n = gb7714-2025ay,
  bibstyle .value_required:n = true,
  citestyle .code:n = {\def\econ@citestyle{#1}},
  citestyle .initial:n = gb7714-2025ay,
  citestyle .value_required:n = true,
  zihao .code:n = {\def\econ@bodyzihao{#1}},
  zihao .initial:n = 4,
  zihao .value_required:n = true,
  linespread .code:n = {\def\econ@linespread{#1}},
  linespread .initial:n = 1.5,
  linespread .value_required:n = true
}
\DeclareUnknownKeyHandler{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessKeyOptions
\RequirePackage{etoolbox}
\ExpandArgs{e}\PassOptionsToClass{linespread=\econ@linespread}{ctexart}

% CTeX 自带五号、小四号和关闭字号预设三种选项，其余字号在载入后设置。
\newif\ifecon@ctexsize
\ifboolexpr{
  test {\ifdefstring{\econ@bodyzihao}{5}}
  or test {\ifdefstring{\econ@bodyzihao}{-4}}
  or test {\ifdefstring{\econ@bodyzihao}{false}}
}{\econ@ctexsizetrue}{}
\ifecon@ctexsize
  \ExpandArgs{e}\PassOptionsToClass{zihao=\econ@bodyzihao}{ctexart}
\fi
\LoadClass[UTF8,a4paper]{ctexart}

% 正文沿用 CTeX 的宋体，四号等额外字号用 \zihao 设置。
\ifecon@ctexsize\else
  \let\econ@normalsize\normalsize
  \renewcommand{\normalsize}{\econ@normalsize\zihao{\econ@bodyzihao}}
  \AtBeginDocument{\normalsize}
\fi

% 英文正文、无衬线文本和代码文本统一用 Times New Roman，系统未安装时用替代字体。
\IfFontExistsTF{Times New Roman}
  {\def\econ@latinfont{Times New Roman}}
  {\def\econ@latinfont{TeX Gyre Termes}%
   \ClassWarningNoLine{base}{Times New Roman unavailable; using TeX Gyre Termes}}
\setmainfont{\econ@latinfont}
\setsansfont{\econ@latinfont}
\setmonofont{\econ@latinfont}

% 标题用二号黑体，沿用标准标题区的作者和脚注处理。
\newcommand*{\econ@titleformat}{\heiti\zihao{2}}
\newcommand*{\econ@settitleformat}[1]{%
  \patchcmd{#1}{\LARGE\@title}{\econ@titleformat\@title}{}{%
    \ClassError{base}{Could not apply the title font}{Check the definition of \string#1.}}}
\if@titlepage
  \econ@settitleformat{\maketitle}
\else
  \econ@settitleformat{\@maketitle}
\fi

% 一级标题用三号黑体，二级及以下标题用小三号宋体。
\ctexset{
  section = {format = \normalfont\centering\heiti\zihao{3}},
  subsection = {format = \normalfont\songti\zihao{-3}},
  subsubsection = {format = \normalfont\songti\zihao{-3}},
  paragraph = {format = \normalfont\songti\zihao{-3}},
  subparagraph = {format = \normalfont\songti\zihao{-3}}
}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{graphicx}

\RequirePackage[
  backend=biber,
  bibstyle=\econ@bibstyle,
  citestyle=\econ@citestyle
]{biblatex}
\RequirePackage[hidelinks]{hyperref}

% Shared manuscript fields. Each template controls how they are displayed.
\newcommand{\econ@abstracten}{}
\newcommand{\econ@keywordsen}{}
\newcommand{\econ@jel}{}

\NewDocumentCommand{\abstracten}{+m}{\gdef\econ@abstracten{#1}}
\NewDocumentCommand{\keywordsen}{m}{\gdef\econ@keywordsen{#1}}
\NewDocumentCommand{\jel}{m}{\gdef\econ@jel{#1}}
