\ProvidesClass{guji}[2006/12/10 v0.1a, by XING Zhaopeng zpxing@gmail.com]
%%本作品遵循 GPL 協議發布
%%To-do
% 07/xx/xx---古籍結構
%%書衣
%%書簽
%%書腦
%%書脊
%%書頭
%%書根
%%扉頁
%%書名頁
%%牌記
%%序
%%目錄
%%凡例
%%正文
%%跋
%%夾注, 側注, 篇後注
%%History
% 06/12/06---古籍版式
%%版面
%%版框
%%行格
%%版心
%%單魚尾, 雙魚尾
%%白口, 黑口
%%書耳
%%朱絲欄, 烏絲欄
%%已知問題
%%1. 文章如果在最左一格結束, 會在其後産生額外空白頁, 如果在其他格結束, 最後一頁不會輸出.
%%原因: 分格收集 \box255 的時候, 如果文章結束, 其後面下一個行格得到 \box255 是空的,
%%再后面的 \box255 究竟是 void, 還是empty? 我不知道 TeX 是怎么規定的.
%%2. 其他尺寸的漢字可能不會在行格中居中對齊.
%%原因: 我不知道漢字直排後一個字 \box 的 height 是不是原來的 width. 另外漢字的 pt 大小和其
%%三個 dimention 的關係, 在設計居中對齊時, 統一都按 pt 大小作爲一行直排漢字 \hbox 的height + depth
%%3. 改變 \textwidth 到某個時候, 會有莫明其妙的 \CJK@XX 類錯誤.
%%原因: 我定義的盒子很多都是固定尺寸的, 如果盒子裏內容的 glue 不够, 可能會錯誤.
%%4. 朱絲欄和底欄之間距離有點明顯.
%%原因: 朱絲欄使用 \textcolor{}{} 定義, 這樣就把裏面的 \vrule 給分組了(grouping), 所以會有小的空白.
%%5. 為什麽不使用計數器來 count 行格, 同時使用 \loop ... \if ... \repeat 來簡化 \shipout?
%%原因: 需要讓行格的定義爲全局的(\global), 但是 \global\setbox#1 似乎有問題, 會和其他 LaTeX
%%的內部盒子衝突.
%%6. 很多的\overfull \underfull 的警告.
%%原因: 我已經使用了很大的 \vfuzz \hfuzz, 但是同時消除 \overfull \underfull 是不現實的.

\newdimen\GJ@fontsize
\DeclareOption{18pt}{\GJ@fontsize=17.28pt
\fontsize{\GJ@fontsize}{\baselineskip}\selectfont}
\DeclareOption{24pt}{\GJ@fontsize=24.88pt
\fontsize{\GJ@fontsize}{\baselineskip}\selectfont}
\DeclareOption{36pt}{\GJ@fontsize=35.83pt
\fontsize{\GJ@fontsize}{\baselineskip}\selectfont}
\newif\ifGJ@danbian
\newif\ifGJ@danyuwei
\newif\ifGJ@wusilan
\DeclareOption{danbian}{\GJ@danbiantrue}
\DeclareOption{shuangbian}{\GJ@danbianfalse}
\DeclareOption{danyuwei}{\GJ@danyuweifalse}
\DeclareOption{shuangyuwei}{\GJ@danyuweifalse}
\DeclareOption{wusilan}{\GJ@wusilantrue}
\DeclareOption{zhusilan}{\GJ@wusilanfalse}
\ExecuteOptions{24pt,shuangbian,shuangyuwei,zhusilan}
\ProcessOptions

\LoadClass{book}
\RequirePackage[T1]{fontenc}
\RequirePackage{color}
\RequirePackage{CJK,CJKvert}
\renewcommand{\chapter}[1]{\CJKfamily{kai}\textbf{#1}}
\renewcommand{\section}[1]{#1}
\renewcommand{\CJKglue}{\hskip 5pt plus 0.1\baselineskip}
\parindent=0em


\setlength\textheight{\GJ@fontsize}
\setlength\textwidth{4.9in}
\topskip=0pt
\vsize=\GJ@fontsize
\maxdepth=1000pt
\newdimen\geheight
\newdimen\gewidth
\geheight=\textwidth
\gewidth=\vsize
\advance \gewidth by\baselineskip


\newbox\yuwei
\newdimen\yuweifineness
\yuweifineness=.05pt
\newdimen\yuweineilength \newdimen\yuweiwailength
\yuweineilength=5pt \yuweiwailength=\yuweineilength
\advance \yuweiwailength by \gewidth
\global\setbox\yuwei=\vbox to 2\gewidth{%
{\loop
\hrule width \yuweiwailength height \yuweifineness
\advance\yuweiwailength by -\yuweifineness 
\ifdim \yuweiwailength>\yuweineilength
\repeat}
{\loop
\hrule width \yuweineilength height \yuweifineness
\advance \yuweineilength by \yuweifineness
\ifdim \yuweineilength<\yuweiwailength
\repeat}}

\newbox\jielan
\newdimen\jielanthickness
\jielanthickness=1pt
\newdimen\jielanheight
\advance \baselineskip by \jielanthickness
\jielanheight=.5\baselineskip
\newdimen\jielandepth
\advance \baselineskip by -2\jielanthickness
\jielandepth=-.5\baselineskip
\advance \baselineskip by \jielanthickness
\global\setbox\jielan=\hbox{%
\ifGJ@wusilan
\vrule height \jielanheight depth \jielandepth width \geheight
\else
\textcolor{red}{%
\vrule height \jielanheight depth \jielandepth width \geheight}
\fi}


\def\bankuang#1#2#3{%
\vbox{\hrule height#3pt
\hbox {%
\vrule width#3pt \kern#2pt
\vbox{\kern#2pt #1 \kern#2pt}%
\kern#2pt\vrule width#3pt}
\hrule height#3pt}}
\vfuzz=10000pt
\hfuzz=10000pt
\let\ge=a
\newbox\@tempboxgea \newbox\@tempboxgeb \newbox\@tempboxgec \newbox\@tempboxged \newbox\@tempboxgee
\newbox\@tempboxgef \newbox\@tempboxgeg \newbox\@tempboxgeh \newbox\@tempboxgei \newbox\@tempboxgej \newbox\@tempboxgek
\newbox\@tempboxgel
\output={%
\if a\ge
\global\setbox\@tempboxgea=\vbox to \vsize{\unvbox255}
\global\let\ge=b
\else
\if b\ge
\global\setbox\@tempboxgeb=\vbox to \vsize{\unvbox255}
\global\let\ge=c
\else
\if c\ge
\global\setbox\@tempboxgec=\vbox to \vsize{\unvbox255}
\global\let\ge=d
\else
\if d\ge
\global\setbox\@tempboxged=\vbox to \vsize{\unvbox255}
\global\let\ge=e
\else
\if e\ge
\global\setbox\@tempboxgee=\vbox to \vsize{\unvbox255}
\global\let\ge=f
\else
\if f\ge
\global\setbox\@tempboxgef=\vbox to \vsize{\unvbox255}
\global\let\ge=g
\else
\if g\ge
\global\setbox\@tempboxgeg=\vbox to \vsize{\unvbox255}
\global\let\ge=h
\else
\if h\ge
\global\setbox\@tempboxgeh=\vbox to \vsize{\unvbox255}
\global\let\ge=i
\else
\if i\ge
\global\setbox\@tempboxgei=\vbox to \vsize{\unvbox255}
\global\let\ge=j
\else
\if j\ge
\global\setbox\@tempboxgej=\vbox to \vsize{\unvbox255}
\global\let\ge=k
\else
\if k\ge
\global\setbox\@tempboxgek=\vbox to \vsize{\unvbox255}
\global\let\ge=l
\else
\newbox\banxin \newbox\shuer \newbox\banxinzi \newbox\shuerzi
\global\setbox\banxinzi=\hbox{\vbox to 1.5\GJ@fontsize{\renewcommand{\CJKglue}{\hskip \GJ@fontsize plus .1\baselineskip} \CJKfamily{li}\fontsize{1.5\GJ@fontsize}{\baselineskip}\selectfont {\@title}}}
\global\setbox\shuerzi=\hbox{\renewcommand{\CJKglue}{\hskip \GJ@fontsize plus 0.1\baselineskip} \CJKfamily{fs}\fontsize{0.5\GJ@fontsize}{\baselineskip}\selectfont {\@title}}
\newdimen\heibaikou \newdimen\heibaikouheight \newdimen\heibaikoudepth
\heibaikou=1pt
\advance \gewidth by .5\heibaikou
\heibaikouheight=\gewidth
\advance \gewidth by -\heibaikou
\heibaikoudepth=-\gewidth
\advance \gewidth by .5\heibaikou
\global\setbox\banxin=\vbox{\hrule height \jielanthickness \hbox to \geheight{%
\ifGJ@danyuwei
\vrule height \heibaikouheight depth \heibaikoudepth width .2\geheight \vrule height 2\gewidth
\hskip.01\geheight \vbox{\copy\yuwei}\hskip.01\geheight
\vbox to 2\gewidth{\vfil \box\banxinzi \vfil}\hss
\else
\vrule height \heibaikouheight depth \heibaikoudepth width .2\geheight \vrule height 2\gewidth
\hskip.01\geheight \vbox{\copy\yuwei}
\vbox to 2\gewidth{\vfil \box\banxinzi \vfil}\hss \vrule height 2\gewidth \hskip.01\geheight \vbox{\copy\yuwei}\kern-\yuweiwailength
\advance \yuweiwailength by.2\geheight \vrule height \heibaikouheight depth \heibaikoudepth width \yuweiwailength \advance \yuweiwailength by-.2\geheight
\fi}\hrule height \jielanthickness}
\global\setbox\shuer=\hbox{\kern5pt \vbox{\hbox{%
\vrule height .4\gewidth
\vbox to .4\gewidth{\vfil \box\shuerzi \vfil}
\vrule height .4\gewidth}\hrule}}
\shipout\vbox{%
\ifGJ@danbian
\bankuang{\vbox{%
\vskip.5\baselineskip
\box\@tempboxgea\vss\copy\jielan\vss
\box\@tempboxgeb\vss\copy\jielan\vss
\box\@tempboxgec\vss\copy\jielan\vss
\box\@tempboxged\vss\copy\jielan\vss
\box\@tempboxgee\vss\copy\jielan\vss
\box\@tempboxgef\vskip.5\baselineskip
\vss\box\banxin\vss\vskip.5\baselineskip
\box\@tempboxgeg\vss\copy\jielan\vss
\box\@tempboxgeh\vss\copy\jielan\vss
\box\@tempboxgei\vss\copy\jielan\vss
\box\@tempboxgej\vss\copy\jielan\vss
\box\@tempboxgek\vss\copy\jielan\vss
\vbox to \vsize{\unvbox255}\vskip.5\baselineskip
\global\let\ge=a}}12
\vskip-2pt
\box\shuer
\else
\bankuang{\bankuang{\vbox{%
\vskip.5\baselineskip
\box\@tempboxgea\vss\copy\jielan\vss
\box\@tempboxgeb\vss\copy\jielan\vss
\box\@tempboxgec\vss\copy\jielan\vss
\box\@tempboxged\vss\copy\jielan\vss
\box\@tempboxgee\vss\copy\jielan\vss
\box\@tempboxgef\vskip.5\baselineskip
\vss\box\banxin\vss\vskip.5\baselineskip
\box\@tempboxgeg\vss\copy\jielan\vss
\box\@tempboxgeh\vss\copy\jielan\vss
\box\@tempboxgei\vss\copy\jielan\vss
\box\@tempboxgej\vss\copy\jielan\vss
\box\@tempboxgek\vss\copy\jielan\vss
\vbox to \vsize{\unvbox255} \vskip.5\baselineskip
\global\let\ge=a}}12}35
\vskip-2pt
\box\shuer \fi}
\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi}