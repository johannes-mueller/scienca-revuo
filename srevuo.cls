%%   $Id: dtk.cls 24 2011-07-24 13:05:39Z herbert $
%%
%% This is file `dtk.cls',
%%
%% LaTeX Class for ``Die TeXnische Komoedie''.
%%
%% Copyright (C) 1995-1996 Gerd Neugebauer
%% Copyright (C) 1997-2011 DANTE, Deutschsprachige
%%                                Anwendervereinigung TeX e.V.
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{srevuo}
\newif\ifSR@Author@
\SR@Author@true
\newif\ifSR@Draft@
\newif\ifSR@lineno@
\def\@@title{}
\SR@lineno@false
\ifx\documentclass\@undefined
  \newcommand\RequirePackage[1]{
    \chardef\SR@cat=\the\catcode`\@
    \catcode`\@=11
    \input{#1.sty}%
    \catcode`\@=\SR@cat}
  \let\LoadClass=\RequirePackage
  \newcommand\InputIfFileExists[3]{%
    \openin\SR@file #1
    \ifeof\SR@file\closein\SR@file #3%
    \else\closein\SR@file #2\input{#1}%
    \fi}
  \newcommand\DeclareOption{\@ifstar{\@gobble}{\SR@DeclareOption}}
  \newcommand\SR@DeclareOption[2]{\@namedef{ds@#1}{#2}}
  \let\ProcessOptions=\relax
  \let\OptionNotUsed=\gobble
  \def\ProvidesClass#1[#2]{\typeout{Document Style #1 #2}}
  \newcommand\emph[1]{{\em #1}\/}
  \newcommand\textbf[1]{{\bf #1}}
  \newcommand\textrm[1]{{\rm #1}}
  \newcommand\textsc[1]{{\sc #1}}
  \newcommand\textsf[1]{{\sf #1}}
  \newcommand\textsl[1]{{\sl #1\/}}
  \newcommand\textit[1]{{\it #1\/}}
  \newcommand\texttt[1]{{\tt #1}}

  \@ifundefined{fontshape}{\let\fontshape=\@gobble}{}
  \@ifundefined{selectfont}{\let\selectfont=\relax}{}

  \newcommand\providescommand[2]{\ifx#1\@undefined\newcommand#1{#2}\fi}
\fi
\newread\SR@file
\ProvidesClass{srevuo}
\newcommand\SR@isnum[1]{%
  \if!\ifnum9<1#1!\else_\fi
      \expandafter\@firstoftwo
  \else
      \expandafter\@secondoftwo
  \fi
}
\newcommand*\SR@@thelinenumber{\thepage-\arabic{linenumber}}
%%%%
\PassOptionsToPackage{table}{xcolor}
\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{full}{\SR@Author@false}
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
\DeclareOption{ln-long}{\def\SR@@thelinenumber{%
  %\def\Hugo{%
  \ifoddNumberedPage% eigtl. Even!!!
    \ifodd\c@page
      \@tempswatrue %C
    \else
      \@tempswafalse %D
    \fi
  \else
    \ifodd\c@page
      \@tempswafalse %A
    \else
      \@tempswatrue %B
    \fi
  \fi
  %}\Hugo
  %\@tempcnta=\c@page
  %\if@tempswa \advance\@tempcnta\@ne \fi
  \if@tempswa \advance\c@page\@ne \fi
  %\edef\thepage{\the\@tempcnta}%
  \thepage-\arabic{linenumber}}}
\DeclareOption{ln-short}{\def\SR@@thelinenumber{%
  \arabic{linenumber}}}
\DeclareOption*{%
  \SR@isnum{\CurrentOption}%
    {\edef\SR@layout{\CurrentOption}}%
    {%
      \ifSR@Author@
        \PassOptionsToClass{\CurrentOption}{scrartcl}
      \else
        \PassOptionsToClass{\CurrentOption}{scrbook}
      \fi
    }%
}
\ProcessOptions
\ifSR@Author@
  \LoadClass[a4paper,DIV12,12pt]{scrartcl}
\else
  \LoadClass[a5paper,10pt,DIV14,openany,toc=left,headings=small]{scrbook}
\fi


\newcommand*{\titol@grize}{\color{black!50!white}}

\RequirePackage{url}
\newcommand{\EMail}[1]{\protect\url{#1}}

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

\newcommand\AuthorFont{\normalsize\scshape}
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
    % BoldFont=ZapfHumanist601BT-Bold.otf,BoldItalicFont=ZapfHumanist601BT-BoldItalic.otf,
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
  \RequirePackage{xunicode,xltxtra}
  \setmainfont[Numbers=OldStyle,BoldFont=fxldr.otf,BoldItalicFont=fxldro.otf,ItalicFont=fxlri.otf]{fxlr.otf}
  \setsansfont[Numbers=OldStyle,BoldFont=fxbb.otf,BoldItalicFont=fxbbo.otf,ItalicFont=fxbri.otf]{fxbr.otf}
  \newcommand{\micro}{µ}
  \setkomafont{sectioning}{\normalfont\sffamily\bfseries}
  \setkomafont{partentry}{\normalfont\sffamily\large}
}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\ifxetex
  \ifSR@Author@\else\UsePalatinoOptima\fi
\else\ifluatex
%  \RequirePackage[no-math]{fontspec}
  %\RequirePackage{fontspec}
  \usepackage{luaotfload}
%  \RequirePackage{unicode-math}  
 %  \setmathfont[range={"0000-"FFFF,
 %                    \mathup,\mathbfup,
 %                    \mathit,\mathbfit,
 %                    \mathsfup,\mathbfsfup,
 %                    \mathsfit,\mathbfsfit,
 %                    \mathbb,\mathit,
 %                    \mathbbit,
 %                    \mathscr,\mathbfscr,
 %                    \mathfrak,\mathbffrak}]{Latin Modern Math}
 % \setmathfont[math-style=TeX,
 %                 bold-style=TeX,
 %                 range={\mathcal,\mathbfcal},
 %                 StylisticSet=1]{Latin Modern Math} 
 % \setmathrm[ItalicFont=LMRoman10-Italic,
 %            BoldItalicFont=LMRoman10-BoldItalic]{Latin Modern Math}
 % \setmathsf{Latin Modern Math}
 % \setmathtt{Latin Modern Math}
 % \setboldmathrm{Latin Modern Math}
  \usepackage{luacode}
%  \usepackage[utf8]{luainputenc}
\else
   \ClassError{sr-johmue}{pdfTeX ne eblas pro unikodo.}{Vi devas uzi aŭ XeTeX aŭ LuaTeX.}
\fi\fi
\RequirePackage[verbose=true,final=true]{microtype}
%
\RequirePackage{fixltx2e}
\RequirePackage{polyglossia}
\RequirePackage{csquotes}
\DeclareQuoteStyle{esperanto}{\textquotedblleft}{\textquotedblright}
{\textquoteleft}{\textquoteright}
\setquotestyle{esperanto}
\setdefaultlanguage{esperanto}
\RequirePackage[backend=biber]{biblatex}
\newcommand*{\citewithauthor}[1]{\citeauthor{#1}~\cite{#1}}
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
    {Positrono} circle(0.1);%
    \draw[-stealth,black!50!white](0,#1) -- ++ (4,-2.0);%
    \shade[ball color=black](0,#1)  --  ++(3.2,-1.6)%
    node[fill=white,draw=black, above right=0.2cm]%
    {Electrono} circle(0.1);%
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

\newcommand*{\person}[1]{\textsc{#1}}
\newcommand*{\alilingve}[2]{\textit{#2}}


\newlength{\part@head@height}
\setlength{\part@head@height}{31pt}
\newlength{\mytemp@l}
\ifSR@Author@\else
  \RequirePackage{titlesec}
  \newcommand\part@format[1]{%
    \clearpage
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
  \titleformat{\part}{\normalfont}{}{0pt}{\part@format}
  \titleformat{name=\part,numberless=true}[display]{}{}{0pt}{\part@fomat}{}
  \titlespacing*{\part}{0pt}{0pt}{0pt}
  %
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
  \renewcommand\part{%
    \typeout{*** Parts can not be used in single articles.}}
\else
\renewcommand\part[2][]{%
  \part@format{#2}
  \def\@@temp{#1}
  \ifx\@@temp\@empty
    \gdef\@@part{#2}
  \else
    \gdef\@@part{#1}
  \fi
  \addcontentsline{toc}{part}{\@@part}
}
\fi

\renewcommand*{\othersectionlevelsformat}[3]{%
  \def\@temp{section}%
  \def\@@temp{#1}%
  \ifx\@@temp\@temp%
    \arabic{section}
  \else
    \def\@temp{subsection}%
    \ifx\@@temp\@temp%
      \arabic{section}.\arabic{subsection}
    \else
      \def\@temp{subsubsection}%
      \ifx\@@temp\@temp%
        \arabic{section}.\arabic{subsection}.\arabic{subsubsection}
      \fi
    \fi
  \fi
  \autodot\enskip
}

\newcommand\keywords[1]{\def\SR@keywords{#1}}
\def\SR@keywords{}
  \let\orig@title=\title
  \renewcommand{\title}[2][]{\orig@title{#2}}
\ifSR@Author@\else
\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \def\@@temp{#1}%
  \ifx\@@temp\@empty\gdef\@@title{#2}\else\gdef\@@title{#1}\fi}
\newcommand\setup@title{%
  \begingroup
    \dimen0=\vsize
    \advance\dimen0 by -\pagetotal
    \ifdim\dimen0<\NewpageThreshold
      \newpage
      \global\FirstArticletrue
    \fi
  \endgroup
  \Advance@Label@Prefix%
  \begingroup
    \noindent
    \begin{minipage}{\textwidth}
      \SRtitle@sep
      \setcounter{footnote}0
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
  \setcounter{figure}0
  \setcounter{table}0
  \setcounter{equation}0
  \setcounter{section}0
  \markboth{\@@part}{\@@title}
  \par\medskip
  \@endpefalse\@ignoretrue 
  \aftergroup\@afterindentfalse 
  \aftergroup\@afterheading 
}
\renewcommand{\maketitle}{%
  \begingroup
  \setup@title%
  \let\thanks\@gobble%
  \ifx\@author\@empty\else%
     \addcontentsline{toc}{chapter}{%
       \normalfont\@@title\newline\AuthorFont\@author%
     }%
  \fi%
  \endgroup%
  \let\@title=\@empty%
  \let\@author=\@empty%
  \let\@thanks=\@empty%
}
\fi
\newcommand{\metaartikolo}[2][]{%
  \title[#1]{#2}
  \let\@author=\@empty
  \setup@title
  \let\@title=\@empty
  \let\@thanks=\@empty
}
\newcommand\SRtitle@sep{\vspace{32pt plus 8pt minus 16pt}}
\renewcommand\and{, }
\let\@title=\@empty
\let\@author=\@empty
\let\@thanks=\@empty
\ifSR@Author@\else
\newenvironment{abstract}{%
  \par\medskip
  \begin{quote}\small\sffamily
    }{%
  \end{quote}
  \par\bigskip
  \@endpefalse\@ignoretrue 
  \aftergroup\@afterindentfalse 
  \aftergroup\@afterheading 
}
\fi
\renewcommand\thefigure{\arabic{figure}}
\renewcommand\thetable{\arabic{table}}
\renewcommand\theequation{\arabic{equation}}
\newcount\DTL@label
\DTL@label=0
\newcommand\Advance@Label@Prefix{%
  \advance\DTL@label 1
  \xdef\Label@Prefix{module \the\DTL@label:}}
\Advance@Label@Prefix
\let\Ref=\ref
\let\Label=\label
\let\Pageref=\pageref
\ifSR@Author@\else
  \renewcommand\ref[1]{\Ref{\Label@Prefix:#1}}
  \renewcommand\label[1]{\Label{\Label@Prefix:#1}}
  \renewcommand\pageref[1]{\Pageref{\Label@Prefix:#1}}
\fi

\ifSR@Author@\else
  \newcommand{\cxi@eldono}{Scienca Revuo x/xxxx}
  \define@key{titolpagxo}{volumo}{\def\@volumo{#1}}
  \define@key{titolpagxo}{kajero}{\def\@kajero{#1}}
  \define@key{titolpagxo}{numero}{\def\@numero{#1}}
  \define@key{titolpagxo}{jaro}{\def\@jaro{#1}}
  \newcommand\SciencaRevuoTitolo[1]{%
    \thispagestyle{empty}
    \setkeys{titolpagxo}{#1}
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



%\ifSR@Author@\else
% \RequirePackage{multicol}
% \newcommand{\addressname}{La Aŭtoroj}
% \newenvironment{theaddresses}{%
%   \chapter{\addressname}\Label{addresses}
%   \begingroup
%     \columnsep=10pt
%     \addresssize
%     \def\addressitem##1##2##3{%
%       \par
%       \parbox{\columnwidth}{
%       \textbf{##1}\hfill[\ignorespaces ##3]%
%       \\ ##2}}
%     \begin{multicols}{2}%
%       \raggedbottom
%       \raggedright
% }{%
%     \end{multicols}%
%   \endgroup
%   }
% \fi
% \newcommand\addresssize{\footnotesize\parskip=6pt plus 2pt minus 3pt}
% \ifSR@Author@
%   \newcommand\listofaddresses{%
%     \typeout{*** listofaddresses not supported in articles.}}
%   \let\makeaddresses\relax% RN 2005-01-15
% \else
%   \newcommand\listofaddresses{%
%     \InputIfFileExists{\jobname.gls}{}{%
%       \typeout{No file \jobname.gls.}%
%       \typeout{Use the following command to create it:^^J%
%         \@spaces makeindex -s dtk.ist -o \jobname.gls \jobname.glo}%
%       \typeout{\space}}%
%   }
%   \let\makeaddresses\makeglossary
%\fi



\ifSR@Author@
  \renewcommand\tableofcontents{%
    \typeout{*** tabelofcontents not supported in articles.}}
\else
  \renewcommand\tableofcontents{%
    \clearpage
    \thispagestyle{empty}%
    \markboth{\contentsname}{\contentsname}%
    \ContentsArt
    \@starttoc{toc}
  }
\fi
\newcommand\ContentsArt{%
  \raggedright
  \part@format{\contentsname}
  %\vspace{-\baselineskip}
  \hfill \footnotesize\sffamily
  \volumo@indiko\@volumo\xspace$\cdot$
  \numero@indiko\@numero\xspace$\cdot$
  \kajero@indiko\@kajero /\@jaro
  \normalsize
  \par
}
\setcounter{tocdepth}{0}


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
%    \let\pagestyle\@gobble
    \let\thispagestyle\@gobble
    \let\nocite\@gobble
    \let\listfiles\relax
    \let\nofiles\relax
    \renewcommand*\AtBeginDocument[1]{%
       \typeout{\string\AtBeginDocument\space ignored!}}
    \renewcommand*\AtEndDocument[1]{%
       \typeout{\string\AtEndDocument\space ignored!}}
    \renewenvironment*{document}%
    {\SR@embedded@begindocumenthook}%
    {\SR@embedded@enddocumenthook}%
    \renewcommand*{\bibliography}[1]{}
    \newrefsection
    \input{\SR@local@inputname}%
  \endgroup
}

\ifSR@Author@\else
\input{extended_preamble}
\defbibheading{bibliography}[\bibname]{\section*{#1}}
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

\DeclareRobustCommand{\NeEnRevuo}[1]{\ifSR@Author@#1\fi}

\newcommand{\RedakciaNoto}[2][]{
  \def\@@temp{#1}
  \ifx\@@temp\@empty
    \def\@al@{}
  \else
    \def\@al@{\textbf{@#1:}\xspace}
  \fi
  \marginpar{\footnotesize\raggedright\sffamily\@al@#2}
}

\RequirePackage{picins}
\newcommand\autoro[1][]{%
  \section*{La aŭtoro}
  \def\@@temp{#1}%
  \ifx\@@temp\@empty\else%
    \parpic[r][t]{\includegraphics[width=0.2\textwidth]{\@@temp}}
  \fi
}

\RequirePackage{terminaro}

\endinput
%%
%% End of file `dtk.cls'.
