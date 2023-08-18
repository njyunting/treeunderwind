clc
clear all
% 读入txt点云文件
Path = 'D:\Desktop\南林\wind\叶团簇部分\去噪点\1\';                   % 设置数据存放的文件夹路径
File = dir(fullfile(Path,'*.txt'));  % 显示文件夹下所有符合后缀名为.txt文件的完整信息
FileNames = {File.name}';            % 提取符合后缀名为.txt的所有文件的文件名，转换为n行1列

%获取点云数据
pathName= 'D:\Desktop\南林\wind\叶团簇部分\去噪点\1\'
for i=1:15
    fileName =FileNames{i}
    %[fileName,pathName]=uigetfile('*.txt','Input Data-File');
       %选择要进行计算的三维点云数据文件路径

    if isempty(fileName) || length(fileName) == 1
        fprintf("未选择点云文件！\n");
        return;
    end

    Data=importdata([pathName,fileName]);   %加载点云数据
    Data=Data(:,1:3);     %取数据的一到三列

    X=Data(:,1);
    Y=Data(:,2);
    Z=Data(:,3);
    fprintf("开始构建凸包...\n");
    [K,~] = convhull(X,Y,Z);          %获取点云的凸包面
    fprintf("凸包构建成功！\n");
    indexs = unique(K(:));
    convexPoint = Data(indexs,:);      %获取凸包点
    fprintf("开始进行外接椭圆拟合...\n");
    [A, center] = MinVolEllipseV1(convexPoint',0.01);       %设置误差大小可以获得更为准确的外接椭圆，但是这也会影响到计算时间
    fprintf("拟合结束！\n");

    [U,S,V] = svd(A);     %奇异值分解,这里的V有点问题
    r1 = 1/sqrt(S(1,1));      %半径
    r2 = 1/sqrt(S(2,2));
    r3 = 1/sqrt(S(3,3));
    DrawEllipseV1(center,r1,r2,r3,V');
    Ve = (4/3)*pi*(r1*r2*r3);
    S = 4*pi*(r1*r2*r3)^(2/3);
    fprintf("球心坐标：（%f,%f,%f）\nr1：%f\nr2：%f\nr3：%f\n外接椭球体积：%f\n外接椭球表面积：%f\n"...
        ,center(1),center(2),center(3),r1,r2,r3,Ve,S);
    hold on
    grid on
    rotate3d on
    plot3(Data(:,1),Data(:,2),Data(:,3),'.');
end
pathName='D:\Desktop\南林\wind\枝叶分离后的树木点云\分离后的树木点云\'
fileName='0hz_1_树干.txt'
Data=importdata([pathName,fileName])
plot3(Data(:,1),Data(:,2),Data(:,3),'.');


