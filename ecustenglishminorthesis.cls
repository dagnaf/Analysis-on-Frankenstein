\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecustenglishminorthesis}[2015/02/10]

\LoadClass[cs4size, a4paper, adobefonts, nocap]{ctexrep}

\setmainfont{Times New Roman}

\usepackage[left=2.5cm, right=2.5cm, top=2.8cm, bottom=2.5cm,
    headheight=15pt, headsep=0.3cm, footskip=0.5cm
]{geometry}

\usepackage[numbers]{natbib}
%\hyperlinkcite takes 2 arguments: #1<- cite-key, #2<- link-text
\newcommand*{\citec}[1]{\hyper@link{cite}{cite.#1}}
\renewcommand\citep[1]{(\citeauthor{#1}, \citeyear{#1})}
\renewcommand\citet[1]{\citeauthor{#1} (\citeyear{#1})}
\newcommand\citepzh[2]{(\citec{#1}{#2}, \citeyear{#1})}
\newcommand\citetzh[2]{\citec{#1}{#2} (\citeyear{#1})}

\usepackage[hidelinks,bookmarksnumbered]{hyperref}

\usepackage{fancyhdr}
\fancypagestyle{plain}{
  \fancyhead[L]{
    \zihao{5}{Analysis on \textit{Frankenstein; or, The Modern Prometheus} from the Perspective of Moral Psychology}
  }
  \fancyhead[R]{\zihao{5}{\thepage}}
  \fancyfoot[C]{}
  \renewcommand{\headrulewidth}{0.75pt}
}
\fancypagestyle{head}{
  \fancyhead[L]{}
  \fancyhead[R]{}
  \fancyfoot[C]{\zihao{5}{- \thepage{} -}}
  \renewcommand{\headrulewidth}{0pt}
}
\pagestyle{plain}



%\renewcommand\contentsname{Contents}
\usepackage{titletoc}
\contentsmargin{0cm}

\newcommand\words[1]{\expandafter\xwords\csname c@#1\endcsname}
\def\xwords#1{\ifcase#1\or
One\or
Two\or
Three\or
Four\or
Five\or
Six\else
I need more words\fi}

\renewcommand\thechapter{\words{chapter}}
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}
\renewcommand\thesubsection{\arabic{chapter}.\arabic{section}.\arabic{subsection}}

\titlecontents{chapter}
[0cm]% left margin
{}% above code
{\heiti\bfseries\zihao{4}\thecontentslabel { }}% numbered format
{\heiti\bfseries\zihao{4}\thecontentslabel}% unnumbered format
{\titlerule*[0.5pc]{.}\thecontentspage\vspace{-3pt}}

\titlecontents{section}
[2em]
{}
{\thecontentslabel { }}
{}
{\titlerule*[0.5pc]{.}\thecontentspage}

\titlecontents{subsection}
[4em]
{}
{\thecontentslabel { }}
{}
{\titlerule*[0.5pc]{.}\thecontentspage\vspace{-2pt}}



\renewcommand\tableofcontents{%
    {\centering\bfseries\zihao{-2}{\contentsname\\}}\vspace{12pt}
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
    }

\newcommand{\mktableofcontents}{
  \clearpage
  %\pagenumbering{roman}
  \thispagestyle{head}
  %\pdfbookmark[1]{\contentsname}{contents}
  \tableofcontents
  \clearpage
  \pagenumbering{arabic}
}


\usepackage{titlesec}
%titleformat{cmd:section}[fmt:see]{fmt:title}{label}{sep}{before}[after]
\titleformat{\chapter}{\centering\bfseries\zihao{-2}}{Chapter \thechapter}{0.5em}{}
%\titlespacing{cmd}{left}{before-sep}{after-sep}[right-sep]
\titlespacing*{\chapter}{0pt}{0pt}{18pt}%FIXME
\titleformat{\section}{\bfseries\zihao{-3}}{\thesection}{0.5em}{}
\titlespacing*{\section}{0pt}{0pt}{15pt}%FIXME
\titleformat{\subsection}{\bfseries\zihao{4}}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{0pt}{14pt}%FIXME
%\CTEXsetup[beforeskip={12pt},afterskip={12pt}]{section}
%\CTEXsetup[beforeskip={12pt},afterskip={0pt}]{subsection}
%\CTEXsetup[beforeskip={12pt},afterskip={0pt}]{subsubsection}

% 重定义参考文献环境（由于list是内部定义），编号全部靠左，中间空2pt的空格后加上参考内容
% 如果内容超过一行第二行缩进2字符，借用参考文献格式
% 参考文献使用的是section，添加到目录和书签中
% 如果在论文中则没有章节编号，在开题报告中有章节编号
% FIXME 空格的长度是否是2pt
\renewcommand{\@biblabel}[1]{[#1]\hfill}
\def\refname{Bibliography}
\renewenvironment{thebibliography}[1]{
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{\refname}
  \chapter*{\refname}%
  \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
  \list{\@biblabel{\@arabic\c@enumiv}}{
    \setlength\itemsep{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\labelsep}{2pt}% FIXME
    \setlength\labelwidth{0pt}
    \setlength{\itemindent}{\dimexpr\labelsep-2em}
    \leftmargin 2em
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}{
    \def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}
  \endlist}

\bibliographystyle{./GBT7714-2005NLang-UTF8}
%\bibliographystyle{plain}

% 致谢页面，在论文中使用，无章节编号
\newcommand{\acknowledgment}{
  \def\ackname{Acknowledgments}
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{\ackname}
  \chapter*{\ackname}
}




% 论文的摘要，分中文摘要和英文摘要，新定义环境zh和en
% FIXME 中英文大部分格式是统一的，用命令调用会更容易维护
\newenvironment{abstractzh}[1]{
  \def\keywordszh{#1}
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{摘要}
  \pagenumbering{roman}
  \thispagestyle{head}
  \vspace*{102pt}
  {\centering\heiti\zihao{-2} 摘要\par}
  \vspace*{12pt}\par
  \songti\zihao{-4}
}{
  \vspace*{12pt}\par
  {\heiti\zihao{-4} 关键词：}
  {\songti\zihao{-4} \keywordszh}
}
\newenvironment{abstracten}[1]{
  \def\keywordsen{#1}
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  % \pagenumbering{roman}
  \thispagestyle{head}
  \vspace*{102pt}
  % \pdfbookmark[1]{Abstract}{abstracten}
  {\centering\bfseries\zihao{-2} Abstract\par}
  \vspace*{12pt}\par
  \zihao{-4}
}{
  \vspace*{12pt}\par
  {\bfseries\zihao{-4} Keywords:}
  {\zihao{-4} \keywordsen}
}

\renewcommand{\baselinestretch}{1.35}

\newcommand{\docinit}{
  \nocite{*}
%  \setlength{\belowdisplayskip}{0pt}
%  \setlength{\belowdisplayshortskip}{0pt}
%  \setlength{\abovedisplayskip}{0pt}
%  \setlength{\abovedisplayshortskip}{0pt}
%  \setlength{\abovecaptionskip}{5pt}%
%  \setlength{\belowcaptionskip}{5pt}%
%  \setlength{\intextsep}{5pt}
}

\newenvironment{text}{}{\vspace{12pt}}
