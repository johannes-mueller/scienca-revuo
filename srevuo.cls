\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{srevuo}
\newif\ifSR@Author@
\SR@Author@true
\newif\ifSR@Draft@
\newif\ifSR@lineno@
\def\@@title{}
\SR@lineno@false
\newif\ifuse@SR@fonts@
\use@SR@fonts@false
\newif\iffinal@layout@
\final@layout@false
\newread\SR@file
\ProvidesClass{srevuo}

\newif\if@tex@ht@
\@tex@ht@false
% \@tex@ht@true
% \@ifundefined{tex@ht}{\@tex@ht@false}
% \if@tex@ht@
%   \RequirePackage[html,charset=utf-8]{tex4ht}
% \fi
\RequirePackage{etoolbox}
\RequirePackage{ifxetex}
%\RequirePackage{ifluatex}
\ifxetex\else
\ClassError{sr-johmue}{Ĉi momente SR kaj ĝiaj artikoloj nur komposteblas pere de XeLaTeX.}{
     SR estas kompostata per unikodkapabla XeLaTeX. Eble estontece ankaŭ
     LuaLaTeX taŭgos. Ĉi momente ne, ĉar LuaLaTeX ne subtenas la pakaĵon
     polyglossia. pdfLaTeX ne funkcias ĉar biblatex.sty konfliktas kun
     ucs.sty.  Do restas XeLaTeX kiel ununura taŭga kompostilo.
}
\fi
\newcommand*\SR@@thelinenumber{\thepage-\arabic{linenumber}}
%%%%
\PassOptionsToPackage{table}{xcolor}
\PassOptionsToPackage{no-math}{fontspec}
\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{full}{\SR@Author@false\use@SR@fonts@true\final@layout@true}
\DeclareOption{final}{\use@SR@fonts@true\final@layout@true}
\DeclareOption{SRfonts}{\use@SR@fonts@true}
\DeclareOption{draft}{%
  \SR@Draft@true
  \SR@lineno@true
  \PassOptionsToPackage{pagewise}{lineno}%
  \PassOptionsToClass{\CurrentOption}{book}%
}
\DeclareOption{linenumbers}{\SR@lineno@true}
\DeclareOption{nolinenumbers}{\SR@lineno@false}
\DeclareOption{pagewise}{%
  \PassOptionsToPackage{\CurrentOption}{lineno}}
\DeclareOption{running}{%
  \PassOptionsToPackage{\CurrentOption}{lineno}}
\DeclareOption{ln-short}{\def\SR@@thelinenumber{%
  \arabic{linenumber}}}
\ProcessOptions
\ifSR@Author@
  \iffinal@layout@
    \LoadClass[a4paper,DIV12,12pt,twoside]{scrartcl}
  \else
    \LoadClass[a4paper,DIV12,12pt]{scrartcl}
  \fi
\else
%  \LoadClass[a5paper,9pt,DIV15,openany,twoside,toc=left,headings=small]{scrbook}
  \LoadClass[a4paper,12pt,DIV12,openany,twoside,toc=left,headings=small]{scrbook}
%  \LoadClass[b5paper,10pt,DIV14,openany,twoside,toc=left,headings=small]{scrbook}
  \newenvironment{abstract}{}{}
  \RequirePackage{tocstyle}
  \usetocstyle{KOMAlike}
  \settocstylefeature[-1]{entryhook}{\bfseries\sffamily}
  \settocstylefeature{pagenumberhook}{\normalfont}
  \settocstylefeature[-1]{entryvskip}{1em}
  \settocstylefeature[0]{entryvskip}{0.5em}
\fi


\newcommand*{\titol@grize}{\color{black!50!white}}


\ifSR@lineno@
  \RequirePackage{lineno}\linenumbers
  \RequirePackage[table]{xcolor}%
  \linenumbersep=.8ex
  \def\linenumberfont{\normalfont\scriptsize\sffamily\bfseries}%
  \definecolor{SR@lineno@color}{cmyk}{0.26,0,0.76,0}% SpringGreen
  \def\thelinenumber{%
  \begingroup
    \fboxsep=.3ex\fcolorbox{black}{SR@lineno@color}{%
      \SR@@thelinenumber}%
  \endgroup}%
\fi
%%%%%%%%%%

\newcommand\AuthorFont{\normalfont\normalsize\scshape}
\newcommand\SubtitleFont{\large\sffamily}
\newcommand\TitleFont{\usekomafont{sectioning}\Large}

\newcommand\NewpageThreshold{140pt}
\newcommand\HeadRuleDepth{0pt}
\newcommand\FootRuleDepth{0pt}
\newcommand\ContentsParSkip{1pt}


\newcommand{\UsePalatinoOptima}{%
    \RequirePackage{mathpazo}
    \RequirePackage{textcomp}
    \RequirePackage{gensymb}
    \RequirePackage[no-math]{fontspec}
    \setmainfont[%
    Numbers={OldStyle},
    BoldFont = texgyrepagella-bold.otf ,
    ItalicFont = texgyrepagella-italic.otf ,
    BoldItalicFont = texgyrepagella-bolditalic.otf ]
    {texgyrepagella-regular.otf}
    \setsansfont[%
    BoldFont=ZapfHumanist601BT-Bold.otf,BoldItalicFont=ZapfHumanist601BT-BoldItalic.otf,
    ItalicFont=ZapfHumanist601BT-Italic.otf]
    {ZapfHumanist601BT-Roman.otf}
     \setkomafont{sectioning}{%
       \fontspec[
       BoldFont=ZapfHumanist601BT-Demi.otf,
       BoldItalicFont=ZapfHumanist601BT-DemiItalic.otf,
       ItalicFont=ZapfHumanist601BT-Italic.otf]{%
         ZapfHumanist601BT-Roman.otf}
       \bfseries}
     \setkomafont{partentry}{\normalfont\bfseries\sffamily\large}
}
\newcommand{\UseLibertineBiolinum}{%
  \RequirePackage{fontspec}
  \RequirePackage{xunicode}
  \setmainfont[Numbers=OldStyle,BoldFont=fxldr.otf,BoldItalicFont=fxldro.otf,ItalicFont=fxlri.otf]{fxlr.otf}
  \setsansfont[Numbers=OldStyle,BoldFont=fxbb.otf,BoldItalicFont=fxbbo.otf,ItalicFont=fxbri.otf]{fxbr.otf}
  \newcommand{\micro}{µ}
  \setkomafont{sectioning}{\normalfont\sffamily\bfseries}
  \setkomafont{partentry}{\normalfont\sffamily\large}
}
\ifuse@SR@fonts@
  \UsePalatinoOptima
\else
  \RequirePackage{textcomp}
  \RequirePackage{gensymb}
\fi
% \ifxetex
%   \ifboolexpr{bool {SR@Author@} or bool {@tex@ht@}}{%
%     \typeout{uzas tex4ht}
%     \RequirePackage{textcomp}
%     \RequirePackage{gensymb}
%   }{%
%     \typeout{ne uzas tex4ht}
%     \UsePalatinoOptima
%   }
% \else\ifluatex
%   \usepackage{luaotfload}
%   \usepackage{luacode}
%   \usepackage[utf8]{luainputenc}
%\fi
\RequirePackage[verbose=true,final=true]{microtype}
%
%\RequirePackage{fixltx2e}


\RequirePackage{polyglossia}
\RequirePackage{csquotes}
\DeclareQuoteStyle{esperanto}{\textquotedblleft}{\textquotedblright}{\textquoteleft}{\textquoteright}
\setquotestyle{esperanto}
\setdefaultlanguage{esperanto}
\RequirePackage[backend=biber]{biblatex}
\newcommand*{\citewithauthor}[1]{\citeauthor{#1}~\cite{#1}}
\gappto\captionsesperanto{\renewcommand{\figurename}{Bildo}}

\ifSR@Author@\else
  \RequirePackage{graphicx,xspace}
  \RequirePackage[newcommands,newparameters]{ragged2e}
  \RequirePackage{url}
  \RequirePackage{tikz}
  \usetikzlibrary{arrows,snakes,shapes}
\fi
\raggedbottom
\clubpenalty  = 10000
\widowpenalty = 10000

\RequirePackage{pgfplots}
\pgfplotsset{compat=1.4}
\usetikzlibrary{pgfplots.dateplot}

\tikzstyle{every picture}=[>=latex,font=\footnotesize]

\pgfkeys{/pgf/number format/.cd, set thousands separator={}}


\ifSR@Author@
\pgfplotsset{
  every axis/.style={
    width=12.7cm,
    height=9cm,
    legend style={font=\footnotesize},
    tick label style={font=\footnotesize},
    label style={font=\small},
    title style={font=\small},
    every axis title shift=0pt,
    max space between ticks=15,
    every mark/.append style={mark size=8},
    major tick length=0.1cm,
    minor tick length=0.066cm,
    scale=0.9
  }
}
\else
\pgfplotsset{
  every axis/.style={
    width=12.7cm,
    height=9cm,
    legend style={font=},
    tick label style={font=},
    label style={font=\large},
    title style={font=\large},
    every axis title shift=0pt,
    max space between ticks=30,
    every mark/.append style={mark size=8},
    major tick length=0.1cm,
    minor tick length=0.066cm,
    scale=1.41
  },
  label shift={3em},
}
\tikzstyle{every picture}+=[scale=0.707]
\fi

\newcommand{\proton}[1]{%
  \shade[ball color=black!70!white] (#1) circle (.25);\draw (#1) node{$+$};
}
% \neutron{xposition,yposition}
\newcommand{\neutron}[1]{%
  \shade[ball color=black!30!white] (#1) circle (.25);
}
% \electron{xwidth,ywidth,rotation angle}
\newcommand{\electron}[3]{%
  \draw[rotate = #3](0,0) ellipse (#1 and #2)[color=black];
  \shade[ball color=black] (0,#2)[rotate=#3] circle (.1);
}
\newcommand{\nucleus}{%
  \neutron{0.1,0.3}
  \proton{0,0}
  \neutron{0.3,0.2}
  \proton{-0.2,0.1}
  \neutron{-0.1,0.3}
  \proton{0.2,-0.15}
  \neutron{-0.05,-0.12}
  \proton{0.17,0.21}
}
% \paircreation{impact parameter}
\newcommand{\paircreation}[1]{%
  \draw[snake=coil, line after snake=0pt, segment aspect=0,%
  segment length=5pt] (0,#1)-- +(-6,0)%
  node[fill=white,draw=black, above=0.2cm,pos=0.5]%
  {Alvenanta $\gamma$-fotono};%
  \draw[-stealth,black!50!white](0,#1) -- ++ (5,2.5);%
  \shade[ball color=black](0,#1)  --  ++(4,2.0)%
  node[fill=white,draw=black, below right=0.2cm]%
  {Pozitrono} circle(0.1);%
  \draw[-stealth,black!50!white](0,#1) -- ++ (4,-2.0);%
  \shade[ball color=black](0,#1)  --  ++(3.2,-1.6)%
  node[fill=white,draw=black, above right=0.2cm]%
  {Elektrono} circle(0.1);%
}
\newcommand*{\TitlePageArt}{%
  \tiny
  \hfill
  \begin{tikzpicture}[scale=0.7]
    \nucleus
    \electron{1.5}{0.75}{80}
    \electron{1.2}{1.4}{260}
    \electron{4}{2}{30}
    \electron{5}{1}{60}
    \electron{5.5}{1.5}{150}
    \electron{4.8}{2.25}{80}
    \paircreation{1}
  \end{tikzpicture}
  \normalsize
}

\RequirePackage{xspace}
\newcommand*{\ISAE}{ISAE}
\newcommand*{\isae}{ISAE\xspace}
\newcommand*{\RevuTitolo}{Scienca Revuo\xspace}
\newcommand*{\srevuo}{Scienca Revuo\xspace}
\newcommand*{\srevuon}{Sciencan Revuon\xspace}
\newcommand*{\isaelonge}{Internacia Scienca Asocio Esperantista\xspace}
\newcommand*{\doi}{DOI\xspace}

\newcommand*{\volumo@indiko}{Volumo\xspace}
\newcommand*{\numero@indiko}{Numero\xspace}
\newcommand*{\kajero@indiko}{Kajero\xspace}
\newcommand*{\jaro@indiko}{Jaro\xspace}
\newcommand*{\issn}{ISSN 0048-9557}

%\newcommand*{\person}[1]{\textsc{#1}}
\newcommand*{\person}[1]{#1}
\newcommand*{\alilingve}[2]{\textsf{#2}}

\newcommand{\RedakciaNoto}[2][]{
  \def\@@temp{#1}
  \ifx\@@temp\@empty
    \def\@al@{}
  \else
    \def\@al@{\textbf{@#1:}\xspace}
  \fi
  \marginpar{\footnotesize\raggedright\sffamily\@al@#2}
}

\DeclareRobustCommand{\NeEnRevuo}[1]{\ifSR@Author@#1\fi}

\DeclareRobustCommand{\pleneldono}[2]{\ifSR@Author@#2\else#1\fi}


\RequirePackage{picins}
\newcommand\autoro[1][]{%
  \section*{La aŭtoro}
  \def\@@temp{#1}%
  \ifx\@@temp\@empty\else%
    \parpic[r][t]{\includegraphics[width=0.2\textwidth]{\@@temp}}
  \fi
}


\newlength{\part@head@height}
\setlength{\part@head@height}{31pt}
\newlength{\mytemp@l}
\iffinal@layout@
  \RequirePackage{titlesec}
  \newcommand\part@format[1]{%
    \suppressfloats[t]
    \thispagestyle{plain}
    \begingroup
    \flushleft
    \typeout{PART2 \the\pagetotal}
    \noindent\usekomafont{sectioning}{\Huge\titol@grize #1}\hfill
    \normalcolor\par\hfill\rule{\linewidth}{0.4pt}\hfill
    \global\FirstArticletrue
    \endgroup
    \par
  }
  \RequirePackage[manualmark]{scrpage2}
  \setkomafont{pagehead}{\sffamily\itshape}
  \setkomafont{pagefoot}{\sffamily\itshape}
  \setkomafont{pagenumber}{\normalfont}
  %
  \ifoot[\cxi@eldono]{\cxi@eldono}
  \ofoot{\pagemark}
  \pagestyle{scrheadings}
  %
\fi

\addtokomafont{caption}{\footnotesize\sffamily}
\addtokomafont{captionlabel}{\footnotesize\sffamily\bfseries}
\setcapwidth[c]{0.8\textwidth}
\setcapindent{0pt}
\setcounter{secnumdepth}{3}
\newif\ifFirstArticle
\FirstArticletrue
\ifSR@Author@
  \renewcommand{\part}{%
    \typeout{*** Parts can not be used in single articles.}}
\else
\renewcommand\part{\secdef\SR@part\SR@spart}%

\def\SR@part[#1]#2{%
  \def\@@temp{#1}
  \ifx\@@temp\@empty
    \gdef\@@part{#2}
  \else
    \gdef\@@part{#1}
  \fi
  \clearpage
  \phantomsection
  \addcontentsline{toc}{part}{\@@part}
  \part@format{#2}
  \FirstArticletrue
}
\def\SR@spart#1{%
  \gdef\@@part{#1}
  \clearpage
  \phantomsection
  \pdfbookmark[-1]{#1}{section.\the\Hy@linkcounter}
  \part@format{#1}
  \FirstArticletrue
}

\renewcommand{\othersectionlevelsformat}[3]{%
  \arabic{section}%
  \def\@@temp{#1}%
  \ifdefstring{\@@temp}{subsection}{%
    .\arabic{subsection}%
  }{%
    \ifdefstring{\@@temp}{subsubsection}{%
      .\arabic{subsection}.\arabic{subsubsection}%
    }{%
    }%
  }%
  \enskip%
}
\fi

\newcommand{\komencapagxo}[1]{}
\ifSR@Author@\iffinal@layout@
  \renewcommand{\komencapagxo}[1]{\setcounter{page}{#1}}
\fi\fi

\let\orig@title=\title
\renewcommand{\title}[2][]{\orig@title{#2}}
\iffinal@layout@
\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \def\@@temp{#1}%
  \ifx\@@temp\@empty\gdef\@@title{#2}\else\gdef\@@title{#1}\fi}
\newcommand\setup@title{%
  \ifFirstArticle\else\newpage\fi
  \global\FirstArticlefalse
  \begingroup
    \let\footnote\thanks
    \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
    \let\@oldmakefnmark\@makefnmark
    \noindent
    \begin{minipage}{\textwidth}
      \SRtitle@sep
      \raggedright
      \TitleFont\@title\normalfont
      \ifx\@subtitle\@empty\else
        \par\bigskip
        \SubtitleFont\@subtitle\normalfont
      \fi
      \ifx\@author\@empty\else
        \par\bigskip
        \AuthorFont\noindent\@author\par
      \fi
    \end{minipage}%
    \@thanks%
    \let\thanks\@gobble%
  \endgroup
  \setcounter{footnote}0
  \setcounter{figure}0
  \setcounter{table}0
  \setcounter{equation}0
  \setcounter{section}0
  \ifSR@Author@
    \markboth{\@@rubriko}{\@@title}
  \else
    \markboth{\@@part}{\@@title}
  \fi
  \par\medskip
  \@endpefalse\@ignoretrue 
  \aftergroup\@afterindentfalse 
  \aftergroup\@afterheading 
}
\renewcommand{\maketitle}{%
  \Advance@Label@Prefix
  \setcounter{footnote}{0}
  \begingroup
  \setup@title%
  \let\thanks\@gobble%
  \ifSR@Author@\else
    \phantomsection%
    \addcontentsline{toc}{chapter}{\protect\normalfont\protect\normalsize\@@title}%
    \ifx\@author\@empty\else%
      \addtocontents{toc}{\protect\AuthorFont\hspace{2em}\@author\normalfont\endgraf}%
    \fi%
  \fi
  \endgroup%
  \thispagestyle{plain}
  \global\let\@title=\@empty%
  \global\let\@author=\@empty%
  \global\let\@thanks=\@empty%
  \global\let\@subtitle=\@empty
}
\fi
\newcommand{\metaartikolo}[2][]{%
  \title[#1]{#2}
  \let\@author=\@empty
  \setup@title
  \let\@title=\@empty
  \let\@thanks=\@empty
  \let\@subtitle=\@empty
}
\newcommand\SRtitle@sep{\vspace{32pt plus 8pt minus 16pt}}
\renewcommand\and{, }
\let\@title=\@empty
\let\@author=\@empty
\let\@thanks=\@empty
\let\@subtitle=\@empty
\iffinal@layout@
\renewenvironment{abstract}{%
  \par
  \rule{\textwidth}{1pt}
  \begin{quote}\small\sffamily
  \noindent\ignorespaces}{%
  \end{quote}  
  \rule[\baselineskip]{\textwidth}{1pt}
  \par\medskip
  \@endpefalse\@ignoretrue 
  \aftergroup\@afterindentfalse 
  \aftergroup\@afterheading 
}
\fi
\newcommand*{\keywords}[1]{%
  \begin{quote}\small\sffamily
    \noindent\usekomafont{sectioning}{Kapvortoj:} \textit{#1}
  \end{quote}
  \par
  \@endpefalse\@ignoretrue 
  \aftergroup\@afterindentfalse 
  \aftergroup\@afterheading 
}

\renewcommand\thefigure{\arabic{figure}}
\renewcommand\thetable{\arabic{table}}
\renewcommand\theequation{\arabic{equation}}

\newcommand*{\artikoleto}[1]{%
  \usekomafont{sectioning}
  \Large
  \par\vspace{2em}
  \noindent #1
  \normalfont\normalsize
  \par\vspace{1em}
  \@endpefalse\@ignoretrue 
  \@afterindentfalse 
  \@afterheading
}
\newcommand*{\fonto}[1]{\par\medskip\noindent\textit{Fonto:} #1}

\newcommand{\eldono}[1]{}
\newcommand{\rubriko}[1]{}
\newcommand{\cxi@eldono}{Scienca Revuo x/xxxx}
\define@key{eldono}{volumo}{\def\@volumo{#1}}
\define@key{eldono}{kajero}{\def\@kajero{#1}}
\define@key{eldono}{numero}{\def\@numero{#1}}
\define@key{eldono}{jaro}{\def\@jaro{#1}}
\ifSR@Author@
  \renewcommand{\eldono}[1]{%
    \setkeys{eldono}{#1}
    \renewcommand{\cxi@eldono}{Scienca Revuo \@kajero /\@jaro}
  }
  \renewcommand{\rubriko}[1]{\global\def\@@rubriko{#1}}
\else
  \newcommand\SciencaRevuoTitolo[1]{%
    \thispagestyle{empty}
    \setkeys{eldono}{#1}
    \begingroup
    \hfill\bgroup\fontsize{54}{54}\selectfont\titol@grize\sffamily\ISAE\egroup
    \par\vspace{\baselineskip}
    \hfill\textsf{\small\isaelonge}
    \par
    \hfill\rule{0.66\textwidth}{0.4pt}
    \par\vspace{0.2\textheight}
    \hfill\usekomafont{sectioning}{\Huge\RevuTitolo}
    \par\normalsize\vspace{\baselineskip}
    \hfill\volumo@indiko\@volumo\hspace{2em}\kajero@indiko\@kajero\hspace{2em}
    \numero@indiko\@numero\hspace{2em}
    \jaro@indiko\@jaro
    \vfill
    \hfill\TitlePageArt
    \vfill
    \normalfont
    \hfill\sffamily\fontsize{54}{54}\selectfont\titol@grize\@kajero /\@jaro
    \normalfont\normalsize
    \newpage
    \endgroup
    \renewcommand{\cxi@eldono}{Scienca Revuo \@kajero /\@jaro}
  }
\fi

\ifSR@Author@
  \renewcommand\tableofcontents{%
    \typeout{*** tabelofcontents not supported in articles.}}
\else
  \renewcommand\tableofcontents{%
    \clearpage
    \hypertarget{toc}{}
    \pdfbookmark[-1]{\contentsname}{toc}
    \thispagestyle{empty}%
    \markboth{\contentsname}{\contentsname}%
    \ContentsArt
    \vspace{2em}
    \@starttoc{toc}
  }
\fi
\newcommand\ContentsArt{%
  \raggedright
  \part@format{\contentsname}
  \footnotesize\sffamily
  \issn
  \hfill 
  \volumo@indiko\@volumo\xspace$\cdot$
  \numero@indiko\@numero\xspace$\cdot$
  \kajero@indiko\@kajero /\@jaro
  \normalsize
  \par
}
\ifSR@Author@
  \setcounter{tocdepth}{2}
\else
  \setcounter{tocdepth}{0}
\fi


\pdfpagewidth\paperwidth\pdfpageheight\paperheight


\newcommand*\SR@embedded@documentclasshook{}
\newcommand*\AtEmbeddedDocumentclass{%
  \g@addto@macro\SR@embedded@documentclasshook}
\AtEmbeddedDocumentclass{%
      \edef\jobname{\SR@local@jobname}%
}
\newcommand*\SR@embedded@begindocumenthook{}
\newcommand*\AtEmbeddedBeginDocument{%
  \g@addto@macro\SR@embedded@begindocumenthook}
\AtEmbeddedBeginDocument{}
\newcommand*\SR@embedded@enddocumenthook{}
\newcommand*\AtEmbeddedEndDocument{%
  \g@addto@macro\SR@embedded@enddocumenthook}
\AtEmbeddedEndDocument{\endinput}
\newcommand*\SR@jobname{}
\ifSR@Author@\edef\SR@jobname{komoedie}\else\edef\SR@jobname{\jobname}\fi
\newcommand*\SR@local@jobname{}
\newcommand*\SR@local@inputname{}
%%%\newcommand*\SR@PSforPDF{}
\newcommand*\SR@eat@version[1][]{\ignorespaces}
\newcommand*\SR@usepackage{}
\newcommand*\SRinput[1]{%
  \begingroup
     \filename@parse{#1}%
     \edef\SR@local@jobname{\filename@base}%
     \@ifundefined{filename@ext}%
     {\IfFileExists{\SR@local@jobname.ltx}%
       {\edef\SR@local@inputname{\SR@local@jobname.ltx}}%
       {\edef\SR@local@inputname{\SR@local@jobname.tex}}%
     }%
     {\edef\SR@local@inputname{#1}}%
    \renewcommand*\documentclass[2][]{%
      \SR@embedded@documentclasshook
      \SR@eat@version}%
    \renewcommand*\usepackage[2][]{}
    \let\pagestyle\@gobble
    \let\thispagestyle\@gobble
    \let\listfiles\relax
    \let\nofiles\relax
    \renewcommand*\AtBeginDocument[1]{%
       \typeout{\string\AtBeginDocument\space ignored!}}
    \renewcommand*\AtEndDocument[1]{%
       \typeout{\string\AtEndDocument\space ignored!}}
    \renewenvironment*{document}%
    {\SR@embedded@begindocumenthook}%
    {\SR@embedded@enddocumenthook}%
    \renewcommand*{\bibliography}[1]{\newrefsection[#1]}
    \input{\SR@local@inputname}%
  \endgroup
}

\ifSR@Author@\else
\input{extended_preamble}
\fi

\iffinal@layout@
\defbibheading{bibliography}[\bibname]{\section*{#1}}
\fi

\RequirePackage{url}
\newcommand{\EMail}[1]{\protect\url{#1}}
\iffinal@layout@
  \RequirePackage[bookmarksopen=true,linktocpage]{hyperref}
  \hypersetup{%
    colorlinks,
    citecolor={{green!50!black}},
    linkcolor={{blue!80!black}},
    pdfpagelayout=TwoPageRight
  }
  \renewcommand{\EMail}[1]{\href{mailto:#1}{\protect\url{#1}}}
\fi


\AtBeginDocument{%
  %%%\edef\SR@jobname{\jobname}%
  %%%\edef\PfP@container{\SR@jobname-pics.pdf}%
  % RN 2005-03-21
  \@ifpackageloaded{lineno}{%
    \ifSR@Draft@\else
      \nolinenumbers
    \fi
  }{}
}

%\RequirePackage{booktabs}
%\RequirePackage{array}
%\RequirePackage{terminaro}

\RequirePackage{array}
\RequirePackage[table]{xcolor}
\RequirePackage{calc}
\RequirePackage{booktabs}
\rowcolors{2}{white}{black!10!white}
\setlength{\extrarowheight}{4pt}

\RequirePackage{subfig}

\RequirePackage{cleveref}
\newcount\SR@label
\SR@label=0
\newcommand\Advance@Label@Prefix{%
  \global\advance\SR@label by 1
  \xdef\Label@Prefix{artikolo-\the\SR@label:}
}
\Advance@Label@Prefix
\let\Ref=\ref
\let\Label=\label
\let\Pageref=\pageref
\ifSR@Author@\else
\AtBeginDocument{%
  \renewcommand\ref[1]{\Ref{\Label@Prefix:#1}}
  \let\Label=\label
  \renewcommand{\label}[2][\@empty]{%
    \ifx #1\@empty%
      \Label{\Label@Prefix:#2}%
    \else%
      \Label[#1]{\Label@Prefix:#2}%
    \fi%
  }%
  \let\SR@old@cref=\@cref
  \def\@cref#1#2{\SR@old@cref{#1}{\Label@Prefix:#2}}
  \@ifpackageloaded{amsmath}{%
    \let\SR@old@label=\cref@label
    \def\cref@label#1{\SR@old@label{\Label@Prefix:#1}}
  }{}
  \renewcommand\pageref[1]{\Pageref{\Label@Prefix:#1}}
}
\fi

\AtBeginDocument{%
  \def\crefrangeconjunction@preamble{ ĝis\nobreakspace}%
  \def\crefrangepreconjunction@preamble{}%
  \def\crefrangepostconjunction@preamble{}%
  \def\crefpairconjunction@preamble{ kaj\nobreakspace}%
  \def\crefmiddleconjunction@preamble{, }%
  \def\creflastconjunction@preamble{ kaj\nobreakspace}%
  \def\crefpairgroupconjunction@preamble{ kaj\nobreakspace}%
  \def\crefmiddlegroupconjunction@preamble{, }%
  \def\creflastgroupconjunction@preamble{ kaj\nobreakspace}%
  \Crefname@preamble{equation}{Ekvacio}{Ekvacioj}%
  \Crefname@preamble{part}{Parto}{Partoj}%
  \Crefname@preamble{chapter}{Ĉapitro}{Ĉapitroj}%
  \Crefname@preamble{section}{Sekcio}{Sekcioj}%
  \Crefname@preamble{appendix}{Aldono}{Aldonoj}%
  \Crefname@preamble{enumi}{Punkto}{Punktoj}%
  \Crefname@preamble{footnote}{Piednoto}{Piednotoj}%
  \Crefname@preamble{figure}{Bildo}{Bildoj}%
  \Crefname@preamble{table}{Tabelo}{Tabeloj}%
  \Crefname@preamble{theorem}{Teoremo}{Teoremoj}%
  \Crefname@preamble{lemma}{Lemo}{Lemoj}%
  \Crefname@preamble{corollary}{Korolario}{Korolarioj}%
  \Crefname@preamble{proposition}{Propozicio}{Propozicioj}%
  \Crefname@preamble{definition}{Defino}{Definoj}%
  \Crefname@preamble{result}{Rezulto}{Rezultoj}%
  \Crefname@preamble{example}{Ekzemplo}{Ekzemploj}%
  \Crefname@preamble{remark}{Rimarko}{Rimarkoj}%
  \Crefname@preamble{note}{Noto}{Notoj}%
  \Crefname@preamble{algorithm}{Algoritmo}{Algoritmoj}%
  \Crefname@preamble{listing}{Listado}{Listadoj}%
  \Crefname@preamble{line}{Linio}{Linioj}%
  \if@cref@capitalise%
  \crefname@preamble{equation}{Ekvacio}{Ekvacioj}%
  \crefname@preamble{part}{Parto}{Partoj}%
  \crefname@preamble{chapter}{Ĉapitro}{Ĉapitroj}%
  \crefname@preamble{section}{Sekcio}{Sekcioj}%
  \crefname@preamble{appendix}{Aldono}{Aldonoj}%
  \crefname@preamble{enumi}{Punkto}{Punktoj}%
  \crefname@preamble{footnote}{Piednoto}{Piednotoj}%
  \crefname@preamble{figure}{Bildo}{Bildoj}%
  \crefname@preamble{table}{Tabelo}{Tabeloj}%
  \crefname@preamble{theorem}{Teoremo}{Teoremoj}%
  \crefname@preamble{lemma}{Lemo}{Lemoj}%
  \crefname@preamble{corollary}{Korolario}{Korolarioj}%
  \crefname@preamble{proposition}{Propozicio}{Propozicioj}%
  \crefname@preamble{definition}{Defino}{Definoj}%
  \crefname@preamble{result}{Rezulto}{Rezultoj}%
  \crefname@preamble{example}{Ekzemplo}{Ekzemploj}%
  \crefname@preamble{remark}{Rimarko}{Rimarkoj}%
  \crefname@preamble{note}{Noto}{Notoj}%
  \crefname@preamble{algorithm}{Algoritmo}{Algoritmoj}%
  \crefname@preamble{listing}{Listado}{Listadoj}%
  \crefname@preamble{line}{Linio}{Linioj}%
  \else%
  \crefname@preamble{equation}{ekvacio}{ekvacioj}%
  \crefname@preamble{part}{parto}{partoj}%
  \crefname@preamble{chapter}{ĉapitro}{ĉapitroj}%
  \crefname@preamble{section}{sekcio}{sekcioj}%
  \crefname@preamble{appendix}{aldono}{aldonoj}%
  \crefname@preamble{enumi}{punkto}{punktoj}%
  \crefname@preamble{footnote}{piednoto}{piednotoj}%
  \crefname@preamble{figure}{bildo}{bildoj}%
  \crefname@preamble{table}{tabelo}{tabeloj}%
  \crefname@preamble{theorem}{teoremo}{teoremoj}%
  \crefname@preamble{lemma}{lemo}{lemoj}%
  \crefname@preamble{corollary}{korolario}{korolarioj}%
  \crefname@preamble{proposition}{propozicio}{propozicioj}%
  \crefname@preamble{definition}{defino}{definoj}%
  \crefname@preamble{result}{rezulto}{rezultoj}%
  \crefname@preamble{example}{ekzemplo}{ekzemploj}%
  \crefname@preamble{remark}{rimarko}{rimarkoj}%
  \crefname@preamble{note}{noto}{notoj}%
  \crefname@preamble{algorithm}{algoritmo}{algoritmoj}%
  \crefname@preamble{listing}{listado}{listadoj}%
  \crefname@preamble{line}{linio}{linioj}%
  \fi%
  \def\cref@language{esperanto}%
  \renewcommand{\crefrangeconjunction}{ ĝis\nobreakspace}%
  \renewcommand{\crefrangepreconjunction}{}%
  \renewcommand{\crefrangepostconjunction}{}%
  \renewcommand{\crefpairconjunction}{ kaj\nobreakspace}%
  \renewcommand{\crefmiddleconjunction}{, }%
  \renewcommand{\creflastconjunction}{ kaj\nobreakspace}%
  \renewcommand{\crefpairgroupconjunction}{ kaj\nobreakspace}%
  \renewcommand{\crefmiddlegroupconjunction}{, }%
  \renewcommand{\creflastgroupconjunction}{ kaj\nobreakspace}%
  \Crefname{equation}{Ekvacio}{Ekvacioj}%
  \Crefname{part}{Parto}{Partoj}%
  \Crefname{chapter}{Ĉapitro}{Ĉapitroj}%
  \Crefname{section}{Sekcio}{Sekcioj}%
  \Crefname{appendix}{Aldono}{Aldonoj}%
  \Crefname{enumi}{Punkto}{Punktoj}%
  \Crefname{footnote}{Piednoto}{Piednotoj}%
  \Crefname{figure}{Bildo}{Bildoj}%
  \Crefname{table}{Tabelo}{Tabeloj}%
  \Crefname{theorem}{Teoremo}{Teoremoj}%
  \Crefname{lemma}{Lemo}{Lemoj}%
  \Crefname{corollary}{Korolario}{Korolarioj}%
  \Crefname{proposition}{Propozicio}{Propozicioj}%
  \Crefname{definition}{Defino}{Definoj}%
  \Crefname{result}{Rezulto}{Rezultoj}%
  \Crefname{example}{Ekzemplo}{Ekzemploj}%
  \Crefname{remark}{Rimarko}{Rimarkoj}%
  \Crefname{note}{Noto}{Notoj}%
  \Crefname{algorithm}{Algoritmo}{Algoritmoj}%
  \Crefname{listing}{Listado}{Listadoj}%
  \Crefname{line}{Linio}{Linioj}%
  \if@cref@capitalise%
  \crefname{equation}{Ekvacio}{Ekvacioj}%
  \crefname{part}{Parto}{Partoj}%
  \crefname{chapter}{Ĉapitro}{Ĉapitroj}%
  \crefname{section}{Sekcio}{Sekcioj}%
  \crefname{appendix}{Aldono}{Aldonoj}%
  \crefname{enumi}{Punkto}{Punktoj}%
  \crefname{footnote}{Piednoto}{Piednotoj}%
  \crefname{figure}{Bildo}{Bildoj}%
  \crefname{table}{Tabelo}{Tabeloj}%
  \crefname{theorem}{Teoremo}{Teoremoj}%
  \crefname{lemma}{Lemo}{Lemoj}%
  \crefname{corollary}{Korolario}{Korolarioj}%
  \crefname{proposition}{Propozicio}{Propozicioj}%
  \crefname{definition}{Defino}{Definoj}%
  \crefname{result}{Rezulto}{Rezultoj}%
  \crefname{example}{Ekzemplo}{Ekzemploj}%
  \crefname{remark}{Rimarko}{Rimarkoj}%
  \crefname{note}{Noto}{Notoj}%
  \crefname{algorithm}{Algoritmo}{Algoritmoj}%
  \crefname{listing}{Listado}{Listadoj}%
  \crefname{line}{Linio}{Linioj}%
  \else%
  \crefname{equation}{ekvacio}{ekvacioj}%
  \crefname{part}{parto}{partoj}%
  \crefname{chapter}{ĉapitro}{ĉapitroj}%
  \crefname{section}{sekcio}{sekcioj}%
  \crefname{appendix}{aldono}{aldonoj}%
  \crefname{enumi}{punkto}{punktoj}%
  \crefname{footnote}{piednoto}{piednotoj}%
  \crefname{figure}{bildo}{bildoj}%
  \crefname{table}{tabelo}{tabeloj}%
  \crefname{theorem}{teoremo}{teoremoj}%
  \crefname{lemma}{lemo}{lemoj}%
  \crefname{corollary}{korolario}{korolarioj}%
  \crefname{proposition}{propozicio}{propozicioj}%
  \crefname{definition}{defino}{definoj}%
  \crefname{result}{rezulto}{rezultoj}%
  \crefname{example}{ekzemplo}{ekzemploj}%
  \crefname{remark}{rimarko}{rimarkoj}%
  \crefname{note}{noto}{notoj}%
  \crefname{algorithm}{algoritmo}{algoritmoj}%
  \crefname{listing}{listado}{listadoj}%
  \crefname{line}{linio}{linioj}%
  \fi%
}

\endinput
%%
%% End of file `dtk.cls'.
