% 导入obj文件 
obj = readobj('30.obj');

% 获取模型的顶点坐标 
vertices = obj.v;

% 获取模型的边界框 
bbox = [min(vertices); max(vertices)];

% 计算模型的中心点 
center = mean(bbox);

% 将模型平移到原点 
vertices = vertices - center;

% 创建一个旋转矩阵，绕y轴旋转90度
R = [0 1 0; 0 0 1; -1 0 0];

% 将模型的顶点坐标乘以旋转矩阵，得到旋转后的顶点坐标
vertices = vertices * R;
% 创建一个20m10m10m的空间 
zrange = [-300, 300]; 
yrange = [-300, 300]; 
xrange = [-500, 500];

% 对空间进行边长为20m的正方体网格划分
xgrid = xrange(1):20:xrange(2); 
ygrid = yrange(1):20:yrange(2); 
zgrid = zrange(1):20:zrange(2);

% 显示整个空间划分后的三维结果 
figure; 
hold on; 
view(3)
axis equal; 
xlabel('x'); 
ylabel('y'); 
zlabel('z');

% 显示模型 
trisurf(obj.f.v, vertices(:,1), vertices(:,2), vertices(:,3), 'FaceColor', 'r', 'EdgeColor', 'blue');
hold on;
% 显示网格线 
for x = xgrid 
    plot3([x, x], yrange, [zrange(1), zrange(1)], 'k'); 
    plot3([x, x], yrange, [zrange(2), zrange(2)], 'k'); 
    plot3([x, x], [yrange(1), yrange(1)], zrange, 'k'); 
    plot3([x, x], [yrange(2), yrange(2)], zrange, 'k'); 
end

for y = ygrid 
    plot3(xrange, [y, y], [zrange(1), zrange(1)], 'k');
    plot3(xrange, [y, y], [zrange(2), zrange(2)], 'k'); 
    plot3([xrange(1), xrange(1)], [y, y], zrange, 'k'); 
    plot3([xrange(2), xrange(2)], [y, y], zrange, 'k');
end

for z = zgrid 
    plot3(xrange, [yrange(1), yrange(1)], [z, z], 'k'); 
    plot3(xrange, [yrange(2), yrange(2)], [z, z], 'k'); 
    plot3([xrange(1), xrange(1)], yrange, [z, z], 'k'); 
    plot3([xrange(2), xrange(2)], yrange, [z, z], 'k'); 
end

hold off;