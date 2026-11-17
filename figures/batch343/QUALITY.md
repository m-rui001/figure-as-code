# Batch343：锯齿波生成器

来源：Amaral 与 Cardoso，Signals 2022，DOI 10.3390/signals3020020，图 9。
原图及下载信息位于 `source/`，原图 SHA256 在 `audit-spec.json` 中。

已查看原图和最终渲染：输入参数、预定义过程侧线、输出波形标签、两个向下箭头、
十四行代码及其缩进层级均已核对。没有观察到标签穿线、裁切或文字重叠。
保留原图代码中对 `np` 的引用，不擅自补入原图没有的 import。

`python -X utf8 tools/verify_batch.py figures/batch343` 全部通过：
原图哈希、源码覆盖、零警告编译、单页、无嵌入位图、文字页界、标签、代码行和行长。
结果及实际源码哈希见 `validation.json`。

字体、节点比例和面板间距有调整；代码仅作为展示文字复原，未作数值算法验算。
