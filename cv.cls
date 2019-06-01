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
\def\personalinfo#1#2{\noindent\hspace*{\parindent}\vspace{0.4em}\circledtext{#1} {#2} \\}
% ################################################## %
% Arguments reference
% #1 - company name
% #2 - job title
% #3 - period
% #4 - company logo
% #5 - logo height
% ################################################## %
\def\richexperienceheadline#1#2#3#4#5{\begin{tabularx}{\textwidth}{l>{\raggedleft\arraybackslash}X}
  \textbf{#1} & \multirow{2}{*}{\includegraphics[height=#5]{#4}} \\
  \textcolor{highlightblue}{\textbf{#2}}, #3 & \\
\end{tabularx}}
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
