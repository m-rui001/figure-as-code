# 质量报告 · Figure as Code

## 规模

- 图文件：**444** 个 `.typ`，分布在 **304** 个 batch；另有 2 个图元测试在 `assets/tests/`，不进入语料清单。
- 依赖：Typst 0.15.1、CeTZ 0.4.2；每图自包含，无外部图片资源。

## 编译门槛

```bash
python tools/compile_all.py --jobs 4
```

当前结果（2026-11-17）：

```
{"figures": 444, "compiled": 444, "failed": 0, "warnings": 36}
```

- 444/444 编译成功，0 失败。
- 36 条 warning 为字体提示，集中在 3 个文件：
  - `figures/batch221/typ/adhesive-capture-mechanism.typ`：`liberation serif` 不存在。
  - `figures/batch63/typ/gt017-triangulation.typ`、`gt022-threegraphs.typ`：正文数学 `$...$` 的当前字体不是数学字体，渲染可能偏差。
- 这些 warning 不阻断编译；为保证版面视觉未被脚本改动，暂不改字体，保留在 `MANIFEST.csv` 的 `warnings` / `warning_sample` 字段。

## 清单

`MANIFEST.csv` 每行一图：`path, batch, sha1, bytes, compile, warnings, warning_sample`。由 `tools/compile_all.py` 生成，可重跑。

## 已知边界

- 编译成功不等于视觉正确：文字重叠、箭头穿越、留白仍需按 README 的人工视觉复核流程检查。
- 原论文插图版权归各作者；本仓库只对重绘源码主张 MIT。

## Typst 源码风格

在 `style-typst` 分支完成（标准 `tools/TYPST_STYLE.md`，量具 `tools/style_audit.py`）。
403 个文件（新增 42 图均按 ≤120 字符与零横幅标准书写）：装饰横幅 496→0，>120 字符行保持 361（既有图各留一条 `#figure(...)` 调用，新增 42 图无超长行），
裸 LaTeX 30→28（剩余全在 `//` 注释），`$\hat(e)_r$` 等 2 处改为 Typst 语义符号。
逐项读数与剩余项判定见 [STYLE_AUDIT.md](STYLE_AUDIT.md)。编译门槛不变：361/361，0 失败。

## 新增转换与视觉复核（2026-11-17）

新增 3 个批次、5 张图，均保留原图和来源，均通过单页、零嵌入位图、零编译警告检查。

- [batch334](figures/batch334/QUALITY.md)：降压变换器电路及导通/关断等效电路，共 3 张。
- [batch335](figures/batch335/QUALITY.md)：Scaled Dot-Product / Multi-Head Attention 双面板，共 1 张。
- [batch336](figures/batch336/QUALITY.md)：Transformer 编码器与解码器总体架构，共 1 张。

新增图已逐张对照原图复核，记录了修复项及字体、间距、曲线等保真边界。
此结论仅覆盖新增 5 张图；既有 403 张的全量编译通过不能替代视觉复核。

## 第二轮新增（2026-11-17）

新增 3 个批次、6 张图，均保留原图并完成视觉对照，新增图编译零警告。

- [batch337](figures/batch337/QUALITY.md)：模拟 PID 反馈环与数字 PID 内部结构。
- [batch338](figures/batch338/QUALITY.md)：ResNet 残差块及基本块/瓶颈块对照。
- [batch339](figures/batch339/QUALITY.md)：导通阶段算法双面板及仿真主流程图。

三个批次均可使用 `python -X utf8 tools/verify_batch.py figures/batchNNN` 重跑验证。
`audit-spec.json` 声明原图哈希和标签；`validation.json` 记录实际源码哈希和检查结果。
新增 6 张均通过全部源码覆盖、单页、零位图、页内文字及标签检查。
全量结果为 414/414，通过编译，36 条既有字体 warning；视觉结论只覆盖已复核图。

## 第三轮进度（2026-11-17）

[batch342](figures/batch342/QUALITY.md) 新增关断阶段算法与 PWM 生成器两张双面板图。
原图已下载，视觉复核和可重复机器检查全部通过，新增图零编译警告。
本轮全量编译结果：416/416，零失败，36 条既有字体警告。
batch340 与 batch341 后续已完成，当前语料总量为 444 张、304 个批次。

## 文字碰撞专项复查

用户反馈文字与线条、边框重叠后，暂停新增图，优先复查已有图。
batch204–339 已分组查看实际渲染（不存在的批次跳过）；batch282–287 的部分小公式仍待深入复核。
具体修复涉及标签偏移、框内留白、连线路径以及中心线断开留白，未用白块遮盖结构线。
记录见 batch260、264、273、279、287、292、299、300、306–333 及337 的 `COLLISION_REVIEW.md`。
batch341 的局部注意力 `p_t` 标签碰线也已修正并重跑验证。

444/444 是编译结果，不是全库视觉无碰撞的证明；未复查批次仍需继续检查。

batch259–281 的23张图已补充机器复验：单页、零警告、文字在页面内，
与 HEAD 的非空白字符计数全部一致。实际源码 SHA256 和逐图结果见
`COLLISION_VALIDATION.json`。改动图的最终 PNG 已保存在各批次 `render/`。
字符计数不能证明标签顺序、连接拓扑或视觉无碰撞。

可使用 `python -X utf8 tools/verify_collision_changes.py` 复验相对 HEAD 改动的已有图。
该工具逐图比较非空白字符计数、检查单页和页内文字，并从实际源码重新生成200-ppi预览。
结果写入 `COLLISION_CHANGES_VALIDATION.json`，包含基线提交、源码和预览 SHA256。
这项机器验证与上述逐组视觉记录分开，不宣称自动识别文字碰线。
本次50张改动图全部通过上述检查，最新预览已与验证时源码对应。

## batch362–371 验收（2026-11-24）

本轮新增 10 张图，当前语料为 454 张、319 个批次。来源覆盖 2024–2025 年工业、能源、制造与控制领域论文，原图许可均为 CC BY 4.0，来源信息保存在各批次 `source/provenance.json`。

- 全量编译闸门：454/454，零失败；36 条既有字体警告，新增图零警告。
- 新增 10 图全部通过 `verify_batch.py`、`verify_text_clearance.py`、`style_audit.py` 和独立重叠审计。
- batch363 的 K1–K19 与引线 1–37、batch370 的流号 1–58 均做精确 PDF 文本行复核。
- batch367–371 的标签穿线、箭头方向、嵌套边界、电缆轮廓与文字合并问题已由主代理修复后复验。
- 自动净空检查只覆盖直线与文本边界；结论不等同于全库视觉无碰撞，后续批次继续逐图对照原图。
