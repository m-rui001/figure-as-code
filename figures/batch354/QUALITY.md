# Batch354：GAN 计算结构与 CPGAN

来源：Apostolou 等，Applied Sciences 2025，DOI 10.3390/app152011207，图 7、9，CC BY 4.0。
原图及下载信息见 `source/`。

已对照原图查看最终 PNG。图 7 核对真实数据输入 a、噪声输入 b、生成数据输入 c、
判别器至 Diff-Block 的 d、返回判别器的 e、返回生成器的 f。
Control Unit 按原图独立显示，不擅自补画控制线；真实数据为三张色块，云形用六个矢量椭圆重绘。

图 9 核对 X→G(X)→Z 和 Service、Attacker 两条分流及其输出。
原图服务模块写作 S(X)，本次保留，不按模型语义猜改为 S(Z)。
为 Utility Prediction Y 和 Reconstruction X′ 输出说明预留间距。
原图弯曲分流改为直角分流，模块圆角、字体与布局比例有所调整。

`validation.json` 核对声明标签、原图哈希、零警告编译、单页、无嵌入位图、文字页界和行长。
`geometry-validation.json` 核对两图 13/5 个填充图形，以及 a–f、X、Z 独立标签的单次出现。
`text-clearance-validation.json` 未检测到文字片段重叠或与直线描边相交，均通过。
结果绑定源码哈希；碰线检查不覆盖曲线与填充图形，仍需目视复查。
最终图未观察到文字压线或贴框；本次复原不包含计算硬件实现或隐私保障验证。
