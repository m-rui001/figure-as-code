# Batch345：LTspice 闭环 Buck 电路

来源：Signals 2022，DOI 10.3390/signals3020020，图 10，CC BY 4.0。
原图及来源信息保存在 `source/`，哈希与标签声明见 `audit-spec.json`。

按原图保留功率级、浮动栅极驱动、续流二极管、输出电容及 ESR、负载、
PI 运放和串联 RC 反馈、比较器、参考源、斜坡脉冲源及两路电源。
元件值和 PULSE 参数逐项核对；网络标签 Vout、Vmais、Vmenos 保留原有连接语义。
原图导线交叉处无连接点的位置保持无连接点。

目视检查中调整 Vsource 标签避开竖向电源线，并加大 220µ 与电容极板间距。
最终 PNG 另行查看确认；模块留白和供电标签位置有所调整。

`python -X utf8 tools/verify_batch.py figures/batch345` 检查原图哈希、标签计数、
源码覆盖、零警告编译、单页、无嵌入位图、文字页界和行长。结果见 `validation.json`。
矢量符号为手工重绘，未运行电路仿真；编译通过不代表全库视觉检查通过。
