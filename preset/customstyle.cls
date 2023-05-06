% !Mode:: "TeX:UTF-8"
%%%%% 'customstyle.cls' BEGIN

%%%%%%%%%% class clarification %%%%%%%%%%
% 模板声明

\NeedsTeXFormat{LaTeX2e}[2007/10/19]
\ProvidesClass{preset/customstyle}


%%%%%%%%%% class options %%%%%%%%%%
% 模板选项

% 本模板自身包含五个选项
% 前四个为对应学位类型，决定不同样式
% 第五个为颜色选项，用于电子版的情况
\newif\ifcustom@bachelor\custom@bachelorfalse
\newif\ifcustom@color\custom@colorfalse
\newif\ifcustom@twoteacher\custom@twoteacherfalse
\DeclareOption{bachelor}{\custom@bachelortrue}
\DeclareOption{master}{\custom@mastertrue}
\DeclareOption{engineer}{\custom@engineertrue}
\DeclareOption{doctor}{\custom@doctortrue}
\DeclareOption{color}{\custom@colortrue}
\DeclareOption{twoteacher}{\custom@twoteachertrue}
% 其余选项传递给ctexbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
% 引用ctexbook及基本设置
\LoadClass[zihao=-4,a4paper]{ctexbook}[2007/10/19]

%%%%%%%%%% global package %%%%%%%%%%
% 全局通用宏包

\RequirePackage{ifthen}

%%%%%%%%%% font %%%%%%%%%%
% 数学相关和字体设置

\RequirePackage{amsmath,amssymb,amsfonts,mathrsfs,bm}
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{txfonts}

%%%%%%%%%% hyphen %%%%%%%%%%
% For the `\hyp{}` command. Allow the user to insert `hyp{}` manually to
% adjust the line break when necessary.
\RequirePackage{hyphenat}

% 主要字体为Times New Roman和宋体
% 模板某些标题需要华文行楷和32号字
% \setmainfont{Times New Roman}
% 不需要设置CJKmainfont，ctex 宏包已经很好的处理了
% 不仅设置了粗体为黑体，斜体为楷体，还兼容了winfonts和adobefonts
% 直接设置反而会在只有adobefonts的情况下报错
% \setCJKmainfont{宋体}
\setCJKfamilyfont{hwxingkai}{STXingkai}
\setCJKfamilyfont{hwxingwei}{STXinwei}
\newcommand{\hwxingkai}{\CJKfamily{hwxingkai}}
\newcommand{\hwxingwei}{\CJKfamily{hwxingwei}}

%%%%%%%%%% color %%%%%%%%%%
% 颜色设置

% 只用于电子版
\RequirePackage{color}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

%%%%%%%%%% page margin %%%%%%%%%%
% 页面边距

\RequirePackage{geometry}
\newgeometry{
    top=30mm, bottom=25mm, left=30mm, right=20mm,
    headsep=15mm, includefoot
}
\savegeometry{bachelorgeometry}
\newgeometry{
    top=25mm, bottom=25mm, left=30mm, right=20mm,
    headsep=15mm, headheight=10mm, footskip=10mm,
}
\savegeometry{mastergeometry}

\loadgeometry{bachelorgeometry}

%%%%%%%%%% space %%%%%%%%%%
% 其他间距

\renewcommand{\baselinestretch}{1.5}
\setlength{\parindent}{2em}
\setlength{\floatsep}{3pt plus 3pt minus 2pt}      % 图形之间或图形与正文之间的距离
\setlength{\abovecaptionskip}{10pt plus 1pt minus 1pt} % 图形中的图与标题之间的距离
\setlength{\belowcaptionskip}{3pt plus 1pt minus 2pt} % 表格中的表与标题之间的距离

%%%%%%%%%% header & footer %%%%%%%%%%
% 页眉页脚

\RequirePackage{fancyhdr}
\fancypagestyle{frontmatter}{
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
    \fancyhf{}
    \fancyfoot[C]{\thepage}
}
\fancypagestyle{mainmatter}{
    \fancyhead{}
    \fancyfoot{}
    \fancyhead[C]{
        \includegraphics[width=37bp]{preset/figure/logo.eps}\hfill
        \raisebox{3ex}{\heiti\zihao{5}\custom@university 毕业设计（论文）}\hfill
        \raisebox{3ex}{\songti\zihao{5}第\quad\thepage\quad 页}
    }
    \fancyfoot[C]{\zihao{5}\thepage}

    \renewcommand{\headrulewidth}{0.5bp} % 页眉线宽度
}

\fancypagestyle{plain}{
    \pagestyle{fancy}
}

%%%%%%%%%% title %%%%%%%%%%
% 标题

% 汉化
\renewcommand{\contentsname}{\heiti\zihao{-2}\bfseries 目\qquad 录}
\renewcommand\listfigurename{\heiti\zihao{-2}\bfseries 插\ 图\ 目\ 录}
\renewcommand\listtablename{\heiti\zihao{-2}\bfseries 表\ 格\ 目\ 录}
\renewcommand\bibname{参\ 考\ 文\ 献}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}

% 格式
\ctexset{
    chapter={
        format={\centering\zihao{3}\heiti},
        nameformat={},
        aftername={\quad},
        titleformat={},
        beforeskip={-.5\baselineskip},
        afterskip={\baselineskip},
    },
    section={
        aftername={\quad},
        beforeskip={.5\baselineskip},
        afterskip={.5\baselineskip},
    },
    subsection={
        format={\zihao{-4}\heiti},
        aftername={\quad},
        beforeskip={.5\baselineskip},
        afterskip={.5\baselineskip},
    },
}

\ifcustom@bachelor
    \ctexset{
        chapter={
            name={,},
            number={\arabic{chapter}},
        },
        section={
            format={\zihao{-4}\heiti},
        },
    }
\else
    \ctexset{
        chapter={
            name={第,章},
            number={\chinese{chapter}},
        },
        section={
            format={\zihao{4}\heiti},
        },
    }
\fi

%%%%%%%%%% contents %%%%%%%%%%
% 目录

\RequirePackage{titletoc}
\titlecontents{chapter}[0pt]{\heiti\zihao{-4}}{\thecontentslabel\ }{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}
\titlecontents{section}[2em]{\vspace{0.1\baselineskip}\songti\zihao{-4}}{\thecontentslabel\ }{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}
\titlecontents{subsection}[4em]{\vspace{0.1\baselineskip}\songti\zihao{-4}}{\thecontentslabel\ }{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

% 取消图片、表格目录中的章节空格
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}

%表目录图目录的格式设置
%表目录与图目录数字前增加“表”与“图”字，并且使目录行间距与section行间距一致

\titlecontents{figure}[0pt]{\vspace{0.15\baselineskip}\songti\zihao{-4}}{\makebox[3em][l]{图~\thecontentslabel\quad}}{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}[\vspace{0.15\baselineskip}]

\titlecontents{table}[0pt]{\vspace{0.15\baselineskip}\songti\zihao{-4}}{\makebox[3em][l]{表~\thecontentslabel\quad}}{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}[\vspace{0.15\baselineskip}]

%%%%%%%%%% cross reference %%%%%%%%%%
% 交叉引用

\RequirePackage[xetex,unicode]{hyperref}
\hypersetup{hidelinks}
\hypersetup{
    bookmarksnumbered,
    bookmarksopen
}

%%%%%%%%%% reference %%%%%%%%%%
% 参考文献
\RequirePackage[sort&compress]{natbib}
\bibpunct{[}{]}{,}{n}{}{}
\setlength{\bibsep}{0pt}
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

%%%%%%%%%% table %%%%%%%%%%
% 表格

% 设置三线表格的上下边为粗实线
\RequirePackage{booktabs}

% 长表格
\RequirePackage{longtable}

% 表格中的行合并
\RequirePackage{multirow}

% 重定义table/tabular/tabularx环境，使表格内为5号字
% TODO(huxuan): 支持 longtable
\let\oldtable\table
\let\endoldtable\endtable
\renewenvironment{table}[1][h!]
{\renewcommand{\arraystretch}{1.5}
\oldtable[#1]\zihao{5}}
{\renewcommand{\arraystretch}{1}
\endoldtable}

\let\oldtabular\tabular
\let\endoldtabular\endtabular
\renewenvironment{tabular}[1][h!]
{\renewcommand{\arraystretch}{1.5}
\oldtabular[#1]\zihao{5}}
{\renewcommand{\arraystretch}{1}
\endoldtabular}

\RequirePackage{tabularx}
\let\oldtabularx\tabularx
\let\endoldtabularx\endtabularx
\renewenvironment{tabularx}[2]
{\renewcommand{\arraystretch}{1.5}
\zihao{5}\oldtabularx{#1}{#2}}
{\renewcommand{\arraystretch}{1}
\endoldtabularx}


\RequirePackage{array}

%%%%%%%%%% picture %%%%%%%%%%
% 图片

\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.eps,.ps,.jpg,.bmp}
\graphicspath{{figure/}}
\RequirePackage{pifont} % “密级”后的五角星
\RequirePackage{subfigure}

%%%%%%%%%% list %%%%%%%%%%
% 列表

\RequirePackage{enumitem}
\setlist{noitemsep}
\setlist[1,2]{labelindent=\parindent}
\setlist[enumerate,1]{label=\arabic*、}
\setlist[enumerate,2]{label=（\arabic*）}
\setlist{
    topsep=0pt,
    itemsep=0pt,
    partopsep=0pt,
    parsep=\parskip,
}

%%%%%%%%%% code %%%%%%%%%%
% 代码

% Listing 的设置请参考 http://en.wikibooks.org/wiki/LaTeX/Packages/Listings
\RequirePackage{listings}
\lstset{
    backgroundcolor=\color{white},
    basicstyle=\zihao{5}\ttfamily,
    columns=flexible,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    frame=single,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    stepnumber=1,
    rulecolor=\color{black},
    tabsize=2,
    texcl=true,
    title=\lstname,
    escapeinside={\%*}{*)},
    extendedchars=false,
    mathescape=true,
    xleftmargin=3em,
    xrightmargin=3em,
}
\ifcustom@color
    \lstset{
        numberstyle=\color{gray},
        keywordstyle=\color{blue},
        commentstyle=\color{dkgreen},
        stringstyle=\color{mauve},
    }
\else
    \lstset{
        numberstyle=\color{black},
        keywordstyle=\color{black},
        commentstyle=\color{black},
        stringstyle=\color{black},
    }
\fi

% 重命名Listings标题头
\renewcommand{\lstlistingname}{代码}

%%%%%%%%%% theorem %%%%%%%%%%
% 定理

\theoremsymbol{\ensuremath{\square}}
\newtheorem*{proof}{证明}
\theoremstyle{plain}
\theoremsymbol{}
\theoremseparator{：}
\newtheorem{assumption}{假设}[chapter]
\newtheorem{definition}{定义}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{lemma}{引理}[chapter]
\newtheorem{theorem}{定理}[chapter]
\newtheorem{axiom}{公理}[chapter]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{exercise}{练习}[chapter]
\newtheorem{example}{例}[chapter]
\newtheorem{remark}{注释}[chapter]
\newtheorem{problem}{问题}[chapter]
\newtheorem{conjecture}{猜想}[chapter]

%%%%%%%%%% file directory %%%%%%%%%%
% 文件目录

\RequirePackage{dirtree}
\ifcustom@color
    \renewcommand*\DTstylecomment{\ttfamily\color{dkgreen}}
    \renewcommand*\DTstyle{\ttfamily\color{red}}
\fi

%%%%%%%%%% caption %%%%%%%%%%
% 图表标题

\RequirePackage{caption}
\DeclareCaptionFormat{bachelorfigure}{\songti\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{bachelortable}{\heiti\bf\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{bachelorlstlisting}{\songti\bf\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{masterfigure}{\songti\bf\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{mastertable}{\songti\bf\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{masterlstlisting}{\songti\bf\zihao{5}{#1\textrm{#2}#3}}
\ifcustom@bachelor
    \captionsetup[figure]{format=bachelorfigure,labelsep=quad}
    \captionsetup[table]{format=bachelortable,labelsep=quad}
    \captionsetup[lstlisting]{format=bachelorlstlisting,labelsep=quad}
    \renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
    \renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
    \renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\else
    \RequirePackage{remreset}
    \@removefromreset{table}{chapter}
    \@removefromreset{figure}{chapter}
    %使图表的标号与章节无关
    \captionsetup[figure]{format=masterfigure,labelsep=quad}
    \captionsetup[table]{format=mastertable,labelsep=quad}
    \captionsetup[lstlisting]{format=masterlstlisting,labelsep=quad}
    \renewcommand{\thefigure}{\arabic{figure}}
    \renewcommand{\thetable}{\arabic{table}}
    \renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\fi

% Fix subfigure reference bug
\let\p@subfigure=\thefigure

% 图片表格标题命令，主要用于混排
\newcommand\figcaption{\def\@captype{figure}\caption}
\newcommand\tabcaption{\def\@captype{table}\caption}

%%%%%%%%%% other settings %%%%%%%%%%
% 杂项

% 设置<附录>的图表编号与当前附录章号关联
\newcommand{\rmrelation}{
% 图、表、公式编号随 chapter 清零
\@addtoreset{figure}{chapter}
\@addtoreset{table}{chapter}
\@addtoreset{equation}{chapter}
%图、表、公式编号章节关联
\renewcommand{\thefigure}{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\renewcommand{\thetable}{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\renewcommand{\theequation}{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
}

\let\oldappendix\appendix
\renewcommand{\appendix}{
\oldappendix\rmrelation
}


% 下划线
\RequirePackage{ulem}

% 设置行距
\RequirePackage{setspace}

% 正文前的页码设置位大写罗马数字
\renewcommand{\frontmatter}{
    \cleardoublepage
    \@mainmatterfalse
    \ifcustom@bachelor
        \pagenumbering{Roman}
    \else
        \pagenumbering{roman}
    \fi
}

% 保证偶数页结束章节
\newcommand{\clearemptydoublepage}{%
    \clearpage
}

%%%%%%%%%% index %%%%%%%%%%
% 首页

% 本科生首页的右上角和底部的填写内容居中
% cvrtc : CoVer - Right  - Top    - Center
% cvcbc : CoVer - Center - Bottom - Center
\newcommand{\ulinecvrtc}[1]{\uline{\makebox[9em][c]{\bf #1}}}
\newcommand{\ulinecvcbc}[1]{\uline{\makebox[12em][c]{#1}}}
%\newcommand{\ulinecvcbc}[1]{\uline{\makebox[12em][s]{#1}}}

% 中文首页
\newcommand{\titlech}{
\begin{titlepage}
% 第二个()里的参数表示左移35pt，下移55pt
\begin{picture}(0,0)(35,55)
    \includegraphics[width=90pt]{preset/figure/logo.eps}
\end{picture}
\hfill
\raisebox{-.2cm}[0pt][0pt]{
    \zihao{5}\heiti
    \begin{tabular}{c}
        \makebox[6em][s]{学校代码\quad}\ulinecvrtc{\bf\custom@unicode}\\[.1ex]
        \makebox[6em][s]{学号\quad}\ulinecvrtc{\bf\custom@studentID}\\[.1ex]
        \makebox[6em][s]{中图分类号\quad}\ulinecvrtc{\bf\custom@category}\\[.1ex]
    \end{tabular}
}
\vskip 95bp
\begin{center}
    \centerline{\zihao{-0} \hwxingwei{中国计量大学}}
    \vskip 20bp
    \centerline{\zihao{-3}\heiti 毕业设计（论文）}
    ~~\\
    \begin{minipage}[h]{.8\textwidth}
        \centering{\heiti\zihao{2}\custom@thesistitle}
    \end{minipage}
    \vskip 20bp
    \begin{minipage}[h]{.75\textwidth}
        \centering{\heiti\zihao{3}\custom@thesissubtitle}
    \end{minipage}
    \vskip 30bp
    \begin{minipage}[h]{.8\textwidth}
        \centering{\zihao{2}\MakeUppercase{\custom@thesistitleeng}}
    \end{minipage}
    \vskip 20bp
    \begin{minipage}[h]{.75\textwidth}
        \centering{\zihao{3}\MakeUppercase{\custom@thesissubtitleeng}}
    \end{minipage}
    \vspace*{\stretch{3}}

    ~~\\
    {
        \zihao{-3}\heiti
            \begin{tabular}{cc}
                \makebox[8em][s]{学院名称\quad}\ulinecvcbc{\bf\custom@school 学院}\\[.4ex]
                \makebox[8em][s]{专业名称\quad}\ulinecvcbc{\bf\custom@major 专业}\\[.4ex]
                \makebox[8em][s]{学生姓名\quad}\ulinecvcbc{\bf\custom@thesisauthor}\\[.4ex]
                \makebox[8em][s]{班级\quad}\ulinecvcbc{\bf\custom@class}\\[.4ex]
                \makebox[8em][s]{学号\quad}\ulinecvcbc{\bf\custom@studentID}\\[.4ex]
                \makebox[8em][s]{指导教师\quad}\ulinecvcbc{\bf\custom@teacher}\\
            \end{tabular}
    }
\end{center}
    \vfill
    \centerline{\heiti\zihao{-3}\custom@thesisdateyear ~~年~~\custom@thesisdatemonth ~~月}

    \end{titlepage}
}

%%%%%%%%%% abstract %%%%%%%%%%
% 摘要

% 中文摘要
\newenvironment{cabstract}{%
    \newpage
    \vspace*{2bp}
    \ifcustom@bachelor
        \begin{center}
            \begin{minipage}[h]{.75\textwidth}
                \centering{\zihao{3}\heiti\custom@thesistitle}
            \end{minipage}
            \begin{minipage}[h]{.8\textwidth}
                \begin{flushright}
                    {\zihao{3}\heiti\custom@thesissubtitle}
                \end{flushright}
                % subtitle should be flush right?
            \end{minipage}
        \end{center}
        %\vskip 10bp
        \begin{flushright}
            \ifcustom@twoteacher
                {\begin{tabular}{cl}
                    学\qquad 生：&\custom@thesisauthor\\
                    指导教师：&\custom@teacher\\
                    ~~ & \custom@subteacher\\
                    % I don't know is this corrent and properly.
                \end{tabular}}
            \else
                {\begin{tabular}{cl}
                    学\qquad 生：&\custom@thesisauthor\\
                    指导教师：&\custom@teacher\\
                \end{tabular}}
            \fi
        \end{flushright}
    \fi
    \centerline{\heiti\zihao{3} 摘~~~~要}
    \ifcustom@bachelor
        \vskip 10bp
        \par
    \else
        \vspace{5ex}
    \fi
    \setlength{\parindent}{24bp}
    }{%
    \vskip 21bp
    \ifcustom@bachelor
        \noindent
    \fi
    {\heiti\zihao{-4} 关键词：}\custom@ckeyword
}

% 英文摘要
\newenvironment{eabstract}{%
    \newpage
    \vspace*{2bp}
    \ifcustom@bachelor
        \begin{center}
            \begin{minipage}[h]{.75\textwidth}
                \centering{\bf\zihao{3}\MakeUppercase{\custom@thesistitleeng}}
            \end{minipage}
            \begin{minipage}[h]{.8\textwidth}
                \begin{flushright}
                    {\zihao{3}\heiti\MakeUppercase{\custom@thesissubtitleeng}}
                \end{flushright}
            % subtitle should be flushright?
            \end{minipage}
        \end{center}
        \vskip 10bp
        \begin{flushright}
            \ifcustom@twoteacher
                {\begin{tabular}{rl}
                    Author:\ &\custom@thesisauthoreng\\
                    Tutor:\ &\custom@teachereng\\
                    ~~ & \custom@subteachereng\\
                \end{tabular}}
            \else
                {\begin{tabular}{rl}
                    Author:\ &\custom@thesisauthoreng\\
                    Tutor:\ &\custom@teachereng\\
                \end{tabular}}
            \fi
        \end{flushright}
    \fi
    \centerline{\bf\zihao{3} Abstract}
    \ifcustom@bachelor
        \vskip 10bp
        \par
    \else
        \vspace{5ex}
    \fi
    \setlength{\parindent}{24bp}
    }{%
    \vskip 21bp
    \ifcustom@bachelor
        \noindent
    \fi
    {\bf\zihao{-4} Key words: }\custom@ekeyword
}

%%%%%%%%%% announce %%%%%%%%%%
% 本科生声明页

\newcommand{\announce}{%
    \clearemptydoublepage
    \thispagestyle{empty}
    \vspace*{54bp}
    \centerline{\bf\zihao{-0}\heiti 郑~~重~~声~~明~}
    \vskip 80bp
    \zihao{3}本人呈交的毕业设计论文，是在导师的指导下，独立进行研究工作所取得的成果，所有数据、图片资料真实可靠。尽我所知，除文中已经注明引用的内容外，本学位论文的研究成果不包含他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确的方式标明。本学位论文的知识产权归属于培养单位。\par
    \zihao{-3}
    \begin{flushright}
    \vfill
        \begin{tabular}{cl}
            作者：&\ulinecvrtc{\custom@thesisauthor}\\[.1ex]
            签字：&\ulinecvrtc{~~~~}\\[.1ex]
            日期：&\ulinecvrtc{\custom@thesisdateyear~年~\custom@thesisdatemonth ~月}\\[.1ex]
        \end{tabular}
    \end{flushright}
}

%%%%%%%%%% assign %%%%%%%%%%
% 本科生任务书

% 文字左对齐的下划线
\newcommand{\ulinel}[2][]{\uline{\makebox[#1\textwidth][l]{#2}}}
% 文字居中的下划线
\newcommand{\ulinec}[2][]{\uline{\makebox[#1\textwidth][c]{#2}}}
% 任务书条目序号
\newcounter{assign}
% 原始资料及设计要求
\def\custom@bachelor@assign@req@one{}
\def\custom@bachelor@assign@req@two{}
\def\custom@bachelor@assign@req@three{}
\def\custom@bachelor@assign@req@four{}
\def\custom@bachelor@assign@req@five{}
\newcommand{\assignReq}[5]{
    \def\custom@bachelor@assign@req@one{#1}
    \def\custom@bachelor@assign@req@two{#2}
    \def\custom@bachelor@assign@req@three{#3}
    \def\custom@bachelor@assign@req@four{#4}
    \def\custom@bachelor@assign@req@five{#5}
}
% 工作内容
\def\custom@bachelor@assign@work@one{}
\def\custom@bachelor@assign@work@two{}
\def\custom@bachelor@assign@work@three{}
\def\custom@bachelor@assign@work@four{}
\def\custom@bachelor@assign@work@five{}
\def\custom@bachelor@assign@work@six{}
\newcommand{\assignWork}[6]{
    \def\custom@bachelor@assign@work@one{#1}
    \def\custom@bachelor@assign@work@two{#2}
    \def\custom@bachelor@assign@work@three{#3}
    \def\custom@bachelor@assign@work@four{#4}
    \def\custom@bachelor@assign@work@five{#5}
    \def\custom@bachelor@assign@work@six{#6}
}
% 参考文献
\def\custom@bachelor@assign@ref@one{}
\def\custom@bachelor@assign@ref@two{}
\def\custom@bachelor@assign@ref@three{}
\def\custom@bachelor@assign@ref@four{}
\def\custom@bachelor@assign@ref@five{}
\def\custom@bachelor@assign@ref@six{}
\def\custom@bachelor@assign@ref@seven{}
\def\custom@bachelor@assign@ref@eight{}
\newcommand{\assignRef}[8]{
    \def\custom@bachelor@assign@ref@one{#1}
    \def\custom@bachelor@assign@ref@two{#2}
    \def\custom@bachelor@assign@ref@three{#3}
    \def\custom@bachelor@assign@ref@four{#4}
    \def\custom@bachelor@assign@ref@five{#5}
    \def\custom@bachelor@assign@ref@six{#6}
    \def\custom@bachelor@assign@ref@seven{#7}
    \def\custom@bachelor@assign@ref@eight{#8}
}
% 任务书
\def\custom@bachelor@assign{
    \newpage
    \thispagestyle{empty}
    \parindent=0pt
    \songti
    {
        \zihao{2}
        {
            \renewcommand{\CJKglue}{\hskip 1pt}
            \centerline{\zihao{-0} \hwxingwei{中国计量大学}}
        }
        {
            \renewcommand{\CJKglue}{\hskip 1.2pt}
            \centerline{\zihao{-3} \heiti{毕业设计（论文）任务书}}
        }
    }
    {
        \linespread{2}
        \zihao{4}
        \stepcounter{assign}
        \Roman{assign}、毕业设计（论文）题目： \\[2.5ex]
        \ulinel{\custom@thesistitle}
        \ulinel{\custom@thesissubtitle}
        \ulinel{}
        \stepcounter{assign}
        \Roman{assign}、毕业设计（论文）使用的原始资料（数据）及设计技术要求： \\[2.5ex]
        \ulinel{\custom@bachelor@assign@req@one}
        \ulinel{\custom@bachelor@assign@req@two}
        \ulinel{\custom@bachelor@assign@req@three}
        \ulinel{\custom@bachelor@assign@req@four}
        \ulinel{\custom@bachelor@assign@req@five}
        \stepcounter{assign}
        \Roman{assign}、毕业设计（论文）工作内容： \\[2.5ex]
        \ulinel{\custom@bachelor@assign@work@one}
        \ulinel{\custom@bachelor@assign@work@two}
        \ulinel{\custom@bachelor@assign@work@three}
        \ulinel{\custom@bachelor@assign@work@four}
        \ulinel{\custom@bachelor@assign@work@five}
        \newpage
        \thispagestyle{empty}
        \begin{spacing}{1.9}
        \zihao{4}
        \stepcounter{assign}
        \Roman{assign}、主要参考资料： \\[1.5ex]
        \ulinel{\custom@bachelor@assign@ref@one}
        \ulinel{\custom@bachelor@assign@ref@two}
        \ulinel{\custom@bachelor@assign@ref@three}
        \ulinel{\custom@bachelor@assign@ref@four}
        \ulinel{\custom@bachelor@assign@ref@five}
        \ulinel{\custom@bachelor@assign@ref@six}
        \ulinec[.28]{\custom@school}学院\ulinec[.28]{\custom@major}~专业类~\ulinec[.15]{\custom@class}班 \\
        学生\ulinec[.3]{\custom@thesisauthor} \\
        毕业设计（论文）时间：~~\ulinec[.1]{\custom@thesisbeginyear}年\ulinec[.06]{\custom@thesisbeginmonth}月\ulinec[.06]{\custom@thesisbeginday}日至\ulinec[.1]{\custom@thesisendyear}年\ulinec[.06]{\custom@thesisendmonth}月\ulinec[.06]{\custom@thesisendday}日 \\
        答辩时间：\ulinec[.16]{\custom@defenseyear}年\ulinec[.08]{\custom@defensemonth}月\ulinec[.08]{\custom@defenseday}日 \\
        成\qquad 绩：\ulinec[.3]{} \\
        指导教师：\ulinec[.3]{} \\
        兼职教师或答疑教师（并指出所负责部分）：\\
        \ulinel{}
        \ulinel{}
        \ulinec[.28]{}系（教研室） 主任（签字）：\ulinec[.38]{}
        \par
        \vfill
        注：任务书应该附在已完成的毕业设计（论文）的首页。
        \end{spacing}
    }
    \parindent=2\ccwd
    \linespread{1.5}
}

%%%%%%%%%% denotation %%%%%%%%%%
% 符号对照表

\newenvironment{denotation}
    {
        \chapter*{主要符号对照表\markboth{主要符号对照表}{}} % no tocline
        \begin{list}{}%
        {
            \zihao{-4}
            \renewcommand\makelabel[1]{##1\hfil}
            \setlength{\labelwidth}{2.5cm} % 标签盒子宽度
            \setlength{\labelsep}{0.5cm} % 标签与列表文本距离
            \setlength{\itemindent}{0cm} % 标签缩进量
            \setlength{\leftmargin}{10em} % 左边界
            \setlength{\rightmargin}{0cm}
            \setlength{\parsep}{0cm} % 段落间距
            \setlength{\itemsep}{0cm} % 标签间距
            \setlength{\listparindent}{0cm} % 段落缩进量
            \setlength{\topsep}{0cm} % 标签与上文的间距
        }
    }
    {\end{list}}

%%%%%%%%%% settings for custom pages %%%%%%%%%%
% 首页重定义

\renewcommand{\maketitle}{%
    \titlech
    \ifcustom@bachelor
        \pagestyle{empty}
        \custom@bachelor@assign     %本科生论文任务书
        \announce                 %本科生声明
        \pagestyle{fancy}
        \frontmatter
    \else
        \titleeng                 %研究生英文封面
        \timingye                 %研究生题名页
        \creationanduse           %研究生独创性声明和使用授权书
        \clearemptydoublepage
        \frontmatter
    \fi
    \songti
    \zihao{-4}
}

%%%%%%%%%% common user info %%%%%%%%%%
% 用户信息

% 学校名称
\def\custom@university{中国计量大学}
\def\custom@universityeng{China Jiliang University}
\newcommand{\university}[2]{%
    \def\custom@university{#1}
    \def\custom@universityeng{#2}
}
% 学院
\def\custom@school{}
\def\custom@schooleng{}
\newcommand{\school}[2]{%
    \def\custom@school{#1}
    \def\custom@schooleng{#2}
}
% 专业
\def\custom@major{}
\def\custom@majoreng{}
\newcommand{\major}[2]{%
    \def\custom@major{#1}
    \def\custom@majoreng{#2}
}
% 论文标题和副标题
\def\custom@thesistitle{}
\def\custom@thesissubtitle{}
\def\custom@thesistitleeng{}
\def\custom@thesissubtitleeng{}
\newcommand{\thesistitle}[4]{%
    \def\custom@thesistitle{#1}
    \def\custom@thesissubtitle{#2}
    \def\custom@thesistitleeng{#3}
    \def\custom@thesissubtitleeng{#4}
}
% 作者
\def\custom@thesisauthor{}
\def\custom@thesisauthoreng{}
\newcommand{\thesisauthor}[2]{%
    \def\custom@thesisauthor{#1}
    \def\custom@thesisauthoreng{#2}
}
% 指导老师
\def\custom@teacher{}
\def\custom@teachereng{}
\newcommand{\teacher}[2]{%
    \def\custom@teacher{#1}
    \def\custom@teachereng{#2}
}
% 副指导老师
\def\custom@subteacher{}
\def\custom@subteachereng{}
\newcommand{\subteacher}[2]{%
    \def\custom@subteacher{#1}
    \def\custom@subteachereng{#2}
}
% 分类号
\def\custom@category{}
\newcommand{\category}[1]{%
    \def\custom@category{#1}
}
% 论文开始时间
\def\custom@thesisbeginyear{}
\def\custom@thesisbeginmonth{}
\def\custom@thesisbeginday{}
\newcommand{\thesisbegin}[3]{%
    \def\custom@thesisbeginyear{#1}
    \def\custom@thesisbeginmonth{#2}
    \def\custom@thesisbeginday{#3}
}
% 论文结束时间
\def\custom@thesisendyear{}
\def\custom@thesisendmonth{}
\def\custom@thesisendday{}
\newcommand{\thesisend}[3]{%
    \def\custom@thesisendyear{#1}
    \def\custom@thesisendmonth{#2}
    \def\custom@thesisendday{#3}
}
% 答辩时间
\def\custom@defenseyear{}
\def\custom@defensemonth{}
\def\custom@defenseday{}
\newcommand{\defense}[3]{%
    \def\custom@defenseyear{#1}
    \def\custom@defensemonth{#2}
    \def\custom@defenseday{#3}
}
% 中文摘要关键字
\def\custom@ckeyword{}
\newcommand{\ckeyword}[1]{%
    \def\custom@ckeyword{#1}}
% 英文摘要关键字
\def\custom@ekeyword{}
\newcommand{\ekeyword}[1]{%
    \def\custom@ekeyword{#1}}
% 学位
\def\custom@degree{} % 中文首页和题名页
\def\custom@degreeeng{} % 英文首页
\def\custom@headdegree{} % 页眉页脚
\newcommand{\degree}[3]{%
    \def\custom@degree{#1}
    \def\custom@degreeeng{#2}
    \def\custom@headdegree{#3}
}

 \degree{学士学位}{Bachelor}{学士}


%%%%%%%%%% bachelor user info %%%%%%%%%%
% 本科生信息

% 班级
\def\custom@class{}
\newcommand{\class}[1]{%
    \def\custom@class{#1}
}
% 单位代码
\def\custom@unicode{1006}
\newcommand{\unicode}[1]{%
    \def\custom@unicode{#1}
}
% 学号
\def\custom@studentID{}
\newcommand{\studentID}[1]{%
    \def\custom@studentID{#1}
}
% 论文时间
\def\custom@thesisdateyear{}
\def\custom@thesisdatemonth{}
\newcommand{\thesisdate}[2]{%
    \def\custom@thesisdateyear{#1}
    \def\custom@thesisdatemonth{#2}
}

%%%%% 'buaathesis.cls' %%%%% END
