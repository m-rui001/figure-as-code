# Batch344：PI 与 PWM 控制电路

来源：Amaral 与 Cardoso，Signals 2022，DOI 10.3390/signals3020020，图 8。
原图、下载地址和许可记录在 `source/`，原图 SHA256 记录在 `audit-spec.json`。

已查看最终 PNG，逐项检查 PI 反馈支路、R1/R2 阻值、电容值、参考电压极性、
比较器输入极性、锯齿波输入和驱动器输出。下移 Model / Saw tooth 标签，
为波形框保留间距；最终图未观察到文字与线条或边框重叠。连接线穿过模块边框
表示输入输出连接，保留原图拓扑。

`python -X utf8 tools/verify_batch.py figures/batch344` 全部通过：
原图哈希、源码覆盖、零警告编译、单页、无嵌入位图、文字页界、声明标签和行长。
机器结果及实际源码哈希见 `validation.json`。

采用可编辑 CeTZ 矢量重绘，字体和布局间距有所调整；未进行电路数值仿真。
