# Batch355：FusedProp 梯度对比

来源：Apostolou 等，Applied Sciences 2025，DOI 10.3390/app152011207，图 8，CC BY 4.0。
原图与来源信息保存在 `source/`。

已查看原图及最终 PNG。保留 Conventional 面板的两组前向与梯度更新路径，
以及 FusedProp、InvFusedProp 各一组路径。核对四项 z、四项 G/D、两项 L_D/L_G、
四对 theta_G/theta_D、两项乘法节点和 lambda、lambda 的逆。
FusedProp 在生成器梯度支路缩放，InvFusedProp 在判别器梯度支路逆缩放；
两条黑色虚线反馈路径和蓝／粉色梯度路径按原图关系绘制。

回传线与 G/D 主标签错开，分支拐点、乘法节点及系数标签留有间距。
最终图未观察到文字压线或贴框。G/D 模块采用圆角矩形替代原图单侧圆弧形，
渐变简化为纯色，字体、布局比例和局部走线路径有所调整。

`validation.json` 检查数学标签数量、原图哈希、单页、零警告编译、无嵌入位图、
文字页界和行长。`geometry-validation.json` 核对 28 个填充图形。
`text-clearance-validation.json` 未检测到文字片段重叠或与直线描边相交，均通过。
结果绑定源码哈希；碰线检查不覆盖曲线和填充图形，仍需目视复查。
本次复原不包含算法推导、收敛性认证或数值训练验证。
