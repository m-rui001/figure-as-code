# Batch358：降压转换器稳态波形对比

来源为 Amaral 与 Cardoso 的 Signals 2022 论文（DOI 10.3390/signals3020020），图 11，CC BY 4.0。
原图、链接与哈希见 `source/`。

保留 LTspice 和 Python 两列，每列四幅波形。根据原图各坐标框裁取蓝色笔画，每隔三个像素列取笔画纵坐标的中位数，再按坐标框归一化生成矢量折线。曲线和刻度位置来自图片读数，适合对照图形。峰值和微小纹波受原图分辨率及取样间隔限制。

已目视复查八个子图的曲线形状、相位、刻度和标签。单图验证与直线碰线检查均通过，详见 `validation.json` 和 `text-clearance-validation.json`。
