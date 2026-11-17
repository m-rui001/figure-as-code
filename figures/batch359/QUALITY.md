# Batch359：降压转换器瞬态波形对比

来源为 Amaral 与 Cardoso 的 Signals 2022 论文（DOI 10.3390/signals3020020），图 12，CC BY 4.0。原图与来源信息见 `source/`。

保留 LTspice 与 Python 两列共八个子图，时间范围 0–0.010 s。按各坐标框每隔约两个像素列提取蓝色笔画中位数，每个子图得到 217 个基础采样点。额外保留六条上升曲线起点附近可辨认的笔画下沿，避免中位数截短陡升段。

目视核对了峰值及衰减趋势、坐标标签和留白。曲线为图像近似，原图笔画厚度和采样间隔限制了对峰值及细纹波的恢复。`validation.json` 与 `text-clearance-validation.json` 均通过。
