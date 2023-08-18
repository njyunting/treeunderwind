clc
clear all
% ����txt�����ļ�
Path = 'D:\Desktop\����\wind\Ҷ�Ŵز���\ȥ���\1\';                   % �������ݴ�ŵ��ļ���·��
File = dir(fullfile(Path,'*.txt'));  % ��ʾ�ļ��������з��Ϻ�׺��Ϊ.txt�ļ���������Ϣ
FileNames = {File.name}';            % ��ȡ���Ϻ�׺��Ϊ.txt�������ļ����ļ�����ת��Ϊn��1��

%��ȡ��������
pathName= 'D:\Desktop\����\wind\Ҷ�Ŵز���\ȥ���\1\'
for i=1:15
    fileName =FileNames{i}
    %[fileName,pathName]=uigetfile('*.txt','Input Data-File');
       %ѡ��Ҫ���м������ά���������ļ�·��

    if isempty(fileName) || length(fileName) == 1
        fprintf("δѡ������ļ���\n");
        return;
    end

    Data=importdata([pathName,fileName]);   %���ص�������
    Data=Data(:,1:3);     %ȡ���ݵ�һ������

    X=Data(:,1);
    Y=Data(:,2);
    Z=Data(:,3);
    fprintf("��ʼ����͹��...\n");
    [K,~] = convhull(X,Y,Z);          %��ȡ���Ƶ�͹����
    fprintf("͹�������ɹ���\n");
    indexs = unique(K(:));
    convexPoint = Data(indexs,:);      %��ȡ͹����
    fprintf("��ʼ���������Բ���...\n");
    [A, center] = MinVolEllipseV1(convexPoint',0.01);       %��������С���Ի�ø�Ϊ׼ȷ�������Բ��������Ҳ��Ӱ�쵽����ʱ��
    fprintf("��Ͻ�����\n");

    [U,S,V] = svd(A);     %����ֵ�ֽ�,�����V�е�����
    r1 = 1/sqrt(S(1,1));      %�뾶
    r2 = 1/sqrt(S(2,2));
    r3 = 1/sqrt(S(3,3));
    DrawEllipseV1(center,r1,r2,r3,V');
    Ve = (4/3)*pi*(r1*r2*r3);
    S = 4*pi*(r1*r2*r3)^(2/3);
    fprintf("�������꣺��%f,%f,%f��\nr1��%f\nr2��%f\nr3��%f\n������������%f\n�������������%f\n"...
        ,center(1),center(2),center(3),r1,r2,r3,Ve,S);
    hold on
    grid on
    rotate3d on
    plot3(Data(:,1),Data(:,2),Data(:,3),'.');
end
pathName='D:\Desktop\����\wind\֦Ҷ��������ľ����\��������ľ����\'
fileName='0hz_1_����.txt'
Data=importdata([pathName,fileName])
plot3(Data(:,1),Data(:,2),Data(:,3),'.');


