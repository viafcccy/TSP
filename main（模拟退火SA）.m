clear %所有变量全部删除
clc %清除命令行窗口中的数据
a = 0.99; %温度衰减参数
t0 = 97; tf = 3; t = t0; %初始温度 终值
Markov_length = 10000; %Markov链长度
coordinates = [
1 565.0 575.0;
2 25.0 185.0;
3 345.0 750.0;
4 945.0 685.0;
5 845.0 655.0;
6 880.0 660.0;
7 25.0 230.0;
8 525.0 1000.0;
9 580.0 1175.0;
10 650.0 1130.0;
11 1605.0 620.0;
12 1220.0 580.0;
13 1465.0 200.0;
14 1530.0 5.0;
15 845.0 680.0;
16 725.0 370.0;
17 145.0 665.0;
18 415.0 635.0;
19 510.0 875.0;
20 560.0 365.0;
21 300.0 465.0;
22 520.0 585.0;
23 480.0 415.0;
24 835.0 625.0;
25 975.0 580.0;
26 1215.0 245.0;
27 1320.0 315.0;
28 1250.0 400.0;
29 660.0 180.0;
30 410.0 250.0;
31 420.0 555.0;
32 575.0 665.0;
33 1150.0 1160.0;
34 700.0 580.0;
35 685.0 595.0;
36 685.0 610.0;
37 770.0 610.0;
38 795.0 645.0;
39 720.0 635.0;
40 760.0 650.0;
41 475.0 960.0;
42 95.0 260.0;
43 875.0 920.0;
44 700.0 500.0;
45 555.0 815.0;
46 830.0 485.0;
47 1170.0 65.0;
48 830.0 610.0;
49 605.0 625.0;
50 595.0 360.0;
51 1340.0 725.0;
52 1740.0 245.0;
];
coordinates(:,1) = []; %去除第一行的城市编号
amount = size(coordinates,1); %计算城市个数

%通过向量化的方法计算距离矩阵（保存所有两点之间的距离）
coor_x_tmp1 = coordinates(:,1) * ones(1,amount);
coor_x_tmp2 = coor_x_tmp1';
coor_y_tmp1 = coordinates(:,2) * ones(1,amount);
coor_y_tmp2 = coor_y_tmp1';
dist_matrix = sqrt((coor_x_tmp1 - coor_x_tmp2).^2 + (coor_y_tmp1 - coor_y_tmp2).^2);

%产生初始解
sol_new = 1:amount;
%sol代表当前路线 new代表每次产生的新解 current代表当前解 best代表冷却过程中的最优解
E_current = inf;
E_best = inf;
%E代表目标函数的值 也就是距离和 new代表新解的遍历距离 best最优解
sol_current = sol_new;
sol_best = sol_new;
p = 1; %初始化P

figure;
hold on;
box on;
xlim([tf,t0]);
title('优化过程')
xlabel('当前温度')
ylabel('当前最优解')

while t >= tf %当温度大于停止温度时
    for r = 1:Markov_length %Markov链长度
        %产生随机扰动
        if(rand < 0.5) %随机决定而交换还是三交换
            %二交换
            ind1 = 0; ind2 = 0;
            while(ind1 == ind2)
                ind1 = ceil(rand.*amount); %朝正无穷大四舍五入
                ind2 = ceil(rand.*amount);
            end
            tmp1 = sol_new(ind1);
            sol_new(ind1) = sol_new(ind2);
            sol_new(ind2) = tmp1;
        else
            %三交换
            ind1 = 0; ind2 = 0; ind3 = 0;
            while(ind1 == ind2) || (ind1 == ind3) || (ind2 == ind3) || (abs(ind1 - ind2) == 1) %三变换两个点之间没有路径
                ind1 = ceil(rand.*amount);
                ind2 = ceil(rand.*amount);
                ind3 = ceil(rand.*amount);
            end
                %tmp1 = ind1;tmp2 = ind2;tmp3 = ind3;
                %排序ind1<ind2<ind3
                ind = [ind1 ind2 ind3];
                ind_sort = sort(ind);
                ind1 = ind_sort(1);
                ind2 = ind_sort(2);
                ind3 = ind_sort(3);
                %进行交换
                
                tmplist1 = sol_new((ind1 + 1):(ind2 - 1));
                sol_new((ind1 + 1):(ind1 + ind3 - ind2 + 1)) = sol_new((ind2) : (ind3));
                sol_new((ind1 + ind3 - ind2 + 2):ind3) = tmplist1;
        end
        %检查是否满足约束条件
        %计算目标函数函数值（类比于内能）
        E_new = 0;
        for i = 1 : (amount - 1)
            E_new = E_new + dist_matrix(sol_new(i),sol_new(i+1));
        end
        %加上最后一个到第一个的距离
        E_new = E_new + dist_matrix(sol_new(amount),sol_new(1)); 
        if E_new < E_current %当出现更优解时 更新为更优解的路线和目标函数值
            E_current = E_new;
            sol_current = sol_new;
            if E_new < E_best
                pre_E_best = E_best;
                E_best = E_new;
                sol_best = sol_new;
            end
        else
        %一定范围内接受非优解
            if rand < exp(-(E_new - E_current)./t)
                E_current = E_new;
                sol_current = sol_new;
            else
                sol_new = sol_current;
            end
        end
    end
    pre_t = t;
    t = t.* a;%更新控制参数t为原来的a倍
    line([pre_t,t],[pre_E_best,E_best]);
    pause(0.0001);

end

disp('最优解为:')
for i = 1 : amount
fprintf('->%d', sol_best(i));
end
fprintf('\n');
disp('最短距离为:')
disp(E_best);


