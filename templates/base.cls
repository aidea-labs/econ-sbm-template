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
  citestyle .value_required:n = true
}
\DeclareUnknownKeyHandler{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessKeyOptions
\LoadClass[UTF8]{ctexart}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{graphicx}

\RequirePackage[
  backend=biber,
  bibstyle=\econ@bibstyle,
  citestyle=\econ@citestyle
]{biblatex}

% Shared manuscript fields. Each template controls how they are displayed.
\newcommand{\econ@abstracten}{}
\newcommand{\econ@keywordsen}{}
\newcommand{\econ@jel}{}

\NewDocumentCommand{\abstracten}{+m}{\gdef\econ@abstracten{#1}}
\NewDocumentCommand{\keywordsen}{m}{\gdef\econ@keywordsen{#1}}
\NewDocumentCommand{\jel}{m}{\gdef\econ@jel{#1}}
