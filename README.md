# Figure as Code · 图即代码

Paper figures compressed into compilable **Typst/CeTZ** source. Every line maps to coordinates, layering, symbols and connections in the drawing — a corpus for teaching LLMs the spatial relations inside images, aimed at AI-assisted research, engineering design and CAD.

论文插图压缩成可编译的 Typst/CeTZ 源码：坐标、层级、符号与连接关系都由代码显式写出。目标是为大模型提供「图—文—坐标」对齐语料，让模型学会图像里的空间关系，未来辅助科研绘图、工程设计与 CAD。

![spatial relations](assets/preview-spatial.png)

*平行六面体：向量合成、虚线隐藏边、夹角 φ 与高度关系全部由坐标和线段写出。*

![system layout](assets/preview-system.png)

*LSTM-DDPG 框架：模块边界、数据流方向与更新路径由方框坐标和带箭头的连线表达。*

## 为什么做这个

- 位图对语言模型是不透明的；代码把「谁在谁上方、谁连到谁、夹角朝哪边」变成可读的 token。
- 每个图是一份对齐样本：英文标签逐字保留，中文注释只解释结构关系，不替代标签。
- 可用于训练/评测空间理解、图生代码模型微调，或作为科研绘图检索与复用语料。

## 内容

- `figures/batchNN/typ/*.typ`：462 个自包含图文件（327 个批次；另有 2 个图元测试在 `assets/tests/`）。
- 以线稿与示意图为主：几何、向量、物理、控制框图、推进系统、材料机理、AI 网络架构。
- 统一依赖 Typst 0.15.1 与 CeTZ 0.4.2，文件首部即页面与依赖设置。
- 一个文件一张图，标签与论文原图一致，不使用外部图片资源。

## 编译

```bash
typst compile figures/batch24/typ/fig74-parallelepiped.typ out.png --ppi 300
typst compile figures/batch291/typ/lstm-ddpg-framework.typ out.pdf
```

## 全量校验

```bash
python tools/compile_all.py --jobs 4
```

当前 **462/462** 编译成功，0 失败；36 条字体 warning 记录在 `MANIFEST.csv`，详见 [QUALITY.md](QUALITY.md)。

## 目录

```
figures/batchN/typ/*.typ   # 单图源码，一个文件即完整图
assets/                    # 通用图元源码与 README 预览图
tools/compile_all.py       # 全量编译闸门 + MANIFEST.csv 生成
MANIFEST.csv               # 每图编译状态、警告、sha1、字节数
QUALITY.md                 # 编译统计与已知边界
```

## 质量检查

- 渲染后先做文字重叠 / 线条穿字的脚本筛查，再做视觉复核。
- 箭头尖一律实心；虚线只作用于线身，不作用于箭头。
- 标签压线时移动标签或留出断线留白，不用白块盖住结构线。

## 版权

- 重绘源码以 MIT 许可发布（见 `LICENSE`）。
- 原始插图版权归各论文作者所有，本仓库仅用于研究与教学。

## 新增转换与视觉复核（2026-11-24）

batch362–371 新增 10 张自包含 CeTZ 矢量图：DDS 接收机忙期、液压张力控制、热轧数字孪生、并网逆变器、ORC 温熵图、线材定向能量沉积流程、GMAW 焊枪、冷却塔群、LNG 冷能存储与释放、双电机控制架构。

- 原图、DOI、许可与 SHA256 保存在各批次 `source/provenance.json`。
- 全量编译 454/454 通过；36 条警告均为既有字体警告，新增 10 图零警告。
- 新增图均通过结构、文字净空、风格与独立重叠检查；batch370 的流号 1–58 逐行独立提取通过。
- 逐图验收记录见各批次 `QUALITY.md`。

## 新增转换与视觉复核（2026-11-25）

batch372–379 新增 8 张自包含 CeTZ 矢量图：机器人仿真验证、CNC 工艺优化流程、MomentumNet-CD 与 DAQ、电池液冷传热、多能源系统、双用途太阳能集热器、神经元 PID 伺服控制、智能产线数字孪生。

- 原图、DOI、CC BY 4.0 许可与 SHA256 保存在各批次 `source/provenance.json`；本轮 DOI 与图号无重复。
- 8 图全部通过结构、文字净空、风格和独立重叠检查，标准 PNG/SVG 预览与最终源码同步。
- 逐图二审直接对照源图与最终渲染：372、376 无新增实质偏差；373 校正 No 横排，374 校正公式与 DAQ 端口，375 校正半椭圆接线片，377 恢复 2×2 版式并删除重复总览，378 恢复积分符号，379 校正外层路由与层间箭头。
- 当前全量编译 462/462 通过；36 条警告均为既有字体警告，新增 8 图零警告。
- 逐图验收记录见 batch372–379 的 `QUALITY.md`；编译通过不等同于全库视觉认证。
- 2026-11-25 扩大复查已对照源图、PNG 与 PDF 路径修复 batch362–379 中的坐标域、拓扑、箭头方向、框内溢出和贴线标签；详见 [QUALITY.md](QUALITY.md) 的扩大复查记录。
