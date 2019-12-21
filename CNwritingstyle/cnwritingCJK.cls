%---------------------------------------------------------
%
%  This class file is for Traditional Chinese writing,
%  referring to from right to left, top to down writing style
%  adapted from 
%
%  (1) ociamthesis v2.2 (22/11/2010) By Keith A. Gillow 
%  <gillow@maths.ox.ac.uk>. Version 1.0 released 26/11/1997
%  (2) also from "Minutes in less than Hours: 
%  Using \LaTeX Resources" by Jim Hefferon,
%  <ftpmaint@tug.ctan.org>
%  by Jesse LO

%  For usages limited to personal and within an organization.
%  If you modified this file, you should keep this section intact
%  and MOST importantly DO NOT use the same file name 
%  as the file name is for this file EXCLUSIVELY.
%----------------------------------------------------------
\def\fileversion{2.0}
\def\filedate{2013/1/1}
\typeout{}
\typeout{Document Class: cnwritingCJK.cls 
        \filedate \space v\fileversion \space (Jesse LO)}
\typeout{for National Central University, TW.}
\typeout{}

% -- standard identification 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cnwritingCJK}[2013/1/1 2.0 Chinese writing style]
% -- initial code 
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
% -- executation 
\ProcessOptions\relax
\LoadClass[landscape]{report}
%\LoadClass[twoside,landscape,openright]{report}  % 雙面印刷 
\raggedbottom
\RequirePackage{tikz,graphicx}          % graphics, if any
\RequirePackage[utf8]{inputenc}
\RequirePackage{CJKutf8,CJKnumb,CJKvert}
\RequirePackage{showframe,printlen,calculator}
\RequirePackage[bookmarks=true,unicode=true,colorlinks=true,
pdfborder={0 0 0},pdfauthor={JCLO},linktoc=all,
pdftitle={The Chinese Writing Style}]{hyperref}       % 超聯結

% -- 中文化章節

\RequirePackage[compact]{titlesec}
\RequirePackage{titletoc,everypage}
\renewcommand{\thechapter}{\arabic{chapter}}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\arabic{subsection}}

% --  usage
% \titleformat{ command }[ shape ]{ format }{ label }{ sep }{ before }[ after ]
% \titlespacing{ command }{ left }{ beforesep }{ aftersep }[ right ]
%----------------------------
\titleformat{\chapter}[hang]{\Huge\bfseries} 
{第\,\CJKnumber{\thechapter}\,章} {2pc} {\thispagestyle{empty}}
\titlespacing{\chapter}{0pc}{*2}{*2}[5pc]                
%----------------------------
\titleformat{\section}[hang]{\Large\bfseries}
{第\,\CJKnumber{\thechapter}之\CJKnumber{\thesection}\,節}{2pc}{}
\titlespacing{\section}{5pc}{*2}{*2}[5pc]
%----------------------------
\titleformat{\subsection}[hang]{\normalsize\bfseries}
{第\,\CJKnumber{\thechapter}之\CJKnumber{\thesection}之\CJKnumber{\thesubsection}\,小節}{1em}{}
\titlespacing{\subsection}{5pc}{*2}{*2}[5pc]
%--------------------------------
\titlecontents{chapter}[0em]{}     % for  Chinese table of contents
{第\CJKnumber{\thecontentslabel}章~~}
{}{\hspace{1em}\titlerule{.}\thecontentspage}
\titlecontents{section}[4em]{}
{第\CJKnumber{\thecontentslabel}節~~}
{}{\titlerule*{.}\thecontentspage}
\titlecontents{subsection}[8em]{}
{第\CJKnumber{\thecontentslabel}小節~~}
{}{\titlerule*{.}\thecontentspage}

\let\Contentsline\contentsline     % for vertical display of page numbers%
\renewcommand*{\contentsline}[3]{\Contentsline{#1}{#2}{\rotatebox[origin=cc]{90}{#3}}}
\renewcommand*{\@dotsep}{1}
\renewcommand*{\@pnumwidth}{0.75em}
\renewcommand*\@biblabel[1]{\rotatebox[origin=cc]{90}{[#1]}}   
\renewcommand*\@cite[1]{\rotatebox[origin=cc]{90}{[#1]}}
 
%----------------------------
\renewcommand{\contentsname}{\protect\centering 目~錄}
\renewcommand{\listfigurename}{\protect\centering 圖~目~錄}
\renewcommand{\listtablename}{\protect\centering 表~目~錄}
\renewcommand{\figurename}{\protect\centering 圖}
\renewcommand{\tablename}{\protect\centering 表}
\renewcommand{\indexname}{\protect\centering 索~引}
\renewcommand{\bibname}{\protect\centering 參~考~文~獻}

% DECLARATIONS  宣告
%

\SUBTRACT{\number\year}{1911}{\sol}
\def\today{
\CJKnumber{\sol}年\space\CJKnumber{\number\month}
月\space\CJKnumber{\number\day}日}

\def\author#1{\gdef\@author{#1}}

\DeclareOption{draft}{
\let\@evenfoot\@oddfoot
\renewcommand\@oddfoot{
\today \hfil 未完稿 v2.0 \hfil \copyright\ \@author}
}
\DeclareOption{noframe}{}
\ProcessOptions\relax

%-------Print paper number borrowed from background.
\newcommand\jc@pagenumber{%
\begin{tikzpicture}[overlay,remember picture]
\node [rotate=90,yshift=-12.5cm,scale=1.2] at (current page.center) {\thepage};
\end{tikzpicture}
}
\AddEverypageHook{\jc@pagenumber}

% --- paper size

\setlength{\topmargin}{-0.5cm}
\setlength{\oddsidemargin}{5mm}
\setlength{\evensidemargin}{5mm}
\setlength{\textheight}{15.5cm}
\setlength{\textwidth}{22.5cm}

\uselengthunit{cm}
\newcommand{\printpagesize}{
\rotatebox[origin=cc]{90}{
\begin{tabular}{l@{ : }r}
top margin & \printlength{\topmargin}\\
odd side margin & \printlength{\oddsidemargin}\\
even side margin & \printlength{\evensidemargin}\\
text height & \printlength{\textheight}\\
text width & \printlength{\textwidth}\\
paper height & \printlength{\paperheight}\\
paper width &\printlength{\paperwidth}
\end{tabular}
}}

% -- Environments

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi
       \begin{CJK}{UTF8}{bkai}}%
       {\end{CJK}
       \if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}


	   
% -- Book title on the first page

\def\titlepage#1#2{
\begin{alwayssingle}
\thispagestyle{empty}
\pagenumbering{gobble}
\today
\null\vfill
\begin{center}
\fontsize{40pt}{20pt}\selectfont 
#1                                               % 書名
\end{center}
\null\vfill
\begin{flushright}
\fontsize{30pt}{20pt}\selectfont \copyright\ #2  % 作者
\end{flushright}
\end{alwayssingle}
}

\newenvironment{onecol}[1]
{\phantomsection\addcontentsline{toc}{chapter}{#1}
\begin{alwayssingle}
\thispagestyle{empty}
\begin{flushleft}
{\Large \bfseries #1}
\end{flushleft}}
{\null \vfill
\end{alwayssingle}}

% -- preface

\newenvironment{preface}
{\begin{onecol}{\LARGE 自序}} 
{\end{onecol}}

% -- acknowledgement

\newenvironment{acknowledge}
{\begin{onecol}{\LARGE 謝誌}} 
{\end{onecol}}

% -- Indentation

\leftskip 0cm
\parindent 1cm   
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue                

% To make index page number displayed vertically
%
%\def\@wrindex#1{%
%       \protected@write\@indexfile{}%
%      {\string\indexentry{#1\@gobble{#1}|rotatebox[origin=cc]{90}}{\thepage}}%
%\endgroup
%\@esphack
%}

%\let\gobblecomma\@gobble
%\let\OldIndex\index
%\renewcommand{\index}[1]{\OldIndex{#1|{rotatebox[origin=cc]{90}{#1}}}} 

\endinput
%-------------end of ncuthesis 