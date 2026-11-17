# 质量报告 · Figure as Code

## 规模

- 图文件：**414** 个 `.typ`，分布在 **287** 个 batch；另有 2 个图元测试在 `assets/tests/`，不进入语料清单。
- 依赖：Typst 0.15.1、CeTZ 0.4.2；每图自包含，无外部图片资源。

## 编译门槛

```bash
python tools/compile_all.py --jobs 4
```

当前结果（2026-11-17）：

```
{"figures": 414, "compiled": 414, "failed": 0, "warnings": 36}
```

- 414/414 编译成功，0 失败。
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
