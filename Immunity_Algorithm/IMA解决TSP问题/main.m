%清空命令窗口和内存
clear
clc
N=20;               
%城市的个数
M=N-1;               
%种群的个数
pos=randn(N,2);
%%生成城市的坐标
global D;
%城市距离数据
D=zeros(N,N);
for i=1:N
    for j=i+1:N
        dis=(pos(i,1)-pos(j,1)).^2+(pos(i,2)-pos(j,2)).^2;
        D(i,j)=dis^(0.5);
        D(j,i)=D(i,j);
    end
end

%中间结果保存
global TmpResult;
TmpResult = [];
global TmpResult1;
TmpResult1 = [];

%参数设定
[M, N] = size(D);%集群规模
pCharChange = 1;%字符换位概率
pStrChange = 0.4;%字符串移位概率
pStrReverse = 0.4;%字符串逆转概率
pCharReCompose = 0.4;%字符重组概率
MaxIterateNum = 100;%最大迭代次数

%数据初始化
mPopulation = zeros(N-1,N);
mRandM = randperm(N-1);%最优路径
mRandM = mRandM + 1;
for rol = 1:N-1
    mPopulation(rol,:) = randperm(N);%产生初始抗体
    mPopulation(rol,:) = DisplaceInit(mPopulation(rol,:));%预处理
end

%迭代
count = 0;
figure(2);
while count < MaxIterateNum
    %产生新抗体
    B = Mutation(mPopulation, [pCharChange pStrChange pStrReverse pCharReCompose]);
    mPopulation = SelectAntigen(mPopulation,B);
    hold on
    plot(count,TmpResult(end),'o');
    drawnow
    display(TmpResult(end));
    display(TmpResult1(end));
    best_pop(count + 1, :) = mPopulation(1, :);
    count = count + 1;
end

hold on
plot(TmpResult,'-r');
title('最佳适应度变化趋势')
xlabel('迭代数')
ylabel('最佳适应度')
figure(1)
DrawRouteGif(pos, best_pop);