clear;
clc;
G=[0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1; 
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1; 
   1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;];
mm = size(G, 1);
Tau = 8. * ones(mm^2, mm^2);
epochs = 100;  % 迭代次数
ants = 50;  % 蚂蚁数量
start = 1;
stop = 9 * 20 + 10;
alpha = 1;
beta = 7;
rho = 0.3;
q = 1;  % 信息素增强系数
minkl = inf;
mink = 0;
minl = 0;
D = G2D(G);
n = size(D, 1);
stop_x = mod(stop, mm) - 0.5;
if stop_x == - 0.5
    stop_x = mm - 0.5;
end
stop_y = mm + 0.5 - ceil(stop / mm);
% 启发式信息 遍历所有节点
Eta = zeros(n);
for i = 1: n
   ix =  mod(i, mm) - 0.5;
   if ix == - 0.5
       ix = mm - 0.5;
   end
   iy = mm + 0.5 - ceil(i / mm);
   if i ~= stop
       Eta(i) = 1/((ix - stop_x)^2 + (iy - stop_y)^2)^0.5;
   else
       Eta(i) = 100;
   end
end
ROUTES = cell(epochs, ants);
Distance = zeros(epochs, ants);
%% 开始迭代
for epoch = 1: epochs
    for ant = 1: ants
        current = start;
        Path = start;
        DisKm = 0;
        TABUkm = ones(n);
        TABUkm(start) = 0;
        DD = D;
        DW = DD(current, :);
        DW1 = find(DW);
        for j = 1: length(DW1)
            if TABUkm(DW1(j)) == 0
                DW(DW1(j)) = 0;
            end
        end
        LJD = find(DW);
        Len_LJD = length(LJD);
        while current ~= stop && Len_LJD >= 1
            PP = zeros(Len_LJD);
            for i = 1: Len_LJD
                PP(i) = (Tau(current, LJD(i))^alpha) * (Eta(LJD(i))^beta);
            end
            sumpp = sum(PP);
            PP = PP / sumpp;
            Pcum = cumsum(PP);
            select = find(Pcum > rand);
            to_visit = LJD(select(1));
            Path = [Path, to_visit];
            DisKm = DisKm + DD(current, to_visit);
            current = to_visit;
            for kk = 1: n
                if TABUkm(kk) == 0
                    DD(current, kk) = 0;
                    DD(kk, current) = 0;
                end
            end
            TABUkm(current) = 0;
            DW = DD(current, :);
            DW1 = find(DW);
            for j = 1: length(DW1)
                if TABUkm(DW1(j)) == 0
                    DW(DW(j)) = 0;
                end
            end
            LJD = find(DW);
            Len_LJD = length(LJD);
        end
        ROUTES{epoch, ant} = Path;
        if Path(end) == stop
            Distance(epoch, ant) = DisKm;
            if DisKm < minkl
                minkl = DisKm;
                mink = epoch;
                minl = ant;
            end
        else
            Distance(epoch, ant) = 0;
        end
    end
    Delta_Tau = zeros(n, n);
    for ant = 1: ants
        if Distance(epoch, ant)
            ROUT = ROUTES{epoch, ant};
            TS = length(ROUT) - 1;
            Dis_km = Distance(epoch, ant);
            for s = 1: TS
                x = ROUT(s);
                y = ROUT(s + 1);
                Delta_Tau(x, y) = Delta_Tau(x, y) + q / Dis_km;
                Delta_Tau(y, x) = Delta_Tau(y, x) + q / Dis_km;
            end
        end
    end
    Tau = (1 - rho) * Tau + Delta_Tau;
end
%% 绘图
plotif = 1;
if plotif == 1
    minDis = zeros(epochs, 1);
    for i = 1: epochs
        Dis = Distance(i, :);
        Nonzero = find(Dis);
        PLK = Dis(Nonzero);
        minDis(i) = min(PLK);
    end
    figure(1);
    plot(minDis);
    hold on;
    grid on;
    title('收敛曲线变化趋势'); 
    xlabel('迭代次数'); 
    ylabel('最小路径长度');
    figure(2) 
    axis([0,mm,0,mm]);
    for i = 1: mm
        for j = 1:mm
            if G(i, j) == 1
                x1 = j - 1; y1 = mm - i;
                x2 = j;y2 = mm - i;
                x3 = j;y3 = mm - i + 1;
                x4 = j - 1;y4 = mm - i + 1;
                fill([x1, x2, x3, x4], [y1, y2, y3, y4],[0.2, 0.2, 0.2]);
                hold on;
            else
                x1 = j - 1; y1 = mm - i;
                x2 = j;y2 = mm - i;
                x3 = j;y3 = mm - i + 1;
                x4 = j - 1;y4 = mm - i + 1;
                fill([x1, x2, x3, x4], [y1, y2, y3, y4],[1, 1, 1]);
                hold on;
            end
        end
    end
    hold on;
    title('机器人运动轨迹'); 
    xlabel('坐标x'); 
    ylabel('坐标y');
    ROUT = ROUTES{mink, minl};
    LENROUT = length(ROUT);
    Rx = ROUT;
    Ry = ROUT;
    for ii = 1: LENROUT
        Rx(ii) = mod(ROUT(ii),mm)-0.5;
        if Rx(ii) == -0.5 
            Rx(ii) = mm - 0.5; 
        end
        Ry(ii) = mm + 0.5 - ceil(ROUT(ii) / mm); 
    end
    plot(Rx, Ry);
end