\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{base}[2026/11/12 Shared class for Chinese manuscripts]

% Check the engine before loading the Chinese typesetting class.
\RequirePackage{iftex}
\RequireXeTeX

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[UTF8]{ctexart}

\RequirePackage{booktabs}
\RequirePackage{graphicx}

% Shared manuscript fields. Each template controls how they are displayed.
\newcommand{\econ@abstracten}{}
\newcommand{\econ@keywordsen}{}
\newcommand{\econ@jel}{}

\NewDocumentCommand{\abstracten}{+m}{\gdef\econ@abstracten{#1}}
\NewDocumentCommand{\keywordsen}{m}{\gdef\econ@keywordsen{#1}}
\NewDocumentCommand{\jel}{m}{\gdef\econ@jel{#1}}
