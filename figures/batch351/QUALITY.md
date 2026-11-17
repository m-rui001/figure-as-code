# Batch351：MaxViT 与集成训练流程

来源：Dimitrovski 等，Remote Sensing 2024，DOI 10.3390/rs16122077，图 2、5。
原图及 CC BY 4.0 来源信息保存在 `source/`。

已对照原图查看最终 PNG。MaxViT 保留 224×224 输入、双卷积 Stem、S1–S4 重复标记、
112/56/28/14/7 分辨率和 1×1 Head。展开块保留 MBConv、Block Attention、
Grid Attention、五条残差支路、五个加法节点、SE 和两项 FFN。

集成流程保留训练和测试分流、三个初始模型与三个训练后模型、三条训练箭头，
以及三个预测经几何平均产生最终预测的路径。分隔线在训练箭头处断开，
避免横线压住竖排 Training 标签；测试支路和阶段说明均避开文字。
原图图面写作 ConvFormer-M3，正文与图注使用 M36，本次忠实保留图面 M3，未擅改。

`validation.json` 核对标签、原图哈希、单页、零警告编译、无嵌入位图、文字页界和行长。
`geometry-validation.json` 核对两图分别 18 和 23 个填充图形（含数据圆柱构件与箭头）。
`text-clearance-validation.json` 检查文字片段重叠及文字与直线描边相交，均通过。
结果绑定源码哈希；碰线检查不覆盖曲线和填充图形，需结合目视检查。
渐变改为纯色，字体、模块比例及走线路径有所调整，未执行模型训练。
