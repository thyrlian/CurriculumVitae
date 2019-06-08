\iffalse
Curriculum Vitae / Résumé LaTeX class
By Jing Li
\fi

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2019/05/26 CV class]
\LoadClass[12pt, a4paper]{article}

% ================================================== %
% Packages
% ================================================== %
\usepackage[utf8]{inputenc}
\usepackage[left=1in, right=1in, top=1in, bottom=1in]{geometry}
\usepackage{indentfirst}
\usepackage{titlesec}
\usepackage{fontspec}
\usepackage{xcolor}
\usepackage{hyperref}
\usepackage{graphicx}
\usepackage{array}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage{fontawesome}

% ================================================== %
% Fonts
% ================================================== %
\setmainfont[Path=./fonts/Calibri/,
  BoldItalicFont=Calibriz.ttf,
  BoldFont      =Calibrib.ttf,
  ItalicFont    =Calibrii.ttf]{Calibri.ttf}
\newfontfamily\DejaVuSans[Path=./fonts/DejaVuSans/,
  BoldFont      =DejaVuSans-Bold.ttf]{DejaVuSans.ttf}

% ================================================== %
% Colors
% ================================================== %
\definecolor{highlightblue}{RGB}{0, 112, 192}

% ================================================== %
% Dimensions
% ================================================== %
\def\textindent{0.4em}

% ================================================== %
% Title
% ================================================== %
\titleformat{\section}[hang]{\bfseries\huge}{}{0em}{\textcolor{highlightblue}}
\titlespacing*{\section}{\parindent}{1em}{0.5em}

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
  {
    \begin{itemize}
    \renewcommand{\labelitemi}{}
    \setlength\itemsep{0em}
    \setlength\itemindent{-1em}
  }{
    \end{itemize}
  }
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
%   \workexperienceitem{Acquired Acme Corporation for $8.8 billion}
%   \workexperienceitem{Quadrupled the number of monthly active users on mobile platform}
% \end{workexperience}
% ################################################## %
\newenvironment{workexperience}[5]
{
  \begin{tabularx}{\textwidth}{l>{\raggedleft\arraybackslash}X}
    \textbf{#1} & \multirow{2}{*}{\includegraphics[height=#5]{#4}} \\
    \textcolor{highlightblue}{\textbf{#2}}, #3 & \\
  \end{tabularx}
  \begin{itemize}
  \setlength\itemsep{0em}
}{
  \end{itemize}
}
\newcommand{\workexperienceitem}[1]{
  \item #1
}

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

\def\educationitem#1{\hspace*{\textindent}\faGraduationCap\ #1}

% ################################################## %
% Award
% ---------- Arguments reference ----------
% #1 - award title
% #2 - time or period or any other free text
% ---------- Usage example ----------
% \award{Google Developer Expert}{Jan 20xx}
% ################################################## %
\def\award#1#2{\parbox{37.3em}{\hspace*{\textindent}\faTrophy\ #1 \hfill #2}}

% ################################################## %
% Coding skills
% ---------- Usage example ----------
% \codingskills{Fortran}{C}{Java}{Kotlin}{Swift}
% ################################################## %
\def\codingskills#1{\faCode\ #1\@ifnextchar\bgroup{\iteratenextskill}{, etc.}}
\def\iteratenextskill#1{, #1\@ifnextchar\bgroup{\iteratenextskill}{, etc.}}

% ################################################## %
% Language proficiency
% ---------- Usage example ----------
% \languageproficiency{English/Native}{Spanish/Fluent}
% ################################################## %
\def\splitlanguageproficiency#1{\languageproficiencyargument#1\relax}
\def\languageproficiencyargument#1/#2\relax{#1 (#2)}
\def\languageproficiency#1{\faLanguage\ \splitlanguageproficiency{#1}\@ifnextchar\bgroup{\iteratenextlanguage}{}}
\def\iteratenextlanguage#1{, \splitlanguageproficiency{#1}\@ifnextchar\bgroup{\iteratenextlanguage}{}}

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
\def\conftalk#1#2#3#4{\faMicrophone\ \href{#4}{#1} \hfill #2 \textbf{·} #3}

% ################################################## %
% Publication
% ---------- Arguments reference ----------
% #1 - publication
% #2 - ISBN
% #3 - link
% ---------- Usage example ----------
% \publication{The LaTeX Book}{978-0-8888-1024-0}{https://example.com/}
% ################################################## %
\def\publication#1#2#3{\faBook\ \href{#3}{#1} \hfill \textbf{ISBN}: #2}

% ################################################## %
% Project
% ---------- Arguments reference ----------
% #1 - project
% #2 - link
% #3 - note
% ---------- Usage example ----------
% \project{The Kotlin Programming Language}{https://github.com/JetBrains/kotlin}{Trending repositories on GitHub of all time}
% ################################################## %
\def\project#1#2#3{\faKeyboardO\ \href{#2}{#1}\space\space\space\space(#3)}
