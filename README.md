# 欢迎使用中国计量大学 LaTeX 论文模板

目前仅支持本地编译，暂不支持 Overleaf。

## 本地编译

1. 安装 `TeXLive 2020` 工具包。
2. 修改 `main` 文件夹内的内容，详细教程已经写入 `main.pdf`
3. 用 TeXstudio 打开 `main.tex` ，点击 ` 构建并查看 `。

## 注意

1. 仅支持本科 + 非盲审。不能保证 100% 合规，如果你的专业或导师对论文有特殊要求，请自行修改。

2. 生成最终稿时推荐使用四次编译（复杂编译）：

   ```bash
   xelatex main.tex
   bibtex  main.aux
   xelatex main.tex
   xelatex main.tex
   ```


## 版权声明

本项目采用 GPL 协议。

GPL 协议的主要内容是只要在一个软件中使用（“使用” 指类库引用，修改后的代码或者衍生代码）GPL 协议的产品，则该软件产品必须也采用 GPL 协议，既必须也是开源和免费。