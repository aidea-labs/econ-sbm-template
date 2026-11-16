# Econ Submission Templates
中文经济学类期刊 LaTeX 投稿模版

James and Kjorstad (2026) 认为使用 LaTeX 可能提高经济学家对论文研究质量的主观评价。
LaTeX 似乎天然就更适合排版，且我们可以发现它在给定模版的情况下可以轻松地切换到其他期刊。
但由于大部分的中文期刊都不提供 LaTeX 模版，因此我们做了该项目，旨在可以让研究者可以省去排版的苦恼。

> 该项目的模版由 AIdea-Labs 团队基于期刊提供的投稿规范整理制作，非期刊官方制作。

## 模版目录

| 期刊 | 模版 | 投稿体例 |
|---|---|---|
| 审阅模式（适合编写） | `templates/edit.cls` | 参考 [AIdea-Labs](https://github.com/aidea-labs/paper-template) 和 [AER](https://www.aeaweb.org/journals/templates) 的排版设计 |
| 《财经研究》 | `templates/财经研究.cls` | [投稿指南](https://qks.sufe.edu.cn/J/CJYJ/Menu/25) |
| 《经济学》（季刊） | `templates/经济学季刊.cls` | [《经济学》（季刊）投稿体例](https://nsd.pku.edu.cn/xzyj/cbw/jjxjk/tgzg/250625.htm) |
| 《经济研究》 | `templates/经济研究.cls` | [稿件体例要求](https://se.ucass.edu.cn/system/_content/download.jsp?owner=1549353323&urltype=news.DownloadAttachUrl&wbfileid=16001176) |
| 《金融研究》 | `templates/金融研究.cls` | [投稿指南](https://www.jryj.org.cn/CN/column/item74.shtml) |
| 《世界经济》 | `templates/世界经济.cls` | [投稿须知](https://sjjj.magtech.com.cn/CN/column/column6.shtml) |
| 《中国工业经济》 | `templates/中国工业经济.cls` | [投稿（修改）指南](https://ciejournal.ajcass.com/UploadFile/SiteResource/zqnj5npp.pdf) |

## 快速开始

### 1. 获取项目

如果你有 GitHub 账号，可以[使用该模板](https://github.com/new?template_name=econ-sbm-template&template_owner=aidea-labs)创建自己的论文仓库，再将新仓库克隆到本地。
如果暂时不想创建 GitHub 账号，也可以直接克隆公开项目：

```bash
git clone https://github.com/aidea-labs/econ-sbm-template.git
cd econ-sbm-template
```

### 2. 填写论文内容

进入项目目录后，打开 `main.tex`，填写论文标题、作者、摘要和关键词。
正文可以直接写在 `main.tex` 中，也可以像本项目一样，将引言、相关工作等部分放在 `sections/` 目录中，再通过 `\input{...}` 按顺序引入。
参考文献信息放在 `ref.bib`，图片可以放在 `figs/` 目录中。

### 3. 选择模板

修改 `main.tex` 的第一行即可选择模板。
例如，写作和讨论时可以使用审阅模式：

```latex
\documentclass{edit}
```

投稿时，可以按照上方模板目录选择目标期刊，例如：

```latex
\documentclass{经济研究}
```

切换模板后，请根据期刊要求检查作者信息、摘要、关键词和其他投稿字段；匿名稿还需要检查正文、图表及附录中的身份信息。

### 4. 编译论文

本地需要安装包含 XeLaTeX、`latexmk` 和 Biber 的 LaTeX 环境，以及项目使用的宏包。
在项目目录中运行：

```bash
latexmk
```

`latexmk` 会读取项目中的 `latexmkrc`，使用 XeLaTeX 编译 `main.tex`，并在需要时调用 Biber 处理参考文献。
编译完成后，打开生成的 `main.pdf` 查看效果。

macOS、Linux 或其他支持 Bash 的环境中，也可以使用项目提供的脚本：

```bash
./scripts/compile.sh  # 编译论文
./scripts/clean.sh    # 清理中间文件和 Biber 缓存，保留 PDF
```

如果编译出错，可以先查看日志，或请 AI Agent 协助检查环境和报错；修改后重新编译即可。

