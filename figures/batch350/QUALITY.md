# Batch350：ConvFormer 与 EfficientNet-B0

来源：Dimitrovski 等，Remote Sensing 2024，DOI 10.3390/rs16122077，图 3、4。
原图和 CC BY 4.0 来源信息见 `source/`。

已查看原图及最终 PNG。ConvFormer 保留四次下采样、L1–L4 重复标记、四个主块，
以及展开块中的两项归一化、可分离卷积、Channel-MLP、两个加法节点和两条残差连接。
为两条残差支路与外框顶部留出间距，连接线在模块框外分段绘制，避免穿过模块文字。

EfficientNet-B0 保留输入卷积和七组 MBConv，组内数量分别为 1、2、2、3、3、5、1。
核对 MBConv1 的一项 3×3、MBConv6 的六项 3×3 与十项 5×5，共 18 个主体条。
原图的组标签由竖排改为横排，图层条内部文字继续采用竖排；渐变简化为纯色。

`validation.json` 记录原图哈希、全部声明标签计数、单页、零警告编译、
无嵌入位图、文字页界和源码行长。`geometry-validation.json` 核对填充图形数量。
`text-clearance-validation.json` 检查文字片段重叠及文字与直线描边相交，均通过。
上述结果绑定实际源码哈希；碰线检查不覆盖曲线、填充图形，也不能替代目视复查。
