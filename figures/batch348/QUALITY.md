# Batch348：应用领域与推荐系统

来源：Chen 与 Guo，Mathematics 2023，DOI 10.3390/math11081777，图 6、7。
原图及 CC BY 4.0 来源记录见 `source/`。

已查看两张原图和最终 PNG。应用领域图核对五个主分支、计算机视觉的三个子分支、
图像与视频处理的八项任务、模式识别的三项任务、其他应用的四项任务及省略号。
保留 Other Applications 与其子任务的连接，不将其误接到 Data Generation。

推荐系统图核对三个输入、两类模型、三项建模方法、用户和物品的两项潜在表示，
以及推荐列表输出。两列模型标题留出独立宽度；输入合流和输出分流均避开文字框。
原图的 Auxiliary 单词内部空格合并；字体、颜色细节和布局间距有所调整。

`validation.json` 记录全部声明标签、原图哈希、单页、零警告编译、无嵌入位图、
文字页界和源码行长，全部通过。
运行 `python -X utf8 tools/verify_text_clearance.py figures/batch348`，未发现文字片段重叠
或文字包围盒与直线描边相交。结果绑定源码哈希，见 `text-clearance-validation.json`。
该检查使用内缩 1pt 的文字边界，不检查曲线和填充图形，不能替代目视复查。
