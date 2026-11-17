# Batch339：仿真算法与主流程图

来源：Amaral 与 Cardoso，Signals 2022，DOI 10.3390/signals3020020，图 4 与图 7。
两张完整 PNG 原图位于 `source/`，下载地址和授权信息见 `source/provenance.json`。

## 可重复验证

```powershell
python tools/verify_batch.py figures/batch339
```

`audit-spec.json` 保存原图 SHA256、关键标签计数和图 4 的十行 Python 展示代码。
`validation.json` 记录源码 SHA256、编译结果、单页、零嵌入位图、文本位于页面内、
标签计数、代码行匹配及 120 字符行长检查。检查覆盖本批次全部 `.typ`。
Typst 0.15.1 / CeTZ 0.4.2 编译零错误、零警告。

## 视觉复核（2026-11-17）

已查看两张原图及各自完整渲染，核对：

- 图 4 的双面板、两个平行四边形、预定义过程侧线、两个向下箭头和全部代码行。
- 图 7 的开始/结束、参数输入、PWM Generator、零初值、两个判断节点。
- `CI < TAM` 的 False 分支输出结果并结束；True 分支进入 PWM 判断。
- PWM 判断 True 指向 Conduction Stage，False 指向 Non-Conduction Stage。
- 两个阶段共用下方回路，从第一个判断的底部返回；未擅自添加原图没有的计数步骤。
- 页面无裁切，未观察到文字重叠或连线穿字，箭头均为实心。

## 保真边界

保留原图结构与语义，调整了字体、间距和节点纵横比例。数学变量使用数学字体；
代码面板保持原有字符与运算顺序，作为展示文字，不作为可执行程序验证。
机器检查不能证明流程图的每条边都正确，分支与回路结论来自对原图的视觉核对。
