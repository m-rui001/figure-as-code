# Batch334 质量复核

来源：Amaral 与 Cardoso，*Using Python for the Simulation of a Closed-Loop PI
Controller for a Buck Converter*，Signals 2022，DOI: 10.3390/signals3020020，图 1–3。
原图、下载地址及 SHA256 保存在 `source/`。

## 验证结果（2026-11-17）

- 三张图均通过 Typst 0.15.1 / CeTZ 0.4.2 的 PNG 和 PDF 编译，零警告。
- PDF 均为单页、零嵌入位图；源码最长 84 字符。机器检查结果见 `validation.json`。
- 已分别查看三张原图和最终渲染，逐项核对元件、极性、支路及电流箭头方向。
- 总电路保留 M、Di、L、C、R_Load 和 V_in，二极管阴极朝向上方开关节点。
- 导通图保留 R_L + R_S、V_in、ESR；关断图保留 R_L + R_d、V_d、ESR。
- i_L 与 i_O 向右、i_C 向下；输出电压指示在右侧，未穿过标签。
- 复核后修正了首版误穿电源圆圈的连线及竖排标签方向，并重新编译、查看。

## 保真边界

这是结构重绘。字体、线宽、元件纵横比例与原图不同；变量改用数学字体，
输出电压指示的曲线以两段直线近似。未宣称像素级复原或自动拓扑等价证明。
原图用于对照，不作为转换结果嵌入源码。
