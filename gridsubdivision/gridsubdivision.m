% ����obj�ļ� 
obj = readobj('30.obj');

% ��ȡģ�͵Ķ������� 
vertices = obj.v;

% ��ȡģ�͵ı߽�� 
bbox = [min(vertices); max(vertices)];

% ����ģ�͵����ĵ� 
center = mean(bbox);

% ��ģ��ƽ�Ƶ�ԭ�� 
vertices = vertices - center;

% ����һ����ת������y����ת90��
R = [0 1 0; 0 0 1; -1 0 0];

% ��ģ�͵Ķ������������ת���󣬵õ���ת��Ķ�������
vertices = vertices * R;
% ����һ��20m10m10m�Ŀռ� 
zrange = [-300, 300]; 
yrange = [-300, 300]; 
xrange = [-500, 500];

% �Կռ���б߳�Ϊ20m�����������񻮷�
xgrid = xrange(1):20:xrange(2); 
ygrid = yrange(1):20:yrange(2); 
zgrid = zrange(1):20:zrange(2);

% ��ʾ�����ռ仮�ֺ����ά��� 
figure; 
hold on; 
view(3)
axis equal; 
xlabel('x'); 
ylabel('y'); 
zlabel('z');

% ��ʾģ�� 
trisurf(obj.f.v, vertices(:,1), vertices(:,2), vertices(:,3), 'FaceColor', 'r', 'EdgeColor', 'blue');
hold on;
% ��ʾ������ 
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