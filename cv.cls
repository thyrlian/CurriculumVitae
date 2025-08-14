\iffalse
Curriculum Vitae / Résumé LaTeX class
By Jing Li
\fi

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2019/05/26 CV class]
\LoadClass[12pt, a4paper]{article}
\pagenumbering{gobble}

% ================================================== %
% Class options (hyphenation/justification/microtype)
% ================================================== %
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=cv,prefix=cv@}

% hyphenation: on|off
\DeclareStringOption[on]{hyphenation}
% justification: justified|raggedright
\DeclareStringOption[justified]{justification}
% microtype: true|false
\DeclareBoolOption[true]{microtype}
% emergencystretch: length value, e.g., 0em / 1em / 2em
\DeclareStringOption[0em]{emergencystretch}

\ProcessKeyvalOptions*

% ================================================== %
% Packages
% ================================================== %
\usepackage[utf8]{inputenc}
\usepackage[left=1in, right=1in, top=1in, bottom=1in]{geometry}
\usepackage{indentfirst}
\usepackage{titlesec}
\usepackage{fontspec}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{array}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage{fontawesome}

% Hyperref & PDF bookmarks
\usepackage{hyperref}
\hypersetup{
  unicode=true % ensure unicode bookmarks
}

% === Layout switches driven by class options ===
\RequirePackage{etoolbox}

% hyphenation on/off
\ifdefstring{\cv@hyphenation}{off}{%
  \RequirePackage[none]{hyphenat}%
}{}

% microtype on/off
\ifcv@microtype
  \RequirePackage{microtype}%
\fi

% justification
\ifdefstring{\cv@justification}{raggedright}{%
  \RequirePackage{ragged2e}%
  \RaggedRight
}{%
  % justified: keep two-sided justification; avoid big gaps with emergencystretch
  \emergencystretch=\cv@emergencystretch
}

% ================================================== %
% Fonts (robust multi-location probing + fallback)
% ================================================== %

% 1) Try project-local fonts/
\newcommand*\cv@fontdir{}
\IfFileExists{fonts/NotoSans/NotoSans-Regular.ttf}{%
  \def\cv@fontdir{fonts/}%
}{}

% 2) Try submodule path CurriculumVitae/fonts/
\ifx\cv@fontdir\@empty
  \IfFileExists{CurriculumVitae/fonts/NotoSans/NotoSans-Regular.ttf}{%
    \def\cv@fontdir{CurriculumVitae/fonts/}%
  }{}
\fi

% 3) Try class-relative fonts/ (requires currfile)
\ifx\cv@fontdir\@empty
  \RequirePackage{currfile}
  \edef\cv@fontdir{\currfileabsdir fonts/}%
\fi

% Debug messages in the .log
\ClassInfo{cv}{Using font dir: \cv@fontdir}

% If still missing, we will fall back later.
\newif\ifcv@fontsok
\IfFileExists{\cv@fontdir NotoSans/NotoSans-Regular.ttf}{\cv@fontsoktrue}{\cv@fontsokfalse}

\ifcv@fontsok
  % Noto Sans (bundled)
  \setmainfont[
    Path=\cv@fontdir NotoSans/,
    UprightFont     = *-Regular.ttf,
    BoldFont        = *-Bold.ttf,
    ItalicFont      = *-Italic.ttf,
    BoldItalicFont  = *-BoldItalic.ttf
  ]{NotoSans}

  % DejaVu Sans (bundled aux family)
  \newfontfamily\DejaVuSans[
    Path=\cv@fontdir DejaVuSans/,
    UprightFont     = DejaVuSans.ttf,
    BoldFont        = DejaVuSans-Bold.ttf,
    ItalicFont      = DejaVuSans-Oblique.ttf,
    BoldItalicFont  = DejaVuSans-BoldOblique.ttf
  ]{DejaVuSans}
\else
  % Hard fallback so we NEVER hit nullfont
  \ClassWarning{cv}{Bundled fonts not found at \cv@fontdir. Falling back to TeX Gyre Heros.}
  \setmainfont{TeX Gyre Heros} % free Helvetica-like, usually in MiKTeX/TeXLive
  \newfontfamily\DejaVuSans{TeX Gyre Heros}
\fi

% ================================================== %
% Colors
% ================================================== %
\definecolor{highlightblue}{RGB}{0, 112, 192}
\definecolor{highlightpurple}{RGB}{102, 51, 153}

% ================================================== %
% Dimensions
% ================================================== %
\def\textindent{0.4em}
\def\parboxindent{37.3em}

% ================================================== %
% Title
% ================================================== %
\titleformat{\section}[hang]{\bfseries\huge}{}{0em}{\textcolor{highlightblue}}
\titlespacing*{\section}{\parindent}{1em}{0.5em}

% ================================================== %
% List items (flush to the same left gutter as other blocks)
% ================================================== %
\RequirePackage{enumitem}

\newlist{cvitemize}{itemize}{1}
\setlist[cvitemize]{%
  leftmargin=\textindent,  % align with other blocks using \textindent
  labelindent=0pt,
  itemindent=0pt,
  labelsep=0.4em,
  label=\textbullet,
  itemsep=0pt, topsep=0pt, parsep=0pt, partopsep=0pt
}

% ================================================== %
% Others
% ================================================== %
\graphicspath{ {./images/} }

% ================================================== %
% Macros
% ================================================== %
\def\circledtext#1{\textcircled{\resizebox{.5em}{!}{#1}}}

% ################################################## %
% Personal information list
% ---------- Usage example ----------
% \begin{personalinfo}
%   \personalinfoitem{✉}{johndoe@example.com}
%   \personalinfoitem{☎}{+1-000-111-0000}
% \end{personalinfo}
% ################################################## %
\newenvironment{personalinfo}
  {%
    % no bullet here; FontAwesome icon acts as the “bullet”
    \begin{cvitemize}[label={},labelsep=0pt]
    \renewcommand{\labelitemi}{}%
  }
  {\end{cvitemize}}
\newcommand{\personalinfoitem}[2]{
  \item \circledtext{#1} #2
}

% ################################################## %
% Work experience list
% ---------- Arguments reference ----------
% #1 - company name
% #2 - job title
% #3 - period
% #4 - company logo
% #5 - logo height
% ---------- Usage example ----------
% \begin{workexperience}{Hooli}{CEO}{Jan 20xx - Dec 20xx}{company_logo_xxx.png}{0.1in}
%   \workexperiencegroup{M\&A}
%   \workexperienceitem{Acquired Acme Corporation for \$8.8 billion.}   
%   \workexperiencegroup{People \& Org}
%   \workexperienceitem{Hired the best engineers in the world.}
%   \workexperienceitem{Built a world-class engineering team.}
%   \workexperiencegroup{Product \& Growth}
%   \\workexperienceitem{Quadrupled monthly active users on mobile.}
% \end{workexperience}
% ################################################## %
% ===== workexperience: inner list uses the same left gutter =====
\newenvironment{workexperience}[5]
{
  \begin{tabularx}{\textwidth}{l>{\raggedleft\arraybackslash}X}
    \textbf{#1} & \multirow{2}{*}{\includegraphics[height=#5]{#4}} \\
    \textcolor{highlightblue}{\textbf{#2}}, #3 & \\
  \end{tabularx}

  \settowidth{\@tempdima}{\textbullet}%
  \addtolength{\@tempdima}{0.4em} % labelsep

  \begin{itemize}[
    leftmargin=\dimexpr\textindent+\@tempdima\relax,
    labelindent=0pt,
    labelsep=0.4em,
    itemsep=0pt, topsep=0pt, parsep=0pt, partopsep=0pt
  ]
}
{
  \end{itemize}
  \vspace{8pt}
}

% Group headline inside workexperience: bold + accent color, full-width, compact spacing
\newcommand{\workexperiencegroup}[1]{%
  \item[]%
  {\textcolor{highlightpurple}{\textbf{#1}}}%
  \vspace{2pt}%
}

\newcommand{\workexperienceitem}[1]{\item #1}

% ################################################## %
% Education background block
% ---------- Arguments reference ----------
% #1 - university name
% #2 - degree
% #3 - major
% #4 - period
% ---------- Usage example ----------
% \educationbackground{Massachusetts Institute of Technology}{MS}{Computer Science}{Sep 19xx - Jul 19xx}
% ################################################## %
\def\educationbackground#1#2#3#4{\begin{tabularx}{\textwidth}{ll>{\raggedleft\arraybackslash}X}
  \multirow{2}{*}{\faUniversity} & \textbf{#1} & \multirow{2}{*}{#4} \\
  & {#2}, {#3} &
\end{tabularx}}

\def\educationitem#1{\hspace*{\textindent}\faGraduationCap\space\space\space\space#1}

% ################################################## %
% Award
% ---------- Arguments reference ----------
% #1 - award title
% #2 - time or period or any other free text
% ---------- Usage example ----------
% \award{Google Developer Expert}{Jan 20xx}
% ################################################## %
\def\award#1#2{\parbox{\parboxindent}{\hspace*{\textindent}\faTrophy\space#1 \hfill #2}}

% ################################################## %
% Coding skills
% ---------- Usage example ----------
% \codingskills{Fortran}{C}{Java}{Kotlin}{Swift}
% ################################################## %
\def\codingskills#1{%
  \par\noindent\hspace*{\textindent}\faCode\space#1%
  \@ifnextchar\bgroup{\iteratenextskill}{, etc.\par}%
}
\def\iteratenextskill#1{, #1\@ifnextchar\bgroup{\iteratenextskill}{, etc.\par}}

% ################################################## %
% Language proficiency
% ---------- Usage example ----------
% \languageproficiency{English/Native}{Spanish/Fluent}
% ################################################## %
\def\splitlanguageproficiency#1{\languageproficiencyargument#1\relax}
\def\languageproficiencyargument#1/#2\relax{#1 (#2)}
\def\languageproficiency#1{%
  \par\noindent\hspace*{\textindent}\faLanguage\space\splitlanguageproficiency{#1}%
  \@ifnextchar\bgroup{\iteratenextlanguage}{\par}%
}
\def\iteratenextlanguage#1{, \splitlanguageproficiency{#1}\@ifnextchar\bgroup{\iteratenextlanguage}{\par}}

% ################################################## %
% Conference talk
% ---------- Arguments reference ----------
% #1 - conference name
% #2 - location
% #3 - dates
% #4 - link
% ---------- Usage example ----------
% \conftalk{DockerCon}{San Francisco}{Jun 2014}{https://www.docker.com/dockercon/}
% ################################################## %
\def\conftalk#1#2#3#4{\parbox{\parboxindent}{\hspace*{\textindent}\faMicrophone\space\href{#4}{#1} \hfill #2 \textbf{·} #3}}

% ################################################## %
% Publication
% ---------- Arguments reference ----------
% #1 - publication
% #2 - ISBN
% #3 - link
% ---------- Usage example ----------
% \publication{The LaTeX Book}{978-0-8888-1024-0}{https://example.com/}
% ################################################## %
\def\publication#1#2#3{\parbox{\parboxindent}{\hspace*{\textindent}\faBook\space\href{#3}{#1} \hfill \textbf{ISBN}: #2}}

% ################################################## %
% Project
% ---------- Arguments reference ----------
% #1 - project
% #2 - link
% #3 - note
% ---------- Usage example ----------
% \project{The Kotlin Programming Language}{https://github.com/JetBrains/kotlin}{Trending repositories on GitHub of all time}
% ################################################## %
\def\project#1#2#3{\parbox{\parboxindent}{\hspace*{\textindent}\faKeyboardO\space\href{#2}{#1}\space\space\space\space(#3)}}
