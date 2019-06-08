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
% Arguments reference
% #1 - company name
% #2 - job title
% #3 - period
% #4 - company logo
% #5 - logo height
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
% Arguments reference
% #1 - university name
% #2 - degree
% #3 - major
% #4 - period
% ################################################## %
\def\educationbackground#1#2#3#4{\begin{tabularx}{\textwidth}{ll>{\raggedleft\arraybackslash}X}
  \multirow{2}{*}{\faUniversity} & \textbf{#1} & \multirow{2}{*}{#4} \\
  & {#2}, {#3} &
\end{tabularx}}

\def\educationitem#1{\hspace*{\textindent}\faGraduationCap\ #1}

\def\award#1#2{\parbox{37.3em}{\hspace*{\textindent}\faTrophy\ #1 \hfill #2}}

\makeatletter
\def\codingskills#1{\faCode\ #1\@ifnextchar\bgroup{\iteratenext}{, etc.}}
\def\iteratenext#1{, #1\@ifnextchar\bgroup{\iteratenext}{, etc.}}
