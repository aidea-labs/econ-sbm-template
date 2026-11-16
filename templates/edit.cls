\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{edit}[2026/11/10 Chinese economics manuscript review]
\LoadClass[linespread=2,bibstyle=authoryear,citestyle=authoryear]{base}
% 审阅版显示链接边框。
\hypersetup{pdfborder={0 0 1}}
\RequirePackage{xpatch}

% 著者—出版年制已为年份添加链接，这里也为作者姓名添加链接。
\xpatchbibmacro{textcite}
  {\printnames{labelname}}
  {\printtext[bibhyperref]{\printnames{labelname}}}
  {}
  {\ClassError{edit}{Could not link citation author names}{Check the definition of the textcite bibliography macro.}}


% 表格用单倍行距，正文用双倍行距。
\AddToHook{env/table/begin}{\linespread{1}\selectfont}
\AddToHook{env/table*/begin}{\linespread{1}\selectfont}

% 摘要标题和摘要内容均采用正文字号。
\patchcmd{\abstract}{\small}{\normalsize}{}{%
  \ClassError{edit}{Could not apply the abstract font size}{Check the definition of \string\abstract.}}

% 接收投稿信息字段，审阅版中省略这些字段。
\NewDocumentCommand{\titleen}{m}{}
\NewDocumentCommand{\coverauthor}{m m m m m m}{}
\NewDocumentCommand{\correspondenceaddress}{m}{}
\NewDocumentCommand{\acknowledgments}{+m}{}

\newcommand{\keywords}[1]{%
  \par\medskip\noindent\textbf{关键词：}#1\par
}
