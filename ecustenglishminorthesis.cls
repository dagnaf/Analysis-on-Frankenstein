\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecustenglishminorthesis}[2015/02/10]
% 默认字体大小11pt小四、A4、adobe字体（可删除）、英文标注
\LoadClass[cs4size, a4paper, adobefonts, nocap]{ctexrep}

\setmainfont{Times New Roman}
% 与word格式基本一样（不完全具体见下#）
\usepackage[left=2.5cm, right=2.5cm, top=2.8cm, bottom=2.5cm,
    headheight=15pt, headsep=0.4cm, footskip=0.5cm
]{geometry}
% 参考文献（注意这里只能按照文中引用出现的顺序，如果要按照作者等请用nocite{*}后在bib文件里手动排序）
\usepackage[numbers]{natbib}
% 由于引用时用的是（作者，年代）而参考文献列的是序号，所以重写引用命令
% citec{thesis2015}{(Zuozhe，2015)} => (Zuozhe, 2015) % 附带链接
\newcommand*{\citec}[1]{\hyper@link{cite}{cite.#1}}
% citep 作者年代的括号形式
\renewcommand\citep[1]{(\citeauthor{#1}, \citeyear{#1})}
% citet 作者 （年代）
\renewcommand\citet[1]{\citeauthor{#1} (\citeyear{#1})}
% 下面两个方便中文作者拼音化
\newcommand\citepzh[2]{(\citec{#1}{#2}, \citeyear{#1})}
\newcommand\citetzh[2]{\citec{#1}{#2} (\citeyear{#1})}
% 脚注的缩进，在setspace之前使用
\usepackage[hang,flushmargin]{footmisc}
% 设置文章行距，在hypperef前使用
\usepackage{setspace}
% 添加超链接
\usepackage[hidelinks,bookmarksnumbered]{hyperref}
% 脚注回链
\usepackage{footnotebackref}
% 页脚页眉
\usepackage{fancyhdr}
% 默认页面是plain，记得在主文件里设置\thesistitle
\fancypagestyle{plain}{
  \fancyhead[L]{
    \zihao{-5}{\thesistitle}
  }
  \fancyhead[R]{\zihao{-5}{\thepage}}
  \fancyfoot[C]{}
  \renewcommand{\headrulewidth}{0.75pt}
}
\fancypagestyle{head}{
  \fancyhead[L]{}
  \fancyhead[R]{}
  \fancyfoot[C]{\zihao{-5}{- \thepage{} -}}
  \renewcommand{\headrulewidth}{0pt}
}
\pagestyle{plain}

% 目录中标题格式
\usepackage{titletoc}
% 删除“目录”两个字前的空白
\contentsmargin{0cm}
% FIXME: 把一级标题换成英文数字写法
\newcommand\words[1]{\expandafter\xwords\csname c@#1\endcsname}
\def\xwords#1{\ifcase#1\or
One\or
Two\or
Three\or
Four\or
Five\or
Six\else
I need more words\fi}
% 重写正文中的标题数字
\renewcommand\thechapter{\words{chapter}}
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}
\renewcommand\thesubsection{\arabic{chapter}.\arabic{section}.\arabic{subsection}}
% 开始用titletoc修改目录中各级标题的显示
% 参数见chapter的形式或titletoc文档
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

% 重写目录，因为word格式中目录前的空白不是chapter的段前距
% FIXME 在\tableofcontents之前加点空白更好
\renewcommand\tableofcontents{%
    \vspace*{-24pt}{\centering\bfseries\zihao{-2}{\contentsname\\}}\vspace{12pt}
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
    }
% 新建自己创建目录的命令，主要用来修改页数的显示
\newcommand{\mktableofcontents}{
  \clearpage
  %\pagenumbering{roman}
  \thispagestyle{head}
  \pdfbookmark[0]{\contentsname}{contents}
  \tableofcontents
  \clearpage
  \pagenumbering{arabic}
}

% titlesec用来修改正文中各级标题的格式，包括段前距和段后
% FIXME 无法和Word格式一样，因为Word中一个字的高度和这里不一样，导致段前/后距难以确定
% 之后用了环境sectext等弥补
\usepackage{titlesec}
%titleformat{cmd:section}[fmt:see]{fmt:title}{label}{sep}{before}[after]
\titleformat{\chapter}{\centering\bfseries\zihao{-2}}{Chapter \thechapter}{0.5em}{}
%\titlespacing{cmd}{left}{before-sep}{after-sep}[right-sep]
\titlespacing*{\chapter}{0pt}{12pt}{34pt}%FIXME
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

% 致谢页面，在论文中使用，无章节编号
\newcommand{\acknowledgment}{
  \def\ackname{Acknowledgments}
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{\ackname}
  \chapter*{\ackname}
}
% 近似于Word中的1.25倍行距
\renewcommand{\baselinestretch}{1.35}

% 论文的摘要，分中文摘要和英文摘要，新定义环境zh和en
% FIXME 中英文大部分格式是统一的，用命令调用会更容易维护
\newenvironment{abstractzh}[1]{
  \def\keywordszh{#1}
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{摘要}
  \pagenumbering{roman}
  \thispagestyle{head}
  \vspace*{84pt}
  {\centering\heiti\zihao{-2} 摘要\par}
  \vspace*{37pt}\par
  \setstretch{1.6}
  \songti\zihao{-4}
}{
  \vspace*{14pt}\par
  {\heiti\zihao{-4} 关键词：}
  {\songti\zihao{-4} \keywordszh}
}
\newenvironment{abstracten}[1]{
  \def\keywordsen{#1}
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  % \pagenumbering{roman}
  \thispagestyle{head}
  \vspace*{84pt}
  % \pdfbookmark[1]{Abstract}{abstracten}
  {\centering\bfseries\zihao{-2} Abstract\par}
  \vspace*{37pt}\par
  \setstretch{1.6}
  \zihao{-4}
}{
  \vspace*{14pt}\par
  {\bfseries\zihao{-4} Keywords:}
  {\zihao{-4} \keywordsen}
}

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

% FIXME
\newenvironment{text}{\vspace{22pt}}{\vspace{20pt}}
\newcommand\secspacesubsec{\vspace{23pt}}

% 设置脚注的行距、数字和文字的距离
\setlength{\footnotesep}{14pt}
\let\oldfootnote\footnote
\renewcommand\footnote[1]{%
\oldfootnote{\hspace{3pt}#1}}
