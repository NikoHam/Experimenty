% experiment.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{experiment}[2025/09/04 Třída pro experimenty]

\LoadClass[a4paper,12pt]{article}

\RequirePackage{lipsum}

% --- podpora chemických vzorců ---
\RequirePackage[version=4]{mhchem}
\RequirePackage{siunitx}

% --- jazyk a fonty ---
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[czech]{babel}
\RequirePackage[scaled=0.95]{helvet}
\renewcommand{\familydefault}{\sfdefault}
\RequirePackage{microtype}

% --- rozvržení a barvy ---
\RequirePackage{geometry}
\geometry{margin=18mm}
\RequirePackage{xcolor}
\definecolor{myblue}{RGB}{0,159,227}
\definecolor{myred}{RGB}{227,6,19}
\definecolor{gridblue}{RGB}{210,235,248}

% --- kreslení a rámečky ---
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage[most]{tcolorbox}

% mřížkované pozadí co kurva nefnguje??
\RequirePackage{eso-pic}
\AddToShipoutPictureBG*{%
  \begin{tikzpicture}[remember picture,overlay]
    \draw[step=5mm, line width=0.2pt, draw=gridblue]
      ($(current page.north west)+(10mm,-10mm)$) rectangle
      ($(current page.south east)+(-10mm,10mm)$);
  \end{tikzpicture}%
}

% --- rating ---
\newcommand{\rating}[3][myred]{%
  \begingroup
  \tikzset{baseline=-0.5ex}
  \foreach \i in {1,...,#3}{%
    \ifnum\i>#2
      \tikz{\draw (0,0) circle (0.18cm);}%
    \else
      \tikz{\fill[#1] (0,0) circle (0.18cm);}%
    \fi
    \hspace{0.18cm}%
  }%
  \endgroup
}

% --- pillboxy s nadpisem---
\tcbset{
  bubble/.style={
    enhanced, boxrule=0.9pt, colback=white,
    borderline={0.9pt}{0pt}{#1},
    arc=8pt, left=8pt, right=8pt, top=7pt, bottom=7pt,
    before skip=10pt, after skip=10pt
  },
  bubbletitle/.style={
    fonttitle=\bfseries\large, title filled,
    coltitle=white, boxed title style={
      colback=#1, colframe=#1, arc=10pt,
      left=8pt, right=8pt, top=2.5pt, bottom=2.5pt
    },
    attach boxed title to top left={yshift*=-2mm,yshifttext=-1mm}
  }
}

% --- boxy ---
\newtcolorbox{bluebox}[1][]{
  bubble=myblue, bubbletitle=myblue, #1
}
\newtcolorbox{redbox}[1][]{
  bubble=myred, bubbletitle=myred, #1
}
\newtcolorbox{smarttabbox}[1][]{
  bubble=myblue, bubbletitle=myblue,
  valign=center,
  #1
}
\newtcolorbox{experimenttitle}[1][]{
  enhanced, colback=myblue!15, frame hidden,
  arc=12pt, left=12pt, right=12pt, top=10pt, bottom=10pt,
  after skip=8pt, #1
}

% --- template ---
\newcommand{\experiment}[8]{%
  % #1 = název
  % #2 = obtížnost
  % #3 = nebezpečí
  % #4 = chemikálie
  % #5 = nádobí
  % #6 = postup
  % #7 = vysvětlení
  % #8 = obsah Smart tab

  % název
  \begin{experimenttitle}
    \centering\LARGE\bfseries #1
  \end{experimenttitle}

  % dvousloupcový layout
  \noindent
  \begin{minipage}[t]{0.66\linewidth}
    \begin{bluebox}[title=Chemikálie]
      #4
    \end{bluebox}
    \begin{bluebox}[title=Nádobí]
      #5
    \end{bluebox}
    \begin{bluebox}[title=Postup]
      #6
    \end{bluebox}
    \begin{bluebox}[title=Vysvětlení experimentu]
      #7
    \end{bluebox}
  \end{minipage}\hfill
  \begin{minipage}[t]{0.30\linewidth}
    \begin{redbox}[title=Obtížnost a nebezpečí]
      \textbf{Obtížnost: } \rating[myblue]{#2}{4}\\[4pt]
      \textbf{Nebezpečí: } \rating[myred]{#3}{4}
    \end{redbox}

    \begin{smarttabbox}[title=Smart tab]
      #8
    \end{smarttabbox}
  \end{minipage}
}
\pagestyle{empty}
