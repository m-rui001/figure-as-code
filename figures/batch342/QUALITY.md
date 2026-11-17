# Batch342：关断阶段与 PWM 算法

来源：Amaral 与 Cardoso，Signals 2022，DOI 10.3390/signals3020020，图 5、6。
原图保存在 `source/`，下载地址和 CC BY 4.0 归属记录见 `source/provenance.json`。

已逐张查看原图与最终渲染，核对输入/输出、过程框侧线、向下实心箭头、双面板和代码。
关断阶段保留负的 Vd 项及 Rl + Rd；PWM 代码保留两层 if、两个 else、索引和更新行。
PWM 原图过程文字写 DF，参数和代码写 DC；此处忠实保留该不一致，不作推断修订。

```powershell
python -X utf8 tools/verify_batch.py figures/batch342
```

两图检查全部通过：原图 SHA256、源码全覆盖、零警告编译、单页、无嵌入位图、
文本位于页面内、关键标签计数、全部代码行及最长 120 字符检查。
具体源码哈希和结果见 `validation.json`。

字体、节点比例和间距有调整，代码缩进以可读层级呈现，未观察到裁切或文字穿线。
这是图文结构重绘，代码作为展示内容保留，未宣称算法运行正确或像素级一致。
